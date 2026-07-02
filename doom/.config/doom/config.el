;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-
(custom-theme-set-faces! 'doom-nord-light
  `(tab-bar :foreground ,(doom-color 'bg))
  `(internal-border :foreground ,(doom-color 'bg))
  `(mode-line-active :background ,(doom-color 'red) :foreground ,(doom-color 'bg))
  `(doom-modeline-evil-normal-state :foreground ,(doom-color 'bg))
  `(doom-modeline-evil-insert-state :foreground ,(doom-color 'bg))
  `(doom-modeline-evil-visual-state :foreground ,(doom-color 'bg))
  `(doom-modeline-evil-operator-state :foreground ,(doom-color 'bg))
  `(doom-modeline-evil-replace-state :foreground ,(doom-color 'bg))
  `(doom-modeline-evil-motion-state :foreground ,(doom-color 'bg))
  `(doom-modeline-evil-emacs-state :foreground ,(doom-color 'bg))
  `(doom-modeline-evil-user-state :foreground ,(doom-color 'bg))
  `(doom-modeline-buffer-path :foreground ,(doom-color 'bg))
  `(doom-modeline-buffer-file :foreground ,(doom-color 'bg) :weight bold)
  `(doom-modeline-buffer-modified :foreground ,(doom-color 'bg))
  `(doom-modeline-info :foreground ,(doom-color 'bg))
  `(doom-modeline-project-dir :foreground ,(doom-color 'bg) :weight bold)
  `(doom-modeline-bar :foreground ,(doom-color 'bg))
  `(doom-modeline-buffer-major-mode :foreground ,(doom-color 'bg) :weight bold)
  `(doom-modeline-urgent :foreground ,(doom-color 'bg))
  `(doom-modeline-warning :foreground ,(doom-color 'bg)))

(custom-theme-set-faces! 'doom-nord
  `(tab-bar :foreground ,(doom-color 'bg)))

(custom-theme-set-faces! 'doom-nord-aurora
  `(tab-bar :foreground ,(doom-color 'bg)))

(defvar doom-theme-light 'doom-nord-light
  "The theme to use on light-mode systems.")
(defvar doom-theme-dark 'doom-nord-aurora
  "The theme to use on dark-mode systems.")

(setq doom-themes-enable-italic t
      doom-themes-enable-bold t
      doom-theme doom-theme-light)

;; Just to update themes in real time while configuring them
(load-theme doom-theme-light t)

;; - `doom-font' default font;
;; - `doom-variable-pitch-font' non-monospace font;
;; - `doom-big-font' for `doom-big-font-mode';
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif';
(setq doom-font (font-spec :family "IBM Plex Mono" :size 13)
      doom-variable-pitch-font (font-spec :family "IBM Plex Mono" :size 13))
;; To apply the modifications to the current session, select the two lines region
;; with the Visual-Line Mode (S-v), and `eval-region' with SPC m e r. Then, finally
;; run `doom/reload-font' with SPC h r f.

(setq spacious-padding-widths
      '( :internal-border-width 16
         :header-line-width 2
         :mode-line-width 0
         :tab-width 2
         :right-divider-width 16))
(spacious-padding-mode 1)

;; Credits: https://github.com/tecosaur/emacs-config/blob/master/config.org
(setq-default
 delete-by-moving-to-trash t                      ; Delete files to trash
 window-combination-resize t                      ; take new window space from all other windows (not just current)
 x-stretch-cursor t)                              ; Stretch cursor to the glyph width

(setq undo-limit 80000000                         ; Raise undo-limit to 80Mb
      evil-want-fine-undo t                       ; By default while in insert all changes are one big blob. Be more granular
      auto-save-default t                         ; Nobody likes to loose work, I certainly don't
      truncate-string-ellipsis "…"                ; Unicode ellispis are nicer than "...", and also save /precious/ space
      password-cache-expiry nil                   ; I can trust my computers ... can't I?
      scroll-preserve-screen-position 'always     ; Don't have `point' jump around
      scroll-margin 8                             ; It's nice to maintain a little margin
      display-time-default-load-average nil)      ; I don't think I've ever found this useful

(display-time-mode 1)                             ; Enable time in the mode-line
(global-subword-mode 1)                           ; Iterate through CamelCase words

(setq evil-vsplit-window-right t
      evil-split-window-below t)

;; Prompts for buffer to open on new Evil splits
(defadvice! prompt-for-buffer (&rest _)
  :after '(evil-window-split evil-window-vsplit)
  (consult-buffer))

;; Open `*doom*' dashboard on default splits
(defadvice! split-on-doom (&rest _)
  :after '(split-window-below split-window-right)
  (other-window 1)
  (switch-to-buffer "*doom*"))

;; Go to the dashboard on the current window

;; Making the extra mouse buttons a little more useful
(setq better-jumper-context 'window)
(setq better-jumper-new-window-behavior 'copy)

(map! :n [mouse-8] #'tab-bar-switch-to-next-tab
      :n [mouse-9] #'tab-bar-switch-to-prev-tab)

;; Define user information
(setq user-full-name "Diogo Bonofre"
      user-mail-address "diogobonofre@gmail.com")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

(setq org-directory "/Documents/org/")
(setq org-return-follows-link t)

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `with-eval-after-load' block, otherwise Doom's defaults may override your
;; settings. E.g.
;;
;;   (with-eval-after-load 'PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look them up).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys

;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-tomorrow-night)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
(setq-default shell-file-name "/bin/bash")
(define-key global-map (kbd "C-x b") 'switch-to-buffer)
(define-key global-map (kbd "C-x B") '+vertico/switch-workspace-buffer)
(global-set-key (kbd "C-z") nil)
(defun my/start-ansi-term-with-fish ()
        (interactive)
        (ansi-term "/usr/bin/fish"))
(global-set-key (kbd "C-c C-t") 'my/start-ansi-term-with-fish)
(setq! fancy-splash-image nil)

(setq backup-by-copying t ; Don't clobber symlinks

      backup-directory-alist '(("." . "~/.macsbackup/backup")) ; Don't litter my filesystem tree

      delete-old-versions t

      kept-new-versions 6

      kept-old-versions 2

      version-control t) ; Use versioned backups

(setq auto-save-file-name-transforms `((".*" "~/.macsbackup/" t)))
(global-set-key (kbd "C-!") 'shell-command)
(require 'obsidian)
(obsidian-specify-path "~/Documents/Notes-obsid/")
;; If you want a different directory of `obsidian-capture':
;;(setq obsidian-inbox-directory "~/Documents/Notes-obsid")
;; Clicking on a wiki link referring a non-existing file the file can be
;; created in the inbox (t) or next to the file with the link (nil).
;; Default: t - creating in the inbox
;(setq obsidian-wiki-link-create-file-in-inbox nil)
;; You may want to define a folder for daily notes. By default it is the inbox.
(setq obsidian-daily-notes-directory "DailyNotes")
;; Directory of note templates, unset (nil) by default
;(setq obsidian-templates-directory "Templates")
;; Daily Note template name - requires a template directory. Default: Daily Note Template.md
;(setq obsidian-daily-note-template "Daily Note Template.md")


;; Define obsidian-mode bindings
;(add-hook
 ;'obsidian-mode-hook
 ;(lambda ()
   ;; Replace standard command with Obsidian.el's in obsidian vault:
   ;;(local-set-key (kbd "C-c C-o") 'obsidian-follow-link-at-point)

   ;; Use either `obsidian-insert-wikilink' or `obsidian-insert-link':
   ;;(local-set-key (kbd "C-c C-l") 'obsidian-insert-wikilink)

   ;; Following backlinks
   ;;(local-set-key (kbd "C-c C-b") 'obsidian-backlink-jump)))

;; Optionally you can also bind a few functions:
;; replace "YOUR_BINDING" with the key of your choice:
;(global-set-key (kbd "YOUR_BINDING") 'obsidian-jump)       ;; Opening a note
;(global-set-key (kbd "YOUR_BINDING") 'obsidian-capture)    ;; Capturing a new note in the inbox
;(global-set-key (kbd "YOUR_BINDING") 'obsidian-daily-note) ;; Creating daily note

;; Activate detection of Obsidian vault
(global-obsidian-mode t)
(defun my-weebery-is-always-greater ()
  (let* ((banner '("🆈🅰🅳🅰 "))
         (longest-line (apply #'max (mapcar #'length banner))))
    (put-text-property
     (point)
     (dolist (line banner (point))
       (insert (+doom-dashboard--center
                +doom-dashboard--width
                (concat line (make-string (max 0 (- longest-line (length line))) 32)))
               "\n"))
     'face 'doom-dashboard-banner)))

(setq +doom-dashboard-ascii-banner-fn #'my-weebery-is-always-greater)

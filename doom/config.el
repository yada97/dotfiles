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
;; Example `config.el` content

;; Set theme
(setq doom-theme 'doom-challenger-deep)

;; Problematic line might be here
;; (setq my-var files) ; 'files' might be undefined

;; Ensure variables are defined correctly

;; Load theme
(load-theme doom-theme t)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
;;(setq display-line-numbers-type t)
(setq line-numbers-mode nil)
(setq explicit-shell-file-name "/bin/bash")



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

(defun my-find-file-from-home ()
  "Opens find-file with initial directory set to ~"
  (interactive)
  (let ((default-directory "~/"))
    (call-interactively #'find-file)))
(global-set-key (kbd "C-x f") 'my-find-file-from-home)


(global-set-key (kbd "C-x t l") 'doom/toggle-line-numbers)


(setq display-line-numbers-type nil)






(define-key global-map (kbd "C-x b") 'switch-to-buffer)
(define-key global-map (kbd "C-x B") '+vertico/switch-workspace-buffer)

(global-set-key (kbd "C-z") nil)

(defun my/start-ansi-term-with-fish ()
        (interactive)
        (ansi-term "/usr/bin/fish"))
(global-set-key (kbd "C-c C-t") 'my/start-ansi-term-with-fish)
(setq! fancy-splash-image nil)

(setq backup-by-copying t ; Don't clobber symlinksn

      backup-directory-alist '(("." . "~/.macsbackup/backup")) ; Don't litter my filesystem tree

      delete-old-versions t

      kept-new-versions 6

      kept-old-versions 2

      version-control t) ; Use versioned backups

(setq auto-save-file-name-transforms `((".*" "~/.macsbackup/" t)))
(global-set-key (kbd "C-c h") 'shell-command)
(require 'obsidian)
(obsidian-specify-path "~/Documents/OrbNotes/")
;;(obsidian-specify-path "~//home/yada/Documents/WorkDir/Gulag/viator.bc/viator.o/")
;; If you want a different directory of `obsidian-capture':
;;(setq obsidian-inbox-directory "~/Documents/Notes-obsid")
;; Clicking on a wiki link referring a non-existing file the file can be
;; created in the inbox (t) or next to the file with the link (nil).
;; Default: t - cr-eating in the inbox
;(setq obsidian-wiki-link-create-file-in-inbox nil)
;; You may want to define a folder for daily notes. By default it is the inbox.
(setq obsidian-daily-notes-directory "DailyNotes")
;; Directory of note templates, unset (nil) by default
;(setq obsidian-templates-directory "Templates")
;(setq obsidian-daily-note-template "Daily Note Template.md")
;; Daily Note template name - requires a template directory. Default: Daily Note Template.md
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

(global-set-key (kbd "C-c d") 'next-buffer)
(global-set-key (kbd "C-c C-d") 'previous-buffer)
;; Optionally you can also bind a few functions:
;; replace "YOUR_BINDING" with the key of your choice:
(global-set-key (kbd "C-c o j") 'obsidian-jump)       ;; Opening a note
(global-set-key (kbd "C-c o c") 'obsidian-capture)    ;; Capturing a new note in the inbox
(global-set-key (kbd "C-c o n") 'obsidian-daily-note) ;; Creating daily note
(global-set-key (kbd "C-c b") 'obsidian-specify-path)
(global-set-key (kbd "C-x C-b") 'switch-to-buffer)
;;(evil-mode 0)

;; Activate detection of Obsidian vault
(global-obsidian-mode t)
(defun my-weebery-is-always-grater ()
  (let* ((banner '("≋y≋a≋d≋a≋"))
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
(defun list-markdown-files ()
  (interactive)
  (require 'vertico)
  (vertico-mode 1) ; Activate Vertico mode
  (let* ((directories '("/usr/share/PayloadsAllTheThings/"
                         "/home/yada/Documents/WorkDir/Reads/wstg/document/4-Web_Application_Security_Testing/"
                         "/home/yada/Documents/WorkDir/Reads/CheatSheetSeries/cheatsheets/"))
         (files (mapcan (lambda (dir)
                          (directory-files-recursively dir "\\.md$"))
                        directories))
         (formatted-files (mapcar (lambda (file)
                                    (let* ((dir-name (file-name-directory file))
                                           (base-name (file-name-nondirectory file))
                                           (source (cond ((string-match-p "/PayloadsAllTheThings/" dir-name) "PayloadAllTheThings   ]->")
                                                        ((string-match-p "/wstg/document/4-Web_Application_Security_Testing/" dir-name) "WebSecurity           ]->")
                                                        ((string-match-p "/CheatSheetSeries/cheatsheets/" dir-name) "Cheatsheet            ]->")
                                                         (t ""))))

                                      (cons (format "%-30s%-30s" source base-name) file)))
                                  files))
         (file-info (completing-read "Markdown files: " formatted-files nil t))
         (selected-file (cdr (assoc file-info formatted-files))))
    (find-file selected-file) ; Open the selected file
    (markdown-view-mode)))

(global-set-key (kbd "C-c m") 'list-markdown-files)

(defun pentest-notes ()
  (interactive)
  (require 'vertico)
  (vertico-mode 1)
  (let* ((directories '("/home/yada/Documents/WorkDir/Gulag/viator.bc/viator.o"
                        "/home/yada/Documents/WorkDir/Gulag/Templates/pen-notes/pen-notes"
                        "/home/yada/Documents/WorkDir/Gulag/grind.h1/grind.o"
                        "/home/yada/Documents/WorkDir/Gulag/circlebbp.h1/circlebbp.o"
                        "/home/yada/Documents/WorkDir/Gulag/coda.h1/coda.o"
                        "/home/yada/Documents/WorkDir/Gulag/earlywarning.h1/earlyw.o"
                       ))
         (files (mapcan (lambda (dir)
                          (directory-files-recursively dir "\\.md$"))
                        directories))
         (formatted-files (mapcar (lambda (file)
                                    (let* ((dir-name (file-name-directory file))
                                           (base-name (file-name-nondirectory file))
                                           (source (cond ((string-match-p "/viator.bc/viator.o" dir-name)             "A.2 viator       ]->")
                                                         ((string-match-p "/pen-notes/pen-notes" dir-name)            "~ *              ]->")
                                                         ((string-match-p "/grind.h1/grind.o" dir-name)               "A.1 grindr       ]->")
                                                         ((string-match-p "/coda.h1/coda.o" dir-name)                 "A.3 coda         ]->")
                                                         ((string-match-p "/circlebbp.h1/circlebbp.o" dir-name)       "A.4 CircleBBP    ]->")
                                                         ((string-match-p "/earlywarning.h1/earlyw.o" dir-name)       "A.5 earlywarn    ]->")
                                                         (t ""))))
                                      (cons (format "%-30s%-30s" source base-name) file)))
                                  files))
         (file-info (completing-read "Markdown files: " formatted-files nil t))
         (selected-file (cdr (assoc file-info formatted-files))))
    (find-file selected-file) ; Open the selected file
    (markdown-view-mode)))

(global-set-key (kbd "C-c u") 'pentest-notes)
(global-set-key (kbd "C-c C-b") 'kill-some-buffers)

(global-set-key (kbd "C-c C-a") 'centaur-tabs-mode)
;;(global-set-key (kbd "C-c C-a") 'centaur-tabs--create-new-tab)

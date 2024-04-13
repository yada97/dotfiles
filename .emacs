(custom-set-variables
 ;; phew
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(manoj-dark))
 '(menu-bar-mode nil)
 '(package-selected-packages '(obsidian yuck-mode melpa-upstream-visit))
 '(tool-bar-mode nil)
 '(tooltip-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
;(setq backup-directory-alist '(("." . "~/.macsbackup/backup/")))
;;(setq auto-save-file-name-transforms '((".*" ,"~/.macsbackup" t)))
(setq-default shell-file-name "/bin/bash")
(defun my/start-ansi-term-with-fish ()
  "Start an ANSI term buffer with the Fish shell."
  (interactive)
  (ansi-term "/usr/bin/fish"))

(global-set-key (kbd "C-c t") 'my/start-ansi-term-with-fish)

;(setq backup-by-copying t)
(setq backup-by-copying t ; Don't clobber symlinks

      backup-directory-alist '(("." . "~/.macsbackup/backup")) ; Don't litter my filesystem tree

      delete-old-versions t

      kept-new-versions 6

      kept-old-versions 2

      version-control t) ; Use versioned backups

(setq auto-save-file-name-transforms `((".*" "~/.macsbackup/" t)))


(setq elfeed-feeds
      '("https://www.example.com/feed.xml"
        "https://www.example.com/feed2.xml"))
(global-set-key (kbd "C-z") nil)
(global-set-key (kbd "C-!") 'shell-command)


;;(defun custom-mode-line ()
  ;;(set-face-foreground 'mode-line "blue")
  ;; Set the background color to black
  ;;(set-face-background 'mode-line "black")
  ;;(set-face-background 'mode-line-highlight "black")
  
  ;; Refresh the mode line to apply the changes
  ;;(force-mode-line-update))

;; Call the function to apply the customization
 ;;(custom-mode-line)








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

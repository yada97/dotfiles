(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(manoj-dark))
 '(menu-bar-mode nil)
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



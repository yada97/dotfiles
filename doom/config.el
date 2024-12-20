;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face


;; Set theme
(setq doom-theme 'doom-homage-black )
;;(setq doom-theme 'doom-acario-dark)
;; Load theme
(load-theme doom-theme t)
(setq line-numbers-mode nil)
(setq explicit-shell-file-name "/bin/bash")
(setq org-directory "~/org/")
(require 'rust-mode)
(defun my-find-file-from-home ()
  "Opens find-file with initial directory set to ~"
  (interactive)
  (let ((default-directory "~/"))
    (call-interactively #'find-file)))

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

(setq obsidian-daily-notes-directory "DailyNotes")
(defun my-obsidian-specify-path ()
  "Set the Obsidian path to '~/Documents/OrbNotes/'."
  (interactive)
  (obsidian-specify-path "~/Documents/OrbNotes/"))

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
                         "/home/yada/Documents/WorkDir/Reads/CheatSheetSeries/cheatsheets/"
                        "/home/yada/Documents/WorkDir/Reads/vulnerability-Checklist"))
         (files (mapcan (lambda (dir)
                          (directory-files-recursively dir "\\.md$"))
                        directories))
         (formatted-files (mapcar (lambda (file)
                                    (let* ((dir-name (file-name-directory file))
                                           (base-name (file-name-nondirectory file))
                                           (source (cond ((string-match-p "/PayloadsAllTheThings/" dir-name) "PayloadAllTheThings   ]->")
                                                        ((string-match-p "/wstg/document/4-Web_Application_Security_Testing/" dir-name) "WebSecurity           ]->")
                                                        ((string-match-p "/CheatSheetSeries/cheatsheets/" dir-name) "Cheatsheet            ]->")
                                                        ((string-match-p "/vulnerability-Checklist/" dir-name) "Vuln-Cheat                      ]->")
                                                         (t ""))))

                                      (cons (format "%-30s%-30s" source base-name) file)))
                                  files))
         (file-info (completing-read "Markdown files: " formatted-files nil t))
         (selected-file (cdr (assoc file-info formatted-files))))
    (find-file selected-file) ; Open the selected file
    (markdown-view-mode)))

(defun pentest-notes ()
  (interactive)
  (require 'vertico)
  (vertico-mode 1)
  (defun read-lines-from-file (file-path)
    (with-temp-buffer
      (insert-file-contents file-path)
      (split-string (buffer-string) "\n" t)))
  (let* ((directories (read-lines-from-file "/home/yada/Documents/WorkDir/Gulag/programs.txt")))
    (defvar source-mapping '())
    (let ((source-lines (read-lines-from-file "/home/yada/Documents/WorkDir/Gulag/mappings.txt")))
      (dolist (line source-lines)
        (let ((split (split-string line "->")))
          (add-to-list 'source-mapping (cons (string-trim (car split)) (string-trim (cadr split)))))))
    (defun find-source-label (dir-name)
      (catch 'found
        (dolist (pair source-mapping)
          (when (string-match-p (car pair) dir-name)
            (throw 'found (cdr pair))))
        ""))
    (let* ((files (mapcan (lambda (dir)
                            (directory-files-recursively dir "\\.md$"))
                          directories))
           ;; Sort files by directory name
           (sorted-files (sort files (lambda (a b)
                                       (string< (file-name-directory a) (file-name-directory b)))))
           (formatted-files (mapcar (lambda (file)
                                      (let* ((dir-name (file-name-directory file))
                                             (base-name (file-name-nondirectory file))
                                             (source (find-source-label dir-name)))
                                        (cons (format "%-30s%-30s" source base-name) file)))
                                    sorted-files))
           (file-info (completing-read "Markdown files: " formatted-files nil t))
           (selected-file (cdr (assoc file-info formatted-files))))
      (find-file selected-file) ; Open the selected file
      (markdown-view-mode))))
;; we recommend using use-package to organize your init.el
(use-package codeium
    ;; if you use straight
    ;; :straight '(:type git :host github :repo "Exafunction/codeium.el")
    ;; otherwise, make sure that the codeium.el file is on load-path

    :init
    ;; use globally
    (add-to-list 'completion-at-point-functions #'codeium-completion-at-point)
    ;; or on a hook
    ;; (add-hook 'python-mode-hook
    ;;     (lambda ()
    ;;         (setq-local completion-at-point-functions '(codeium-completion-at-point))))

    ;; if you want multiple completion backends, use cape (https://github.com/minad/cape):
    ;; (add-hook 'python-mode-hook
    ;;     (lambda ()
    ;;         (setq-local completion-at-point-functions
    ;;             (list (cape-super-capf #'codeium-completion-at-point #'lsp-completion-at-point)))))
    ;; an async company-backend is coming soon!

    ;; codeium-completion-at-point is autoloaded, but you can
    ;; optionally set a timer, which might speed up things as the
    ;; codeium local language server takes ~0.2s to start up
    ;; (add-hook 'emacs-startup-hook
    ;;  (lambda () (run-with-timer 0.1 nil #'codeium-init)))

    ;; :defer t ;; lazy loading, if you want
    :config
    (setq use-dialog-box nil) ;; do not use popup boxes

    ;; if you don't want to use customize to save the api-key
    ;; (setq codeium/metadata/api_key "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx")

    ;; get codeium status in the modeline
    (setq codeium-mode-line-enable
        (lambda (api) (not (memq api '(CancelRequest Heartbeat AcceptCompletion)))))
    (add-to-list 'mode-line-format '(:eval (car-safe codeium-mode-line)) t)
    ;; alternatively for a more extensive mode-line
    ;; (add-to-list 'mode-line-format '(-50 "" codeium-mode-line) t)

    ;; use M-x codeium-diagnose to see apis/fields that would be sent to the local language server
    (setq codeium-api-enabled
        (lambda (api)
            (memq api '(GetCompletions Heartbeat CancelRequest GetAuthToken RegisterUser auth-redirect AcceptCompletion))))
    ;; you can also set a config for a single buffer like this:
    ;; (add-hook 'python-mode-hook
    ;;     (lambda ()
    ;;         (setq-local codeium/editor_options/tab_size 4)))

    ;; You can overwrite all the codeium configs!
    ;; for example, we recommend limiting the string sent to codeium for better performance
    (defun my-codeium/document/text ()
        (buffer-substring-no-properties (max (- (point) 3000) (point-min)) (min (+ (point) 1000) (point-max))))
    ;; if you change the text, you should also change the cursor_offset
    ;; warning: this is measured by UTF-8 encoded bytes
    (defun my-codeium/document/cursor_offset ()
        (codeium-utf8-byte-length
            (buffer-substring-no-properties (max (- (point) 3000) (point-min)) (point))))
    (setq codeium/document/text 'my-codeium/document/text)
    (setq codeium/document/cursor_offset 'my-codeium/document/cursor_offset))



(global-set-key (kbd "C-c m") 'list-markdown-files)
(global-set-key (kbd "C-c u") 'pentest-notes)
(global-set-key (kbd "C-c C-b") 'kill-some-buffers)
(global-set-key (kbd "C-c C-a") 'centaur-tabs-mode)
(global-set-key (kbd "C-c d") 'next-buffer)
(global-set-key (kbd "C-c C-d") 'previous-buffer)
(global-set-key (kbd "C-c o j") 'obsidian-jump)       ;; Opening a note
(global-set-key (kbd "C-c o c") 'obsidian-capture)    ;; Capturing a new note in the inbox
(global-set-key (kbd "C-c o n") 'obsidian-daily-note) ;; Creating daily note
(global-set-key (kbd "C-c b") 'obsidian-specify-path)
(global-set-key (kbd "C-x C-b") 'switch-to-buffer)
(global-set-key (kbd "C-x f") 'my-find-file-from-home)
(global-set-key (kbd "C-x t l") 'doom/toggle-line-numbers)
(global-set-key (kbd "C-c r") 'my-obsidian-specify-path)
;;;; Mouse scrolling in terminal emacs
(unless (display-graphic-p)
  ;; activate mouse-based scrolling
  (xterm-mouse-mode 1)
  (global-set-key (kbd "<mouse-4>") 'scroll-down-line)
  (global-set-key (kbd "<mouse-5>") 'scroll-up-line)
  )

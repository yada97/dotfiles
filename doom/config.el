;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face


;; Set theme
(setq doom-theme 'doom-challenger-deep)
;; Load theme
(load-theme doom-theme t)
(setq line-numbers-mode nil)
(setq explicit-shell-file-name "/bin/bash")
(setq org-directory "~/org/")

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

(defun pentest-notes ()
  (interactive)
  (require 'vertico)
  (vertico-mode 1)
  ;; Function to read lines from a file and return them as a list
  (defun read-lines-from-file (file-path)
    "Read lines from FILE-PATH and return them as a list."
    (with-temp-buffer
      (insert-file-contents file-path)
      (split-string (buffer-string) "\n" t)))

  ;; Load directories from the directories.txt file
  (let* ((directories (read-lines-from-file "/home/yada/Documents/WorkDir/Gulag/programs.txt")))

    ;; Load source mappings from sources.txt
    (defvar source-mapping '())
    (let ((source-lines (read-lines-from-file "/home/yada/Documents/WorkDir/Gulag/mappings.txt")))
      (dolist (line source-lines)
        (let ((split (split-string line "->")))
          (add-to-list 'source-mapping (cons (string-trim (car split)) (string-trim (cadr split)))))))

    ;; Function to find the appropriate source label
    (defun find-source-label (dir-name)
      "Find the appropriate source label for DIR-NAME using the source-mapping."
      (catch 'found
        (dolist (pair source-mapping)
          (when (string-match-p (car pair) dir-name)
            (throw 'found (cdr pair))))
        ""))

    ;; Retrieve the list of markdown files and format them
    (let* ((files (mapcan (lambda (dir)
                            (directory-files-recursively dir "\\.md$"))
                          directories))
           (formatted-files (mapcar (lambda (file)
                                      (let* ((dir-name (file-name-directory file))
                                             (base-name (file-name-nondirectory file))
                                             (source (find-source-label dir-name)))
                                        (cons (format "%-30s%-30s" source base-name) file)))
                                    files))
           (file-info (completing-read "Markdown files: " formatted-files nil t))
           (selected-file (cdr (assoc file-info formatted-files))))
      (find-file selected-file) ; Open the selected file
      (markdown-view-mode))))




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

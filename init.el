;;disable splash screen
(setq inhibit-startup-message t)
(setq emacs-path "~/.emacs.d/")

(set-face-attribute 'default nil :height 100)

;;avoid Control-z from freezing UI
(global-unset-key (kbd "C-z"))

;;set undo on Control-z
(defalias 'redo 'undo-tree-redo)
(global-set-key (kbd "C-z") 'undo)
(global-set-key (kbd "C-S-z") 'redo)

;; Show trailing whitespace and tabs
(require 'whitespace)
(setq whitespace-style '(face tabs tab-mark trailing))
(global-whitespace-mode t)
(custom-set-faces
 '(whitespace-trailing ((t (:background "dark orange"))))
)

;;disable menu-bar & tool-bar
(tool-bar-mode -1)

;; scroll one line at a time (less "jumpy" than defaults)

(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time

(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling

(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse

(setq scroll-step 1) ;; keyboard scroll one line at a time

(setq-default indent-tabs-mode nil) ;;indent no tab

(setq tab-width 4)
(setq nxml-child-indent 3)

;;;;;;;;;;;;;;
;; Ido mode ;;
;;;;;;;;;;;;;;

(require 'ido)
(require 'ido-vertical-mode)
(require 'ido-ubiquitous)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)
(ido-vertical-mode 1)
(ido-ubiquitous-mode 1)

;;;;;;;;;;;;;;;
;; Smex mode ;;
;;;;;;;;;;;;;;;

;; Ido for M-x
(require 'smex)
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)

(setq ag-highlight-search t) ;; ag-highlight

;;auto-complete
(setq ac-auto-start 3)

;; Selected text is owritten when tapping anything
(delete-selection-mode t)

;;Magit
(setq magit-auto-revert-mode nil)

;;lisp
;;;; This file was created automatically by the Quicklisp library
;;;; "quicklisp-slime-helper" from the "quicklisp" dist.

(setq quicklisp-slime-helper-dist "quicklisp")

 (setq quicklisp-slime-helper-base
       (if load-file-name
           (file-name-directory load-file-name)
         (expand-file-name "~/quicklisp/")))
 (defun quicklisp-slime-helper-file-contents (file)
   (with-temp-buffer
     (insert-file-contents file)
     (buffer-string)))

 (defun quicklisp-slime-helper-slime-directory ()
   (let ((location-file (concat quicklisp-slime-helper-base
                                "dists/"
                               quicklisp-slime-helper-dist
                                "/installed/systems/swank.txt")))
     (when (file-exists-p location-file)
       (let ((relative (quicklisp-slime-helper-file-contents location-file)))
         (file-name-directory (concat quicklisp-slime-helper-base
                                      relative))))))

 (let* ((quicklisp-slime-directory (quicklisp-slime-helper-slime-directory)))
   (add-to-list 'load-path quicklisp-slime-directory)
   (require 'slime-autoloads)
   (setq slime-backend (expand-file-name "swank-loader.lisp"
                                         quicklisp-slime-directory))
   (setq slime-path quicklisp-slime-directory)
   (slime-setup '(slime-fancy)))

  ;; Replace "sbcl" with the path to your implementation
  (setq inferior-lisp-program "/usr/bin/clisp")


;;;;;;;;;;;;;;;;;;;;;;;;;;
;; autosave, backup ... ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;

;; ;; disable auto-save if needed...
;; (setq auto-save-default nil)

;; Stop creating this .# symlinks (they where broken anyway) (emacs >= 24.3)
(setq create-lockfiles nil)

(setq
backup-by-copying t ; don't clobber symlinks
backup-directory-alist '(("." . "/home/marin/.saves")) ; don't litter my fs tree
delete-old-versions t
kept-new-versions 6
kept-old-versions 2
version-control t) ; use versioned backups

;; same thing for autosave
(setq backup-directory-alist
`((".*" . ,"/home/marin/.saves/")))
(setq auto-save-file-name-transforms
`((".*" ,"/home/marin/.saves/" t)))


(server-start)

;; (setq flycheck-jshintrc "/Users/tuxella/.jshintrc")
(add-hook 'after-init-hook #'global-flycheck-mode)
(add-hook 'prog-mode-hook 'company-mode)

(require 'org)
;; Truncated line
(setq org-startup-truncated nil)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)

(setq org-agenda-files (list "~/org/todo/rnd.org"
                             "~/org/todo/criteo.org"
                             "~/org/notes/criteo.org"))



(setq org-agenda-custom-commands
`(
;; Agenda view for the next 10 days
("Z" "enioka only" agenda "-HABIT"
((org-agenda-span 10)
(org-deadline-warning-days 2)
(org-agenda-files (quote ("~/org/perso/calendar.org")))
(org-agenda-filter-by-tag-refine "-HABIT")
(org-agenda-sorting-strategy
'(todo-state-up time-up priority-up))))
))

(setq org-hide-leading-stars t)
(setq org-startup-indented t)

(add-to-list 'load-path "~/.emacs.d/neotree")
(require 'neotree)
(global-set-key [f8] 'neotree-toggle)

(setq magit-auto-revert-mode nil)

(load-theme 'stekene-dark t)

;;; go!

(setenv "GOPATH" "/home/marin/goprojects/")
(setenv "PATH" (concat (getenv "PATH") ":" "/"))
(require 'go-autocomplete)
(require 'auto-complete-config)
(ac-config-default)
(setq exec-path (append exec-path (list (expand-file-name "/home/marin/goprojects/bin/"))))

;;; remove trailing white spaces before save
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;;; forecast api key
(setq forecast-api-key "a480c32ee6905e59db2c91adf97791e9")
(setq forecast-latitude 48.8567)
(setq forecast-longitude 2.3508)
(setq forecast-city "Paris")
(setq forecast-country "France")

;;; nxml-mode
;path to where nxml is
(set 'nxml-path (concat emacs-path "nxml-mode/"))

(load (concat nxml-path "rng-auto.el"))

 (add-to-list 'auto-mode-alist
              (cons (concat "\\." (regexp-opt '("xml" "xsd" "sch" "rng" "xslt" "svg" "rss") t) "\\'")
                    'nxml-mode))

  (unify-8859-on-decoding-mode)

    (setq magic-mode-alist
	  (cons '("<＼＼?xml " . nxml-mode)
                magic-mode-alist))

(fset 'xml-mode 'nxml-mode)
(fset 'html-mode 'nxml-mode)

;;hl-tags
(load (concat emacs-path "hl-tags-mode.el"))
(require 'hl-tags-mode)
   (add-hook 'sgml-mode-hook (lambda () (hl-tags-mode 1)))
(add-hook 'nxml-mode-hook (lambda () (hl-tags-mode 1)))

;;color-picker
(global-set-key (kbd "C-c e c") #'zenity-cp-color-at-point-dwim)

(provide 'init)
;;; init.el ends

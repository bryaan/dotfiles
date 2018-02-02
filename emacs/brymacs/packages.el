; (defconst emacs-d
;   (file-name-directory
;    (file-chase-links load-file-name))
;   "The giant turtle on which the world rests.")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'package)
(setq package-enable-at-startup nil) ; tells emacs not to load any packages before starting up
;; the following lines tell emacs where on the internet to look up
;; for new packages.
(setq package-archives '(("org"          . "http://orgmode.org/elpa/")
                         ("gnu"          . "http://elpa.gnu.org/packages/")
                         ("melpa"        . "https://melpa.org/packages/")
                         ("marmalade"    . "http://marmalade-repo.org/packages/")))
(package-initialize) ; guess what this one does ?

;; Bootstrap `use-package'
(unless (package-installed-p 'use-package) ; unless it is already installed
  (package-refresh-contents) ; update packages archive
  (package-install 'use-package)) ; and install the most recent version of use-package

; https://github.com/jwiegley/use-package#use-packageel-is-no-longer-needed-at-runtime
(eval-when-compile
  (require 'use-package))
; (require 'diminish)                ;; if you use :diminish
; (require 'bind-key)                ;; if you use any :bind variant



; (use-package ace-window :ensure t)


; (setq package-user-dir
;       (expand-file-name "elpa" emacs-d))
; (package-initialize)
; (setq package-archives
;       '(("melpa" . "http://melpa.org/packages/")
;         ("gnu" . "http://elpa.gnu.org/packages/")))
; (package-refresh-contents)

; (defconst ora-packages
;   '(ac-cider
;     ace-link
;     ace-window
;     ace-popup-menu
;     alert
;     auto-compile
;     auto-yasnippet
;     auctex
;     cmake-mode
;     company
;     counsel
;     define-word
;     eclipse-theme
;     function-args
;     geiser
;     google-c-style
;     gtk-pomodoro-indicator
;     which-key
;     headlong
;     helm-make
;     hideshowvis
;     j-mode
;     jedi
;     company-jedi
;     ivy-hydra
;     lispy
;     magit
;     make-it-so
;     markdown-mode
;     netherlands-holidays
;     org-bullets
;     org-download
;     powerline
;     projectile
;     find-file-in-project
;     rainbow-mode
;     request
;     slime
;     smex
;     swiper
;     ukrainian-holidays
;     use-package
;     vimish-fold
;     wgrep
;     worf
;     yaml-mode)
;   "List of packages that I like.")

; ;; install required
; (dolist (package ora-packages)
;   (unless (package-installed-p package)
;     (ignore-errors
;       (package-install package))))

; ;; upgrade installed
; (save-window-excursion
;   (package-list-packages t)
;   (package-menu-mark-upgrades)
;   (condition-case nil
;       (package-menu-execute t)
;     (error
;      (package-menu-execute))))
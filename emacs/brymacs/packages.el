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


; (setq package-user-dir
;       (expand-file-name "elpa" emacs-d))
; (package-initialize)
; (setq package-archives
;       '(("melpa" . "http://melpa.org/packages/")
;         ("gnu" . "http://elpa.gnu.org/packages/")))
; (package-refresh-contents)

;     ac-cider
;     ace-link
;     ace-window
;     ace-popup-menu
;     alert
;     auto-compile
;     auto-yasnippet
;     auctex
;     cmake-mode
;     company
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
;     ukrainian-holidays
;     vimish-fold
;     wgrep
;     worf
;     yaml-mode

(defconst brymacs-packages
  '(general
    paradox
    use-package
    async
    which-key
    avy
    ace-window
    multiple-cursors
    projectile
    undo-tree
    evil
    smartparens
    magit
    amx
    counsel
    swiper
    windmove
    smex
    spaceline)
  "List of packages that I like.")

;; install required
(dolist (package brymacs-packages)
  (unless (package-installed-p package)
    (ignore-errors
      (package-install package))))

; ;; upgrade installed - ora approach
; (save-excursion
;   (package-list-packages t)
;   (package-menu-mark-upgrades)
;   (condition-case nil
;       (package-menu-execute t)
;     (error
;      (package-menu-execute))))

;; === paradox package manager ===
;; To upgrade manually, run:
;; paradox-upgrade-packages
; (require 'paradox)
; (paradox-enable)
(use-package paradox
   :init
   ;;(setq paradox-github-token t)
   ;;(setq paradox-automatically-star t)
   (setq paradox-execute-asynchronously t)
   :config
   (paradox-enable))


;;; oremacs
;;* Base directory

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
; (package-initialize)

(defvar emacs-d
  (file-name-directory
   (file-chase-links load-file-name))
  "The giant turtle on which the world rests.")
(setq package-user-dir
      (expand-file-name "elpa" emacs-d))


;; User Info
(setq user-full-name "Bryan A. Rivera")
(setq user-mail-address "mail@bryaan.com")


; When Melpa download not found error occurs
; M-x package-refresh-contents

;; === Packages ===
(load-file "~/.emacs.d/packages.el")


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; https://sam217pa.github.io/2016/09/02/how-to-build-your-own-spacemacs/

(setq delete-old-versions -1 )    ; delete excess backup versions silently
(setq version-control t )   ; use version control
(setq vc-make-backup-files t )    ; make backups file even when in version controlled dir
;TODO (setq backup-directory-alist `(("." . "~/.emacs.d/backups")) ) ; which directory to put backups file
(setq vc-follow-symlinks t )               ; don't ask for confirmation when opening symlinked file
;TODO (setq auto-save-file-name-transforms '((".*" "~/.emacs.d/auto-save-list/" t)) ) ;transform backups file name
(setq inhibit-startup-screen t )  ; inhibit useless and old-school startup screen
(setq ring-bell-function 'ignore )  ; silent bell when you make a mistake
(setq coding-system-for-read 'utf-8 ) ; use utf-8 by default
(setq coding-system-for-write 'utf-8 )
(setq sentence-end-double-space nil)  ; sentence SHOULD end with only a point.
(setq default-fill-column 80)   ; toggle wrapping text at the 80th character
(setq initial-scratch-message "Welcome in Emacs") ; print a default message in the empty scratch buffer opened at startup


;; Enables line numbers for all files
(global-linum-mode)

;; Enables line number in all programming modes
; (add-hook 'prog-mode-hook 'linum-mode)

;; TODO Claims to be more-efficient than linum
; (use-package nlinum :ensure t)
; (nlinum-mode)

;; https://github.com/tom-tan/hlinum-mode Highlight line

;; So undo-tree plays well with linum
;; https://www.emacswiki.org/emacs/UndoTree
(defun undo-tree-visualizer-update-linum (&rest args)
    (linum-update undo-tree-visualizer-parent-buffer))
(advice-add 'undo-tree-visualize-undo :after #'undo-tree-visualizer-update-linum)
(advice-add 'undo-tree-visualize-redo :after #'undo-tree-visualizer-update-linum)
(advice-add 'undo-tree-visualize-undo-to-x :after #'undo-tree-visualizer-update-linum)
(advice-add 'undo-tree-visualize-redo-to-x :after #'undo-tree-visualizer-update-linum)
(advice-add 'undo-tree-visualizer-mouse-set :after #'undo-tree-visualizer-update-linum)
(advice-add 'undo-tree-visualizer-set :after #'undo-tree-visualizer-update-linum)


(use-package avy :ensure t
  :commands (avy-goto-word-1))

(use-package general :ensure t
  :config
  (general-define-key "C-'" 'avy-goto-word-1)
  )



(use-package ace-window :ensure t
  :config
  (general-define-key "M-o" 'ace-window)
  (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
  )


(use-package which-key
  :ensure t
  :pin melpa)
(which-key-mode)

(general-define-key
 :prefix "C-c"
 ;; bind to simple key press
  "b" 'ivy-switch-buffer  ; change buffer, chose using ivy
  "/"   'counsel-git-grep   ; find string in git project
  ;; bind to double key press
  "f"   '(:ignore t :which-key "files")
  "ff"  'counsel-find-file
  "fr"  'counsel-recentf
  "p"   '(:ignore t :which-key "project")
  "pf"  '(counsel-git :which-key "find file in git dir")
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Evil - Extensible Vi Layer
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; https://github.com/emacs-evil/evil

;; Required by evil. TODO make req of evil
(use-package undo-tree :ensure t)
(global-undo-tree-mode)

; TODO "C-_" Undo   "M-_" Redo


(use-package evil :ensure t)
(evil-mode 1)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Counsel, Ivy, Swiper
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; find-file-in-project and .
;;
;; "C-x l" counsel-locate - fuzzy search in all directories
;;
;; thanks for the pointers; i've settled on projectile with ivy
;; completion and a nice hydra for it to
;; call projectile-find-file and some other projectile functions.

;; TODO smex is supposed to work also but was having trouble. try it again.

;; amx - smex replacement
;; Listens for ivy-mode and auto binds backend to ivy.
;; https://github.com/DarwinAwardWinner/amx
(add-to-list 'load-path "~/.emacs.d/local/")
(require 'amx)


(use-package counsel :ensure t)

;; So counsel doesn't open dired when pressing <enter> on a directory.
;; https://emacs.stackexchange.com/questions/33701/do-not-open-dired-for-directories-when-using-counsel-find-file
(with-eval-after-load 'counsel
  (let ((done (where-is-internal #'ivy-done     ivy-minibuffer-map t))
        (alt  (where-is-internal #'ivy-alt-done ivy-minibuffer-map t)))
    ;; (define-key counsel-find-file-map done #'ivy-alt-done) ;; replaced with next line.
    (define-key ivy-minibuffer-map done #'ivy-alt-done) ;; To swap all ivy- completed commands.
    (define-key counsel-find-file-map alt  #'ivy-done)))

(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
(global-set-key "\C-s" 'swiper)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "<f6>") 'ivy-resume)
(global-set-key (kbd "M-x M-p") 'ivy-previous-history-element) ;; command history
; (global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "M-x") 'amx) ;; amx uses counsel-M-x as backend
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "<f1> f") 'counsel-describe-function)
(global-set-key (kbd "<f1> v") 'counsel-describe-variable)
(global-set-key (kbd "<f1> l") 'counsel-find-library)
(global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
(global-set-key (kbd "<f2> u") 'counsel-unicode-char)
(global-set-key (kbd "C-c g") 'counsel-git)
(global-set-key (kbd "C-c j") 'counsel-git-grep)
(global-set-key (kbd "C-c k") 'counsel-ag)
(global-set-key (kbd "C-x l") 'counsel-locate)
(global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
(define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history)



(use-package swiper
  :ensure t
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (global-set-key "\C-s" 'swiper)
  (global-set-key (kbd "C-c C-r") 'ivy-resume)
  ; (global-set-key (kbd "M-x") 'counsel-M-x)
  (global-set-key (kbd "C-x C-f") 'counsel-find-file))


; https://github.com/jwiegley/use-package#use-package-ensure-system-package
; (use-package tern
;   :ensure-system-package (tern . "npm i -g tern"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; macos.el
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; TODO Move this macos.el

;; https://sam217pa.github.io/2016/09/01/emacs-iterm-integration/

;; TODO is this useful?
;; https://github.com/ataylor284/emacs-shell-mode-iterm-extensions


(defun iterm-goto-filedir-or-home ()
  "Go to present working dir and focus iterm"
  (interactive)
  (do-applescript
   (concat
    " tell application \"iTerm2\"\n"
    "   tell the current session of current window\n"
    (format "     write text \"cd %s\" \n"
            ;; string escaping madness for applescript
            (replace-regexp-in-string "\\\\" "\\\\\\\\"
                                      (shell-quote-argument (or default-directory "~"))))
    "   end tell\n"
    " end tell\n"
    " do shell script \"open -a iTerm\"\n"
    ))
  )

(defun iterm-focus ()
  "Focus the iTerm2 app, without modifying the working directory"
  (interactive)
  (do-applescript
   " do shell script \"open -a iTerm\"\n"
   ))

(general-define-key
 :states '(normal visual insert emacs)
 :prefix "SPC"
  "'" '(iterm-focus :which-key "focus iterm")
  "?" '(iterm-goto-filedir-or-home :which-key "focus iterm - goto dir")
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Do Not Modify Below Here
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (bigint nlinum counsel use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;; brymacs
;;* Base directory


;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

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

;; === Third-party manually installed packages ===
(add-to-list 'load-path "~/.emacs.d/local/")

;; === Packages ===
(load-file "~/.emacs.d/packages.el")
(load-file "~/.emacs.d/keys.el")
(load-file "~/.emacs.d/iterm.el")

;; === Themes ===
;; M-x customize-themes
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")


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
(setq initial-scratch-message "Welcome to Emacs") ; print a default message in the empty scratch buffer opened at startup


;; To start in fullscreen mode.
; (set-frame-parameter nil 'fullscreen 'fullboth)

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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Gives us helper functions to describe commands and define their shortcuts
(use-package general :ensure t)

;; Gives us the helpful shortcut hints next to commands
(use-package which-key
  :ensure t
  :pin melpa)
(which-key-mode)


(use-package avy
  :ensure t
  :commands (avy-goto-word-1))

(use-package ace-window
  :ensure t
  :config
  (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Evil - Extensible Vi Layer
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; https://github.com/emacs-evil/evil

;; Required by evil. TODO make req of evil
(use-package undo-tree :ensure t)
(global-undo-tree-mode)

(use-package evil :ensure t)
(evil-mode 1)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Counsel, Ivy, Swiper
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; TODO smex is supposed to work also but was having trouble. try it again.

;; amx - smex replacement
;; Listens for ivy-mode and auto binds backend to ivy.
;; https://github.com/DarwinAwardWinner/amx
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


; (ivy-mode 1)
; (setq ivy-use-virtual-buffers t)
; (setq enable-recursive-minibuffers t)
(use-package swiper
  :ensure t
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq enable-recursive-minibuffers t))


; https://github.com/jwiegley/use-package#use-package-ensure-system-package
; (use-package tern
;   :ensure-system-package (tern . "npm i -g tern"))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Do Not Modify Below Here
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#2d3743" "#ff4242" "#74af68" "#dbdb95" "#34cae2" "#008b8b" "#00ede1" "#e1e1e0"])
 '(custom-enabled-themes (quote (dracula)))
 '(custom-safe-themes
   (quote
    ("eb25c68d3959c31d34021aa722d5ea1c53ea69714580b2b8c150592becf412cf" "ff7625ad8aa2615eae96d6b4469fcc7d3d20b2e1ebc63b761a349bebbb9d23cb" default)))
 '(fci-rule-color "#000000")
 '(package-selected-packages (quote (dracula-theme bigint nlinum counsel use-package)))
 '(vc-annotate-background "#2f2f2f")
 '(vc-annotate-color-map
   (quote
    ((20 . "#dc322f")
     (40 . "#D01A4E")
     (60 . "#cb4b16")
     (80 . "#b58900")
     (100 . "#b58900")
     (120 . "#b58900")
     (140 . "#5f127b")
     (160 . "#5f127b")
     (180 . "#859900")
     (200 . "#859900")
     (220 . "#859900")
     (240 . "#859900")
     (260 . "#2aa198")
     (280 . "#268bd2")
     (300 . "#268bd2")
     (320 . "#268bd2")
     (340 . "#94BFF3")
     (360 . "#d33682"))))
 '(vc-annotate-very-old-color "#d33682"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

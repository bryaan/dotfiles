;; keys.el
;;

(general-define-key
  :states '(normal visual insert emacs)
  :prefix "SPC"
  :non-normal-prefix "M-SPC"
  ;; bind to simple key press
  "/"   'swiper  ;; I think swiper works within the file.
  ;; "/"   'counsel-git-grep ;; whereas this works in the current git project

  ;; === files ===
  "f"   '(:ignore t :which-key "files")
  "ff"  'counsel-find-file
  "fr"  'counsel-recentf
  "fp"  '(counsel-git :which-key "find file in git dir")
  ;; === buffers ===
  "b"   '(:ignore t :which-key "buffers")
  "bb"  'ivy-switch-buffer
  ;; === projects ===
  "p"   '(:ignore t :which-key "projects")
  "pf"  '(counsel-git :which-key "find file in git dir"))

(general-define-key
 :prefix "C-c"
 ;; bind to simple key press
  "b"   'ivy-switch-buffer  ; change buffer, chose using ivy
  "/"   'counsel-git-grep   ; find string in git project
  ;; bind to double key press
  "f"   '(:ignore t :which-key "files")
  "ff"  'counsel-find-file
  "fr"  'counsel-recentf
  "p"   '(:ignore t :which-key "project")
  "pf"  '(counsel-git :which-key "find file in git dir"))

(global-set-key (kbd "M-x") 'amx) ;; amx uses counsel-M-x as backend
;(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key "\C-s" 'swiper)


(global-set-key (kbd "<f1> f") 'counsel-describe-function)
(global-set-key (kbd "<f1> v") 'counsel-describe-variable)
(global-set-key (kbd "<f1> l") 'counsel-find-library)
(global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
(global-set-key (kbd "<f2> u") 'counsel-unicode-char)


(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "C-x l") 'counsel-locate) ;; fuzzy search in all directories
;; find-file-in-project
;;
;; thanks for the pointers; i've settled on projectile with ivy
;; completion and a nice hydra for it to
;; call projectile-find-file and some other projectile functions.

(global-set-key (kbd "C-c g") 'counsel-git)
(global-set-key (kbd "C-c j") 'counsel-git-grep)
(global-set-key (kbd "C-c k") 'counsel-ag)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
; (global-set-key (kbd "<f6>") 'ivy-resume)

;; TODO What do these do?
; (global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
; (define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history)
; (global-set-key (kbd "M-x M-p") 'ivy-previous-history-element)

;; === evil ===
(general-evil-setup t)
(mmap "j" 'evil-next-visual-line
      "k" 'evil-previous-visual-line)

;; === undo-tree ===
(global-set-key (kbd "C-_") 'undo-tree-undo)
(global-set-key (kbd "M-_") 'undo-tree-redo)

;; === avy ===
(general-define-key
  "M-g l" 'avy-goto-line
  "M-g w" 'avy-goto-word-1
  "M-g c" 'avy-goto-char
  "C-'"   'avy-goto-word-1
  "C-:"   'avy-goto-char)

;; === ace-window ===
(general-define-key "M-o" 'ace-window)

;; === iterm.el ===
(general-define-key
 :states '(normal visual insert emacs)
 :prefix "SPC"
 :non-normal-prefix "M-SPC" ;; in insert mode this is used instead. TODO xmodmap bc M-SPC is system reserved.
  "'" '(iterm-focus :which-key "focus iterm")
  "?" '(iterm-goto-filedir-or-home :which-key "focus iterm - goto dir"))


; Find File (same as C-x f)
; SPC f f

; Switch Buffers (same as C-x b)
; SPC b b

; Opens neotree
; SPC f t

; Close Split Window (current window)
; C-x 0

; C-z
; Suspend Emacs (suspend-emacs) or iconify a frame (iconify-or-deiconify-frame).

; C-x C-c
; Kill Emacs (save-buffers-kill-emacs).


;; vim - cut & paste
; yy - yank (copy) a line.
; 2yy - yank 2 lines.
; yw - yank word.
; y$ - yank to end of line.
; p - put (paste) the clipboard after cursor.
; P - put (paste) before cursor.
; dd - delete (cut) a line.
; dw - delete (cut) the current word.



; C-g  Like vim ESC

; C-x  Main Commands
; C-c  User Keybindings
;     - Note that only `C-c ...` are allowed as `C-c C-...` are used by system and apps.


; x stands for “execute”.

; ### C-x + ... ###

; C-s  Save file
; C-c  Quit Emacs

; b    Switch Buffers
; k    Kill Buffer

; C-;  Comment line



; C-d  List directory
; C-f  Find files
; SPC f f  Find files

;;;; The Help Key
; Control-h is the help key;
;
; To find out about any mode, type control-h m
; while in that mode.  For example, to find out
; about mail mode, enter mail mode and then type
; control-h m.



; kill-buffer-and-window   C-x 4 0

; evil-quit-all
; regular quit emacs






; http://steve-yegge.blogspot.com/2007/02/my-save-excursion.html
;
; C-x h M-| wc
; Spelled out: mark-whole-buffer then shell-command-on-region with wc.
; Works on *scratch* and any other buffer.
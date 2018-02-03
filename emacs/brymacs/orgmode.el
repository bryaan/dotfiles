;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; org-mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Using ord mode capture to link everything
; TODO https://orgmode.org/manual/Using-capture.html#Using-capture

; http://doc.norang.ca/org-mode.html#KeyBindings

; TODO Continue here
; http://doc.norang.ca/org-mode.html#FastTodoSelection
; http://doc.norang.ca/org-mode.html
; https://orgmode.org/org.html#Installation

(general-define-key
  "<f12>" 'org-agenda
  "C-c c" 'counsel-org-capture ;;'org-capture
)

(general-define-key
 ;; :states '(normal visual insert emacs)
 :prefix "C-c"
  "l" 'org-store-link
  "a" 'org-agenda
  "c" 'org-capture
  "b" 'org-iswitchb)



;; TODO add %a or %A so it links to where is came from
(setq org-remember-templates '((?n "* TODO %?\n  %i\n")))


(setq org-directory "~/org")
(setq org-default-notes-file "~/org/refile.org")

;; !!! counsel-org-capture
;; org-capture=finalize to save and close window or w/e


;; Capture templates for:
;; TODO tasks, Notes, appointments, phone calls, meetings, and org-protocol
(setq org-capture-templates
      (quote (("t" "todo" entry (file "~/org/refile.org")
               "* TODO %?\n%U\n%a\n" :clock-in t :clock-resume t)
              ("r" "respond" entry (file "~/org/refile.org")
               "* NEXT Respond to %:from on %:subject\nSCHEDULED: %t\n%U\n%a\n" :clock-in t :clock-resume t :immediate-finish t)
              ("n" "note" entry (file "~/org/refile.org")
               "* %? :NOTE:\n%U\n%a\n" :clock-in t :clock-resume t)
              ("j" "Journal" entry (file+datetree "~/org/diary.org")
               "* %?\n%U\n" :clock-in t :clock-resume t)
              ("w" "org-protocol" entry (file "~/org/refile.org")
               "* TODO Review %c\n%U\n" :immediate-finish t)
              ("m" "Meeting" entry (file "~/org/refile.org")
               "* MEETING with %? :MEETING:\n%U" :clock-in t :clock-resume t)
              ("p" "Phone call" entry (file "~/org/refile.org")
               "* PHONE %? :PHONE:\n%U" :clock-in t :clock-resume t)
              ("h" "Habit" entry (file "~/org/refile.org")
               "* NEXT %?\n%U\n%a\nSCHEDULED: %(format-time-string \"%<<%Y-%m-%d %a .+1d/3d>>\")\n:PROPERTIES:\n:STYLE: habit\n:REPEAT_TO_STATE: NEXT\n:END:\n"))))

; Files with the .org extension use Org mode by default.
; To turn on Org mode in a file that does not have the extension .org,
; make the first line of a file look like this:
;
; MY PROJECTS    -*- mode: org; -*-
;
;  See also the variable org-insert-mode-line-in-empty-file.


(setq org-todo-keywords
      (quote ((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)")
              (sequence "WAITING(w@/!)" "HOLD(h@/!)" "|" "CANCELLED(c@/!)" "PHONE" "MEETING"))))

(setq org-todo-keyword-faces
      (quote (("TODO" :foreground "red" :weight bold)
              ("NEXT" :foreground "blue" :weight bold)
              ("DONE" :foreground "forest green" :weight bold)
              ("WAITING" :foreground "orange" :weight bold)
              ("HOLD" :foreground "magenta" :weight bold)
              ("CANCELLED" :foreground "forest green" :weight bold)
              ("MEETING" :foreground "forest green" :weight bold)
              ("PHONE" :foreground "forest green" :weight bold))))
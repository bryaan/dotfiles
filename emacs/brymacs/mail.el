;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; mu4e
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; http://www.djcbsoftware.nl/code/mu/mu4e.html

; Installation
; http://www.djcbsoftware.nl/code/mu/mu4e/Installation.html#Installation
;
; Configurations for mu4e
; http://www.djcbsoftware.nl/code/mu/mu4e/Example-configurations.html#Example-configurations

;; Postfix
;; If mu4e fails then do postfix instead. Here is a great how to:
; https://linode.com/docs/email/postfix/configure-postfix-to-send-mail-using-gmail-and-google-apps-on-debian-or-ubuntu/


; nix-env -i mu
; nix-env -i offlineimap
;

(add-to-list 'load-path
  (concat (getenv "OHOME") "/.nix-profile/share/emacs/site-lisp/mu4e/"))

(require 'mu4e)


;; Finish Configuring for gmail.
;; TODO http://www.djcbsoftware.nl/code/mu/mu4e/Gmail-configuration.html#Gmail-configuration

;; TODO don't use real gmail password, use an app password, and also pull from private 
;; store. Definitely go with private store instead of gitignore to reduce prob of mistakes.

;; But it seems like offlineimap will reuiqre some sort of integration to secure the pw
;; otherwise the ~/.offlineimaprc file must go to private folder.

; (setq
;    message-send-mail-function   'smtpmail-send-it
;    smtpmail-default-smtp-server "smtp.example.com"
;    smtpmail-smtp-server         "smtp.example.com"
;    smtpmail-local-domain        "example.com")

;; TODO we replaced the HOME for starting emacs
;; Only needed if your maildir is _not_ ~/Maildir
;; Must be a real dir, not a symlink
; (setq mu4e-maildir "/home/user/Maildir")

;; these must start with a "/", and must exist
;; (i.e.. /home/user/Maildir/sent must exist)
;; you use e.g. 'mu mkdir' to make the Maildirs if they don't
;; already exist

; (setq mu4e-sent-folder   "/sent")
; (setq mu4e-drafts-folder "/drafts")
; (setq mu4e-trash-folder  "/trash")



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; org-mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


; (use-package org-mu4e
;   :ensure t
;   :config
;   ;;store link to message if in header view, not to header query
;   (setq org-mu4e-link-query-in-headers-mode nil)
; )

;; http://pragmaticemacs.com/emacs/master-your-inbox-with-mu4e-and-org-mode/
; TODO Said he had more stuff for mail.
;
; The beauty of this is that hitting C-c c t now generates a todo item that
; contains a link to the email you are currently viewing. So you have zero
; friction in creating a todo item to e.g. reply to an email by a certain
; deadline, and you can happily archive that email knowing that clicking
; the link in the todo item will take you directly back to it.
;
; (setq org-capture-templates
;       '(("t" "todo" entry (file+headline "~/todo.org" "Tasks")
;          "* TODO [#A] %?\nSCHEDULED: %(org-insert-time-stamp (org-read-date nil t \"+0d\"))\n%a\n")))

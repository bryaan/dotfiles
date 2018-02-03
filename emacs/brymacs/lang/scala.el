(use-package ensime
  :ensure t
  :pin melpa)

;; TODO start ensime server with hook on scala-mode?
(add-hook 'scala-mode-hook
          (lambda ()
            (show-paren-mode)
            (smartparens-mode)
            (yas-minor-mode)
            (git-gutter-mode)
            (company-mode)
            (ensime-mode)
            (scala-mode:goto-start-of-code)))

;; Sometimes I just want a quick, simple, buffer-only completion of what I’m typing, bypassing company-mode and the server. This provides it
(bind-key "C-<tab>" 'dabbrev-expand scala-mode-map)

(setq
   company-dabbrev-ignore-case nil
   company-dabbrev-code-ignore-case nil
   company-dabbrev-downcase nil
   company-idle-delay 0
   company-minimum-prefix-length 0)



(use-package js2-mode
  :ensure t)

(use-package js2-refactor
  :ensure t
  :pin melpa)

(js2r-add-keybindings-with-prefix "C-c C-m")
(add-hook 'js2-mode-hook #'js2-refactor-mode)
;; js2-refactor does not work in a buffer that has Javascript parse errors.
;; To tell js2-mode to treat hashbangs as comments, which prevents them
;; from causing parse errors, add this:
(setq js2-skip-preprocessor-directives t)



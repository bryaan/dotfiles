;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; iterm.el
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; TODO Move this macos.el or macos/iterm.el

;; https://sam217pa.github.io/2016/09/01/emacs-iterm-integration/

;; TODO is this useful?
;; https://github.com/ataylor284/emacs-shell-mode-iterm-extensions

;; The applescript would probably be better as a file text snippet.
;; Which we then interpolate with vars, or have them inserted at top of file.

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


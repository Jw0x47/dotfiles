;;; PACKAGES
(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

(defun add-to-load-path (x)
  (add-to-list 'load-path (concat "~/.emacs.d/" x)))

;; evil
;; doesn't work
;; (setq evil-default-cursor t)

(add-to-load-path "evil")
(require 'evil)
(evil-mode 1)

;; make it so escape really quits things
(define-key evil-normal-state-map [escape] 'keyboard-quit)
(define-key evil-visual-state-map [escape] 'keyboard-quit)
(define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; fuck tabs
(setq-default indent-tabs-mode nil)

;; disable bell on scroll limit
(defun my-bell-function ()
  (unless (memq this-command
                '(isearch-abort abort-recursive-edit exit-minibuffer
                                keyboard-quit mwheel-scroll down up next-line previous-line
                                backward-char forward-char))
    (ding)))
(setq ring-bell-function 'my-bell-function)

;; ;; markdown
;; (add-to-load-path "markdown-mode-2.0")
;; (require 'markdown-mode)
;; (add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
;; (add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;; ;; flyspell
;; (setq-default ispell-program-name "aspell")
;; (add-hook 'flyspell-mode-hook 'flyspell-buffer)
;; (add-hook 'tex-mode-hook 'flyspell-mode)
;; (add-hook 'latex-mode-hook 'flyspell-mode)

;; ;; solarized
;; (add-to-list 'custom-theme-load-path "~/.emacs.d/solarized")

;; ;; rainbow
;; (global-rainbow-delimiters-mode)


;; ;; theme
;; (custom-set-variables
;;  ;; custom-set-variables was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(custom-enabled-themes (quote (solarized-dark)))
;;  '(custom-safe-themes (quote ("1e7e097ec8cb1f8c3a912d7e1e0331caeed49fef6cff220be63bd2a6ba4cc365" "fc5fcb6f1f1c1bc01305694c59a1a861b008c534cae8d0e48e4d5e81ad718bc6" default)))
;;  '(inhibit-startup-screen t))
;; (custom-set-faces
;;  ;; custom-set-faces was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  )


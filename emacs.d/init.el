;;(mac-add-ignore-shortcut '(control))
;;(setq x-select-enable-clipboard t)


;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)
(setq package-archives
      '(("gnu" . "http://elpa.gnu.org/packages/")
        ("melpa" . "http://melpa.org/packages/")
        ("org" . "http://orgmode.org/elpa/")))

;; path
(defun add-to-load-path (&rest paths)
  (let (path)
    (dolist (path paths paths)
      (let ((default-directory (expand-file-name (concat user-emacs-directory path))))
        (add-to-list 'load-path default-directory)
        (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
            (normal-top-level-add-subdirs-to-load-path))))))

(setq default-tab-width 4)
(define-key global-map [?¥] [?\\])  ;; ¥の代わりにバックスラッシュを入力する

(setq ring-bell-function 'ignore)
(define-key global-map (kbd "C-t") 'other-window)

;\左に行番号表示
(require 'linum)
(global-linum-mode 0)
(column-number-mode t)
(setq linum-format "%4d ")

;; ハイライト
; 行末の空白をハイライト
(setq-default show-trailing-whitespace t)

; 現在行のハイライト
(defface hlline-face
  '((((class color)
      (background dark))
     ;; (:background "dark slate gray"))
     (:background "gray20"))
    (((class color)
      (background light))
     ;; (:background "ForestGreen"))
     (:background "gray20"))
    (t
     ()))
  "*Face used by hl-line.")
(setq hl-line-face 'hlline-face)
;; (setq hl-line-face 'underline) ; 下線
(global-hl-line-mode)

; 対応する括弧のハイライト
(show-paren-mode t)
(setq show-paren-delay 0)
;; (setq show-paren-style 'expression)
(setq show-paren-style 'mixed)

; 矩形選択
(cua-mode t)
(setq cua-enable-cua-keys nil)
(define-key global-map (kbd "C-x SPC") 'cua-set-rectangle-mark)

(global-set-key [f6] 'linum-mode)
(global-set-key [f12] 'shell)

; yaml-mode
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.dig\\'" . yaml-mode))

;; golang
(add-hook 'go-mode-hook (lambda()
			  (setq indent-tabs-mode nil)
			  (setq c-basic-offset 4)
			  (setq tab-width 4)))

(add-hook 'go-mode-hook 'flycheck-mode)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (flycheck go-errcheck flymake-go yaml-mode python-mode golint go-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

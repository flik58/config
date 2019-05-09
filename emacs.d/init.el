;; package
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

;; 環境を日本語、UTF-8にする
(set-locale-environment nil)

;; 各種設定
; バックアップなし
; (setq make-backup-files nil)
; (setq auto-save-default nil)

(setq inhibit-startup-screen t)
(put 'narrow-to-region 'disabled nil)

; indent
(setq-default indent-tabs-mode nil)
(setq-default c-basic-offset 4
              tab-width 4
              indent-tabs-mode nil)

; web-mode
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[gj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(setq web-mode-engines-alist
      '(("php"    . "\\.phtml\\'")
        ("blade"  . "\\.blade\\.")))

(defun web-mode-indent (num)
  (interactive "nIndent: ")
  (setq web-mode-markup-indent-offset num)
  (setq web-mode-css-indent-offset num)
  (setq web-mode-style-padding num)
  (setq web-mode-code-indent-offset num)
  (setq web-mode-script-padding num)
  (setq web-mode-block-padding num)
  )
(web-mode-indent 2)

; yaml-mode
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.dig\\'" . yaml-mode))


(require 'flymake-python-pyflakes)
(require 'flymake-cursor)
(add-hook 'python-mode-hook 'flymake-python-pyflakes-load)

(defun tnoda/turn-on-flycheck-mode ()
  (flycheck-mode 1))
;(add-hook 'python-mode-hook 'tnoda/turn-on-flycheck-mode)
(add-hook 'after-init-hook #'global-flycheck-mode)

;; (when (require 'flymake-python nil t)
;;   (setq flymake-python-syntax-checker "flake8")
;;   )

;; (require 'python-mode)
;; ;; (add-to-list 'auto-mode-alist '("\\\.py\\\'" . python-mode))
;; (add-to-list 'interpreter-mode-alist '("python" . python-mode))

;; (flymake-mode t)
;; ; python-mode
;; (require 'flymake-python-pyflakes)
;; ;; (global-flymake-python-pyflakes-mode 1)
;; (add-hook 'python-mode-hook 'flymake-python-pyflakes-load)
;; (setq flymake-python-pyflakes-executable "flake8")


;\左に行番号表示
(require 'linum)
(global-linum-mode 0)
(column-number-mode t)
(setq linum-format "%4d ")

; highlight
;; (defface my-hl-line-face
;;   '((((class color) (background dark))  ; カラーかつ, 背景が dark ならば,
;;      (:background "DarkSlateBlue" t))   ; 背景を黒に.
;;     (((class color) (background light)) ; カラーかつ, 背景が light ならば,
;;      (:background "gray90" t))     ; 背景を ForestGreen に.
;;      ;; (:background "light cyan" t))     ; 背景を ForestGreen に.
;;     (t (:bold t)))
;;   "hl-line's my face")
;; (setq hl-line-face 'my-hl-line-face)
;; (global-hl-line-mode t)

(setq show-paren-delay 0)
(show-paren-mode t)
(setq show-paren-style 'expression)
(set-face-background 'show-paren-match-face nil)
(set-face-underline-p 'show-paren-match-face "yellow")

; 行末の空白をハイライト
(setq-default show-trailing-whitespace t)

;; User specific define-key
; 矩形選択
(cua-mode t)
(setq cua-enable-cua-keys nil)
(define-key global-map (kbd "C-x SPC") 'cua-set-rectangle-mark)

(require 'tabbar)
(tabbar-mode 1)
;; (global-set-key "" 'tabbar-forward)  ; 次のタブ
;; (global-set-key "\M-[" 'tabbar-backward) ; 前のタブ
; タブ上でマウスホイールを使わない
(tabbar-mwheel-mode nil)
; グループを使わない
(setq tabbar-buffer-groups-function nil)
; 左側のボタンを消す
(dolist (btn '(tabbar-buffer-home-button
               tabbar-scroll-left-button
               tabbar-scroll-right-button))
  (set btn (cons (cons "" nil)
                (cons "" nil))))
; 色設定
(set-face-attribute ; バー自体の色
 'tabbar-default nil
 :background "white"
 :family "Inconsolata"
 :height 1.0)
(set-face-attribute ; アクティブなタブ
 'tabbar-selected nil
 :background "black"
 :foreground "white"
 :weight 'bold
 :box nil)
(set-face-attribute ; 非アクティブなタブ
 'tabbar-unselected nil
 :background "white"
 :foreground "black"
 :box nil)

(setq ring-bell-function 'ignore)
(define-key global-map (kbd "C-t") 'other-window)

(global-set-key [f6] 'linum-mode)
(global-set-key [f7] 'tabbar-mode)
;; (global-set-key [f8] 'flymake-python-pyflakes)
(global-set-key [f12] 'shell)
;; (global-set-key [f10] 'gdb)
;; (global-set-key [f11] 'pdb)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (magit go-errcheck golint go-mode flymake-yaml yaml-mode flycheck flymake-cursor python-mode flymake-python-pyflakes package-utils web-mode tabbar))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

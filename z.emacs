;;; z.emacs --- zyr's priv cfg base on Prelude
;; file name: z.emacs
;; should make a symbol link .emacs to this file in ~ path like:
;; ln -s ~/z.emacs.d/z.emacs .emacs
;; or run a script instead: ./z.init.sh
;; loactions:
;;    Prelude files: .emacs.d
;;      download use: curl -L http://git.io/epre | sh
;;               or : curl -L https://github.com/bbatsov/prelude/raw/master/utils/installer.sh | sh
;; note: backup .emacs and .emacs.d before installing prelude
;;    zyr's cfg files: z.emacs.d

;;; load Prelude
(load "~/.emacs.d/init.el")

(setq prelude-whitespace nil)

;;;spell check zh_CN error
;; use apsell as ispell backend
(setq-default ispell-program-name "aspell")
;; use American English as ispell default dictionary
(ispell-change-dictionary "american" t)

;; load my packages
(if (file-exists-p "~/z.emacs.d/pkgs.el")
    (load "~/z.emacs.d/pkgs.el"))

;;;display time
(display-time)

;;; load normal key-diy file
(if (file-exists-p "~/z.emacs.d/diy-key.el")
    (load "~/z.emacs.d/diy-key.el"))

;; spell check
(setq-default flyspell-mode t)

;;; sbcl & slime
;; ref http://blog.csdn.net/yang_7_46/article/details/8039656
;;sudo apt-get install emacs
;;sudo apt-get install sbcl
;;run sbcl then:
;;(load "/path/to/quicklisp.lisp")
;;(quicklisp-quickstart:install)
;;(ql:add-to-init-file)
;;(ql:quickload "ieee-floats")
;;(ql:quickload "quicklisp-slime-helper")
(if (file-exists-p "~/quicklisp/slime-helper.el")
    (progn (setq inferior-lisp-program "sbcl")
           (load (expand-file-name "~/quicklisp/slime-helper.el"))))

;;;googl-translate
(require 'google-translate)
(global-set-key "\C-xt" 'google-translate-at-point)
(global-set-key "\C-xT" 'google-translate-at-point-reverse)
(global-set-key "\C-xy" 'google-translate-query-translate)
(global-set-key "\C-xY" 'google-translate-query-translate-reverse)
(set-face-attribute 'google-translate-translation-face nil :height 1.4)
(set 'google-translate-enable-ido-completion t)
(set 'google-translate-default-source-language "auto")
(set 'google-translate-default-target-language "zh-CN")

;;; emacs-w3m: an Emacs interface to the w3m text browser
;; require :install w3m first
;(require 'w3m-load) ;加载

;(require 'mime-w3m) ;; todo: fix shift+RET
(eval-after-load "w3m"
  '(progn
     (autoload 'w3m "w3m" "interface for w3m on emacs" t)

     (setq w3m-home-page "https://www.google.com") ;设置主页
     ;; 使用cookies
     (setq w3m-use-cookies t)
     ;; 默认显示图片
     (setq w3m-default-display-inline-images t)
     (setq w3m-default-toggle-inline-images t)
     ;;设定w3m运行的参数，分别为使用cookie和使用框架
     (setq w3m-command-arguments '("-cookie" "-F"))
     ;; 使用w3m作为默认浏览器
     (setq browse-url-browser-function 'w3m-browse-url)
     (setq w3m-view-this-url-new-session-in-background t)
     ;;显示图标
     (setq w3m-show-graphic-icons-in-header-line t)
     (setq w3m-show-graphic-icons-in-mode-line t)
     ))

;;;org-mode 
;; turn off the html-validation-link when export html
(setq org-export-html-validation-link nil)
;; warp line at window edge
(setq org-startup-truncated nil)

;;; windows full screen
(if (and (eq window-system 'w32)
	 (file-exists-p "emacs_fullscreen.exe"))
    (progn
      (defun toggle-full-screen () (interactive) (shell-command "emacs_fullscreen.exe"))
      (global-set-key [f11] 'toggle-full-screen)))

;;; menu-bar tool-bar scroll-bar ;nil:display <0:hide
(menu-bar-mode nil)
(tool-bar-mode -1)
(scroll-bar-mode -1)

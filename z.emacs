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
(setq inferior-lisp-program "sbcl")
(load (expand-file-name "~/quicklisp/slime-helper.el"))


;;; menu-bar tool-bar scroll-bar ;nil:display <0:hide
(menu-bar-mode nil)
(tool-bar-mode -1)
(scroll-bar-mode -1)

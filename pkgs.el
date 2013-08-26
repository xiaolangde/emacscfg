;;; pkgs.el --- zyr's packages config

;;(require 'cl)
;;(require 'package)
;;(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/") t)

(setq package-archives '(("ELPA" . "http://tromey.com/elpa/")
                         ("gnu" . "http://elpa.gnu.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("technomancy" . "http://repo.technomancy.us/emacs/")
                         ("org" . "http://orgmode.org/elpa/")))
;;https://github.com/zane/dotemacs/blob/master/zane-packages.el
(setq zyr-packages
      '(ace-jump-mode
        ace-jump-buffer
        ack-and-a-half
        auto-complete
        diminish
        dired+
;;        ecb
        ediff
        edit-server
        ergoemacs-mode
        exec-path-from-shell
        expand-region
        find-dired
        flycheck
        framemove
        fuzzy
        gist
        git-blame
        git-commit-mode
        gitconfig-mode
        gitignore-mode
        google-translate
        iedit
        ido-ubiquitous
        ido-vertical-mode
        jedi
        key-chord
        kibit-mode
        magit
        multiple-cursors
        nrepl
        org
        paredit
        rainbow-delimiters
        smartparens
        smex
        solarized-theme
        tramp
        undo-tree
        volatile-highlights
        whitespace
        windmove
        yasnippet))

(package-initialize)
;;; install missing packages
(let ((not-installed (remove-if 'package-installed-p zyr-packages)))
  (if not-installed
      (if (y-or-n-p (format "there are %d packages to be installed. install them? "
                            (length not-installed)))
          (progn (package-refresh-contents)
                 (dolist (package not-installed)
                   (package-install package))))))


;;; cedet
;;


;;; ecb : the package ecb-2.40 from offical (http://ecb.sourceforge.net/) or elpa system is not ok
;; now, so modified it  and maintain it self
;; ref1: emacs 24安装ecb与cedet:
;; http://blog.csdn.net/cnsword/article/details/7474119
;; ref2: Install ECB with Emacs Starter Kit in Emacs 24:
;; http://stackoverflow.com/questions/8833235/install-ecb-with-emacs-starter-kit-in-emacs-24
;; modified two files : ecb.el , ecb-upgrade.el

;;comment ecb
(if nil (progn

;; prevent error
(setq stack-trace-on-error t)

;; (require 'cedet)
(add-to-list 'load-path "~/z.emacs.d/pkgs/ecb-2.40")
(require 'ecb) ;;加载ecb

;; 自动启动ecb，并且不显示每日提示
(setq ecb-auto-activate t
      ecb-tip-of-the-day nil)
;; 各窗口间切换
(global-set-key [M-left] 'windmove-left)
(global-set-key [M-right] 'windmove-right)
(global-set-key [M-up] 'windmove-up)
(global-set-key [M-down] 'windmove-down)
;; 隐藏和显示ecb窗口
(define-key global-map [(control f1)] 'ecb-hide-ecb-windows)
(define-key global-map [(control f2)] 'ecb-show-ecb-windows)
;; 使某一ecb窗口最大化
(define-key global-map "\C-c1" 'ecb-maximize-window-directories)
(define-key global-map "\C-c2" 'ecb-maximize-window-sources)
(define-key global-map "\C-c3" 'ecb-maximize-window-methods)
(define-key global-map "\C-c4" 'ecb-maximize-window-history)
;; 恢复原始窗口布局
(define-key global-map "\C-c`" 'ecb-restore-default-window-sizes)

;;end of comment
))


;;; cscope
;; usage: http://cscope.sourceforge.net/large_projects.html
;;1. use find　to collect files to cscope.files
;;2. cscope -b -q -k
;; -b just build(not load GUI) -q(create inverted index) -k(don't
;; include /usr/include for header files

(add-to-list 'load-path "~/z.emacs.d/pkgs/cscope-15.8a/contrib/xcscope")
(require 'xcscope) ;;加载xcscope
;;c模式下加载xcscope
(add-hook 'c-mode-common-hook '(lambda() (require 'xcscope)))
;;绑定按键
(define-key global-map [(control f3)]  'cscope-set-initial-directory)
(define-key global-map [(control f4)]  'cscope-unset-initial-directory)
(define-key global-map [(control f5)]  'cscope-find-this-symbol)
(define-key global-map [(control f6)]  'cscope-find-global-definition)
(define-key global-map [(control f7)]  'cscope-find-global-definition-no-prompting)
(define-key global-map [(control f8)]  'cscope-pop-mark)
(define-key global-map [(control f9)]  'cscope-next-symbol)
(define-key global-map [(control f10)] 'cscope-next-file)
(define-key global-map [(control f11)] 'cscope-prev-symbol)
(define-key global-map [(control f12)] 'cscope-prev-file)
(define-key global-map [(meta f9)]     'cscope-display-buffer)
(define-key global-map [(meta f10)]    'cscope-display-buffer-toggle)
;;关闭每次查找时自动更新cscope.out
(setq cscope-do-not-update-database t)

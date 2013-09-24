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
        auto-complete-clang-async
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
        pos-tip
        rainbow-delimiters
        smartparens
        smex
        solarized-theme
        tramp
        undo-tree
        volatile-highlights
        w3m
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



;;;; cedet
;;
(require 'cedet)
(global-ede-mode t)

;;;  Helper tools.
(custom-set-variables
 '(semantic-default-submodes (quote (
                                     global-semanticdb-minor-mode
                                     ;;enables global support for Semanticdb;
                                     global-semantic-mru-bookmark-mode
                                     ;;enables automatic bookmarking of tags that you edited, so you can return to them later with the semantic-mrub-switch-tags command;
                                     ;global-cedet-m3-minor-mode
                                     ;;activates CEDET's context menu that is bound to right mouse button;
                                     global-semantic-highlight-func-mode
                                     ;;activates highlighting of first line for current tag (function, class, etc.);
                                     global-semantic-stickyfunc-mode
                                     ;;activates mode when name of current tag will be shown in top line of buffer;
                                     global-semantic-decoration-mode
                                     ;;activates use of separate styles for tags decoration (depending on tag's class). These styles are defined in the semantic-decoration-styles list;
                                     global-semantic-idle-local-symbol-highlight-mode
                                     ;;activates highlighting of local names that are the same as name of tag under cursor;
                                     global-semantic-idle-scheduler-mode
                                     ;;activates automatic parsing of source code in the idle time;
                                     global-semantic-idle-completions-mode
                                     ;;activates displaying of possible name completions in the idle time. Requires that global-semantic-idle-scheduler-mode was enabled;
                                     global-semantic-idle-summary-mode
                                     ;;activates displaying of information about current tag in the idle time. Requires that global-semantic-idle-scheduler-mode was enabled.

                                     ;;Following sub-modes are usually useful when you develop and/or debug CEDET:
                                     global-semantic-show-unmatched-syntax-mode
                                     ;;shows which elements weren't processed by current parser's rules;
                                     global-semantic-show-parser-state-mode
                                     ;;shows current parser state in the modeline;
                                     global-semantic-highlight-edits-mode
                                     ;;shows changes in the text that weren't processed by incremental parser yet.

                                     ;global-semantic-decoration-mode
                                     ;global-semantic-idle-completions-mode
                                     ;global-semantic-idle-scheduler-mode
                                     ;global-semanticdb-minor-mode
                                     ;global-semantic-idle-summary-mode
                                     ;global-semantic-mru-bookmark-mode
                                     )))
 '(semantic-idle-scheduler-idle-time 2))

(semantic-mode)


;;; TAGS Menu
(defun my-semantic-hook ()
  (imenu-add-to-menubar "TAGS"))

(add-hook 'semantic-init-hooks 'my-semantic-hook)

;;; smart complitions
(require 'semantic/ia)
(setq-mode-local c-mode semanticdb-find-default-throttle
                 '(project unloaded system recursive))
(setq-mode-local c++-mode semanticdb-find-default-throttle
                 '(project unloaded system recursive))


;;; Semantic DataBase存储位置
(setq semanticdb-default-save-directory
      (expand-file-name "~/z.emacs.d/semanticdb"))

;;; 使用 gnu global 的TAGS。 (uncomment if needed)
;(require 'semantic/db-global)
;(semanticdb-enable-gnu-global-databases 'c-mode)
;(semanticdb-enable-gnu-global-databases 'c++-mode)

;; load ede project
(if (file-exists-p "~/z.emacs.d/ede-project.el")
    (progn
      (global-ede-mode t)
      (load "~/z.emacs.d/ede-project.el")))

;;;;comment
(if t  (progn

;;;  缩进或者补齐
;;; hippie-try-expand settings
(setq hippie-expand-try-functions-list
      '(
        yas/hippie-try-expand
        semantic-ia-complete-symbol
        try-expand-dabbrev
        try-expand-dabbrev-visible
        try-expand-dabbrev-all-buffers
        try-expand-dabbrev-from-kill
        try-complete-file-name-partially
        try-complete-file-name
        try-expand-all-abbrevs))

(defun indent-or-complete ()
  "Complete if point is at end of a word, otherwise indent line."
  (interactive)
  (if (looking-at "\\>")
      (hippie-expand nil)
    (indent-for-tab-command)
    ))

(defun yyc/indent-key-setup ()
  "Set tab as key for indent-or-complete"
  (local-set-key  [(tab)] 'indent-or-complete)
  )
;;end of comment
))

;;; C-mode-hooks .
(defun yyc/c-mode-keys ()
  "description"
  ;; Semantic functions.
  (semantic-default-c-setup)
  (local-set-key "\C-c?" 'semantic-ia-complete-symbol-menu)
  (local-set-key "\C-cb" 'semantic-mrub-switch-tags)
  (local-set-key "\C-cR" 'semantic-symref)
  (local-set-key "\C-cj" 'semantic-ia-fast-jump)
  (local-set-key "\C-cp" 'semantic-ia-show-summary)
  (local-set-key "\C-cl" 'semantic-ia-show-doc)
  (local-set-key "\C-cr" 'semantic-symref-symbol)
  (local-set-key "\C-c/" 'semantic-ia-complete-symbol)
  (local-set-key [(control return)] 'semantic-ia-complete-symbol)
  (local-set-key "." 'semantic-complete-self-insert)
  (local-set-key ">" 'semantic-complete-self-insert)
  ;; Indent or complete
  (local-set-key  [(tab)] 'indent-or-complete)
  )
(add-hook 'c-mode-common-hook 'yyc/c-mode-keys)



;;;;comment ecb (reason: do not want to use it)
(if nil (progn

;;;; ecb : the package ecb-2.40 from offical (http://ecb.sourceforge.net/) or elpa system is not ok
;; now, so modified it  and maintain it self
;; ref1: emacs 24安装ecb与cedet:
;; http://blog.csdn.net/cnsword/article/details/7474119
;; ref2: Install ECB with Emacs Starter Kit in Emacs 24:
;; http://stackoverflow.com/questions/8833235/install-ecb-with-emacs-starter-kit-in-emacs-24
;; modified two files : ecb.el , ecb-upgrade.el

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

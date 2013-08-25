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
        ecb
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

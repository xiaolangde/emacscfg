;;; diy-key.el --- zyr's diy key

;;;set shift-space to 'set-mark-command
(global-set-key [?\S- ] 'set-mark-command)
(global-set-key  (kbd "C-c c") 'set-mark-command)

;;;modify key
;(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\C-c\C-m" 'execute-extended-command)

(global-set-key "\C-w" 'backward-kill-word)
(global-set-key "\C-x\C-k" 'kill-region)
(global-set-key "\C-c\C-k" 'kill-region)


;; 下面这两个键模拟Vi的光标不动屏幕动效果, 我很喜欢, 几乎总在使用.
(global-set-key [(meta n)] 'window-move-up)
(global-set-key [(meta p)] 'window-move-down)
;; 同上, 但是是另一个buffer窗口上下移动. 常常查看帮助用这个.
(global-set-key [(control N)] 'other-window-move-down)
(global-set-key [(control P)] 'other-window-move-up)

;; ------------------------------下面是上面用到的函数定义------------------------------

(defun window-move-up (&optional arg)
  "Current window move-up 2 lines."
  (interactive "P")
  (if arg
      (scroll-up arg)
    (scroll-up-line 2))
  (if arg 
      (previous-line arg)
    (previous-line 2)))

(defun window-move-down (&optional arg)
  "Current window move-down 2 lines."
  (interactive "P")
  (if arg
      (scroll-down arg)
    (scroll-down 2))
  (if arg 
      (next-line arg)
    (next-line 2)))

(defun other-window-move-up (&optional arg)
  "Other window move-up 1 lines."
  (interactive "p")
  (scroll-other-window arg))

(defun other-window-move-down (&optional arg)
  "Other window move-down 2 lines."
  (interactive "P")
  (if arg
      (scroll-other-window-down arg)
    (scroll-other-window-down 2)))

#|
In emacs, to load this file, either:

select buffer: C-x h
eval selection: C-c C-r

or modify pathname as needed and eval this expression:

(load "~/Development/kaveh-common-lisp-lessons/lesson-00.lisp")
|#

(ql:quickload '(:cl-opengl :cl-glu :cl-glut))

(defclass show-window (glut:window)
  ()
  (:default-initargs :pos-x 0 :pos-y 0 :width 512 :height 512
                     :mode '(:single :rgb) :title ""))

(defmethod glut:display-window :before ((w show-window))
  ;; Select clearing color.
  (gl:clear-color 0 0 0 0)
  ;; Initialize viewing values.
  (gl:matrix-mode :projection)
  (gl:load-identity)
  (gl:ortho 0 1 0 1 -1 1))

(defmethod glut:display ((w show-window))
  (gl:clear :color-buffer)
  ;; Draw white polygon (rectangle) with corners at
  ;; (0.25, 0.25, 0.0) and (0.75, 0.75, 0.0).
  (gl:color 1.0 1.0 1.0)
  (gl:with-primitive :line-loop
    (gl:vertex 0.5 0.5 0.0)
    (gl:vertex 0.75 0.25 0)
    (gl:vertex 0.75 0.75 0)
    (gl:vertex 0.25 0.75 0))
  ;; Start processing buffered OpenGL routines.
  (gl:flush))

(defun rb-hello ()
  (glut:display-window (make-instance 'show-window)))

(rb-hello)

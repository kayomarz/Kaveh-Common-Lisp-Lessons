;;;; basic-window.lisp
;;;; OpenGL example code borrowed from cl-opengl
;;(in-package #:cl-glfw3-examples)
(ql:quickload '(:cl-glfw3 :cl-opengl :trivial-main-thread))
(in-package #:cl-user)

(glfw:initialize)

(glfw:init-2)
(glfw:mk-window-2 (:title "Window test" :width 600 :height 400))
(glfw:create-window :title "Window test" :width 600 :height 400)
(gl:clear-color 1.0 0 0 0)
(defun set-viewport (width height)
  (gl:viewport 0 0 width height)
  (gl:matrix-mode :projection)
  (gl:load-identity)
  (gl:ortho -50 50 -50 50 -1 1)
  (gl:matrix-mode :modelview)
  (gl:load-identity))
(set-viewport 600 400)



(unwind-protect
     (progn
       (glfw:with-init
         )
       )
  )


(defmacro with-redraw (&body body)
  `(progn
     (gl:clear :color-buffer)
     (gl:with-pushed-matrix
       (gl:color 1.0 1.0 1.0)
       (gl:line-width 1.0)
       ,@body
       )
     (glfw:swap-buffers)
     ))

(glfw:with-init-2
  (glfw:mk-window-2 (:title "Window test" :width 600 :height 400))
  ;; (setf %gl:*gl-get-proc-address* #'get-proc-address)
  ;; (set-key-callback 'quit-on-escape)
  ;; (set-window-size-callback 'update-viewport)
  (gl:clear-color 1 0 0 0)
  (set-viewport 600 400)
  (glfw:with-context
      (with-redraw
        (gl:begin :line-loop)
        (gl:vertex 25 25 0.0)
        (gl:vertex 25 -25 0.0)
        (gl:vertex -25 -25 0.0)
        (gl:vertex -25 25 0.0)
        (gl:end)
        ))
  )


(glfw:with-init-window-2 (:title "Window test" :width 600 :height 400)
  ;; (setf %gl:*gl-get-proc-address* #'get-proc-address)
  ;; (set-key-callback 'quit-on-escape)
  ;; (set-window-size-callback 'update-viewport)
  (gl:clear-color 1 0 0 0)
  (set-viewport 1600 400)
  (with-redraw
    (gl:begin :line-loop)
    (gl:vertex 25 25 0.0)
    (gl:vertex 25 -25 0.0)
    (gl:vertex -25 -25 0.0)
    (gl:vertex -25 25 0.0)
    (gl:end)
    )
  )



(glfw:with-init-window-2 (:title "Window test" :width 600 :height 400)
  ;; (setf %gl:*gl-get-proc-address* #'get-proc-address)
  ;; (set-key-callback 'quit-on-escape)
  ;; (set-window-size-callback 'update-viewport)
  (gl:clear-color 1 0 0 0)
  (set-viewport 600 400)
  (with-redraw
    (in-package #:glfw)

    (gl:begin :line-loop)
    (gl:vertex 25 25 0.0)
    (gl:vertex 125 -25 0.0)
    (gl:vertex -25 -25 0.0)
    (gl:vertex -25 25 0.0)
    (gl:end)
    (in-package #:cl-user)
    
    )
  )


;; (def-window-size-callback update-viewport (window w h)
;;   (declare (ignore window))
;;   (set-viewport w h))

;; (defun basic-window-example ()
;;   ;; Graphics calls on OS X must occur in the main thread
;;   (trivial-main-thread:with-body-in-main-thread ()
;;     (glfw:with-init-window (:title "Window test" :width 600 :height 400)
;;       ;; (setf %gl:*gl-get-proc-address* #'get-proc-address)
;;       ;; (set-key-callback 'quit-on-escape)
;;       ;; (set-window-size-callback 'update-viewport)
;;       (gl:clear-color 0 0 0 0)
;;       (set-viewport 600 400)
;;       (loop until ()
;;             do (render)
;;             do (glfw:swap-buffers)
;;             do (glfw:poll-events)
;;             ))
;;     ))

;; (glfw:with-init-window (:title "Window test" :width 600 :height 400)
;;   (print "yo")
;;   )

;; (defun draw-square ()
;;   (gl:color 1.0 1.0 1.0)
;;   (gl:line-width 3.0)
;;   (gl:begin :line-loop)
;;   (gl:vertex 25 25 0.0)
;;   (gl:vertex 25 -25 0.0)
;;   (gl:vertex -25 -25 0.0)
;;   (gl:vertex -25 25 0.0)
;;   (gl:end))
;; ;;(draw-square)
;; (basic-window-example)

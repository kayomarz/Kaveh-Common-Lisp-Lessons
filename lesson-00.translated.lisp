;;;; Import necessary libraries
;; (require 'cl-opengl)
;; (require 'cl-glfw)

(ql:quickload '(:cl-glfw3 :cl-opengl))

(in-package :cl-user)

(defparameter *window-width* 512)
(defparameter *window-height* 512)

(defun draw-square ()
  (gl:color 1.0 1.0 1.0)
  (gl:line-width 3.0)
  (gl:begin :line-loop)
  (gl:vertex 0.5 0.5 0.0)
  (gl:vertex 0.5 -0.5 0.0)
  (gl:vertex -0.5 -0.5 0.0)
  (gl:vertex -0.5 0.5 0.0)
  (gl:end))

(defun display ()
  (gl:clear-color 0.0 0.0 0.0 0.0)
  (gl:clear :color-buffer-bit)
  (draw-square)
  (gl:flush))

(defun main ()
    (glfw:init)
    (unwind-protect
         (let ((window (glfw:create-window *window-width* *window-height* "My OpenGL View")))
           (glfw:make-context-current window)
           (glfw:set-input-mode window :sticky-mouse-buttons t)
           (glfw:set-key-callback window
                                  (lambda (window key scancode action mods)
                                    (declare (ignore scancode mods))
                                    (when (and (= action :press) (eql key :key-escape))
                                      (glfw:set-window-should-close window t))))
           (glfw:set-mouse-button-callback window
                                           (lambda (window button action mods)
                                             (declare (ignore button mods))
                                             (when (= action :press)
                                               (display)
                                               (glfw:swap-buffers window))))
           (loop
              (glfw:poll-events)
              (display)
              (glfw:swap-buffers window)
              (when (glfw:window-should-close window)
                (return)))
           (glfw:destroy-window window))
      (glfw:terminate))
  )

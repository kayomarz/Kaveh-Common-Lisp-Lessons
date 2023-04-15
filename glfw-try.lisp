(ql:quickload '(:cl-glfw3 :cl-opengl :trivial-main-thread))
(in-package #:cl-user)


(defmacro def-error-callback (name (message) &body body)
  (let ((error-code (gensym "error-code")))
    `(%glfw:define-glfw-callback ,name
	 ((,error-code :int) (,message :string))
       (declare (ignore ,error-code))
       ,@body)))

(def-error-callback default-error-fun (message)
  (error message))

(defun set-error-callback (callback-name)
  (%glfw:set-error-callback (cffi:get-callback callback-name)))

(defun initialize ()
  "Start GLFW"
  (let ((result (%glfw:init)))
    (unless result
      (error "Error initializing glfw."))
    result))


(defmacro with-init (&body body)
  "Wrap BODY with an initialized GLFW instance, ensuring proper termination. If no error callback is set when this is called, a default error callback is set."
  `(progn
     
     (unwind-protect (progn ,@body)
       (%glfw:terminate))))

(defmacro with-window ((&rest window-keys) &body body)
  "Convenience macro for using windows."
  `(unwind-protect
	(progn
	  (create-window ,@window-keys)
	  ,@body)
     (destroy-window)))

(let ((prev-error-fun (set-error-callback 'default-error-fun)))
  (unless (cffi:null-pointer-p prev-error-fun)
    (%glfw:set-error-callback prev-error-fun)))
(initialize)
(glfw:create-window :title "Window test" :width 600 :height 400)



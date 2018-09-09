(defpackage :discord
  (:use :common-lisp)
  (:export "DISCORDIAN-DATE" "DATETIME" "CURRENT-DT" "*DT*" "MAKE-DATETIME"
	   "PRINT-DISCORDIAN-DATE")
  (:intern "+DAY-NAMES+" "*MONTH-NAMES*" "*SHORT-MONTH-NAMES*")
  (:documentation "Generates a Discordian date from a Gregorian Date"))

(in-package :discord)

(defconstant +DAY-NAMES+ '(
			   "Sweetmorn"
			   "Boomtime"
			   "Pungenday"
			   "Prickle-Prickle"
			   "Setting Orange"
			   ))

(defconstant +MONTH-NAMES+ '(
			     "Chaos"
			     "Discord"
			     "Confusion"
			     "Bureaucracy"
			     "The Aftermath"
			     ))

(defconstant +SHORT-MONTH-NAMES+ '(
				   "Ch"
				   "Dsc"
				   "Cfn"
				   "Bcy"
				   "Afm"
				   ))

(defstruct datetime (hour) (minute) (second) (day) (month) (year))

(defvar *DT* (make-datetime))

(defun CURRENT-DT ()
  (multiple-value-bind
	(second minute hour day month year weekday dst tz)
      (get-decoded-time)
    (declare (ignore weekday))
    (declare (ignore dst))
    (declare (ignore tz))
    (setf (datetime-hour *DT*) hour)
    (setf (datetime-minute *DT*) minute)
    (setf (datetime-second *DT*) second)
    (setf (datetime-day *DT*) day)
    (setf (datetime-month *DT*) month)
    (setf (datetime-year *DT*) year)))

(defun DISCORDIAN-DATE (from to)
  (declare (datetime from))
  (declare (datetime to))
  (let
      (
       (year (datetime-year from))
       (day (datetime-day from))
       (month (datetime-month from)))
    (setf (datetime-year to) (+ year 1166))
    (cond
      ;; January
      ((= month 1) (setf month 0))
      ;; February
      ((= month 2)
       (cond
	 ((= day 29)
	  (setf month -1)
	  (setf day -1))
	 ((eq t t)
	  (setf month 0)
	  (setf day (+ day 31)))))
      ;; March
      ((= month 3)
       (setf day (+ day 59))
       (cond
	 ((<= day 73) (setf month 0))
	 ((eq t t) (setf month 1)
	  (setf day (- day 73)))))
      ;; April
      ((= month 4)
       (setf day (+ day 17))
       (setf month 1))
      ;; May
      ((= month 5)
       (setf day (+ day 47))
       (cond
	 ((<= day 73)
	  (setf month 1))
	 ((eq t t)
	  (setf day (- day 73))
	  (setf month 2))))
      ;; June
      ((= month 6)
       (setf day (+ day 5))
       (setf month 2))
      ;; July
      ((= month 7)
       (setf day (+ day 35))
       (setf month 2))
      ;; August
      ((= month 8)
       (setf day (+ day 66))
       (cond
	 ((<= day 73)
	  (setf month 2))
	 ((eq t t)
	  (setf day (- day 73))
	  (setf month 3))))
      ;; September
      ((= month 9)
       (setf day (+ day 24))
       (setf month 3))
      ;; October
      ((= month 10)
       (setf day (+ day 54))
       (cond
	 ((<= day 73)
	  (setf month 3))
	 ((eq t t)
	  (setf day (- day 73))
	  (setf month 4))))
      ;; November
      ((= month 11)
       (setf day (+ day 12))
       (setf month 4))
      ;; December
      ((= month 12)
       (setf day (+ day 42))
       (setf month 4)))
    (setf (datetime-day to) day)
    (setf (datetime-month to) month)
    ))

(defun print-discordian-date (from to)
  (declare (datetime from))
  (declare (datetime to))
  (let
      (
       (from-year (datetime-year from))
       (from-day (datetime-day from))
       (from-month (datetime-month from))
       (to-year (datetime-year to))
       (to-day (datetime-day to))
       (to-month (datetime-month to))
       (day-name nil)
       (month-name nil)
       (short-month-name nil)
       (offset 1))
    (cond
      ((= to-month 1)
       (cond ((> to-day 16) (setf offset (- 0 2))) ((eq t t) (setf offset 3))))
      ((= to-month 2) (setf offset 0))
      ((= to-month 3) (setf offset 2))
      ((= to-month 4) (setf offset (- 0 1))))
    (setf day-name
	  (nth (mod (- to-day offset) (length +DAY-NAMES+)) +DAY-NAMES+))
    (setf month-name
	   (nth (mod to-month (length +MONTH-NAMES+)) +MONTH-NAMES+))
    (setf short-month-name
	  (nth (mod to-month (length +SHORT-MONTH-NAMES+)) +SHORT-MONTH-NAMES+))
    (format nil "~D-~D-~D->~D-~D-~D:~T~A, ~A ~D in the YOLD ~D~T~D~A~D"
	    from-year from-month from-day
	    to-year to-month to-day
	    day-name month-name
	    to-day to-year
	    to-day short-month-name
	    to-year)))

(defun toplevel (&rest args)
  (declare (ignore args))
  (let ((ddate (make-datetime)))
    (current-dt)
    (discordian-date *dt* ddate)
    (format t "~A~%" (print-discordian-date *dt* ddate))))

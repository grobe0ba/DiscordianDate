(load "DiscordianDate.lisp")
(use-package :discord)
(save-lisp-and-die "DiscordianDate" :toplevel #'discord::toplevel :executable t)

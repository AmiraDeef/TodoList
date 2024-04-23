         CLIPS (6.30 3/17/15)
CLIPS> (deftemplate task
   (slot id)
   (slot description)
   (slot completed (default no))
   (slot time (allowed-values morning afternoon evening)))
CLIPS> (defglobal ?*plus-id* = 5)
CLIPS> (assert (task (id 1) (description "Studying computer science") (time morning)))
<Fact-1>
CLIPS> (assert (task (id 2) (description "Go shopping") (time afternoon)))
<Fact-2>
CLIPS> (assert (task (id 3) (description "Cooking lunch") (time afternoon)))
<Fact-3>
CLIPS> (assert (task (id 4) (description "Reading and Relaxing") (time evening)))
<Fact-4>
CLIPS> (defrule view-all-tasks
   =>
   (printout t "Morning Tasks:" crlf)
   (do-for-all-facts ((?t task)) (eq ?t:time morning)
      (printout t ?t:id ". [" ?t:completed "] " ?t:description crlf))
   (printout t "Afternoon Tasks:" crlf)
   (do-for-all-facts ((?t task)) (eq ?t:time afternoon)
      (printout t ?t:id ". [" ?t:completed "] " ?t:description crlf))
   (printout t "Evening Tasks:" crlf)
   (do-for-all-facts ((?t task)) (eq ?t:time evening)
      (printout t ?t:id ". [" ?t:completed "] " ?t:description crlf))
)
CLIPS> (defrule view-completed-tasks
   =>
   (printout t "Completed Tasks:" crlf)
   (do-for-all-facts ((?t task)) (eq ?t:completed yes)
      (printout t ?t:id ". [X] " ?t:description crlf))
)
CLIPS> (defrule get-task
   =>
   (printout t "Enter task description: ")
   (bind ?description (readline))
   (printout t "Enter task time (morning/afternoon/evening): ")
   (bind ?time (readline))
   (assert (task (id ?*plus-id*) (description ?description) (time ?time)))
   (bind ?*plus-id* (+ ?*plus-id* 1))
   (printout t "Task added." crlf)
)
CLIPS> (defrule mark-as-completed
   ?task <- (task (id ?id) (completed no))
   =>
   (printout t "Task " ?id " is currently marked as incomplete." crlf)
   (printout t "Do you want to mark it as complete? (yes/no): ")
   (bind ?response (readline))
   (if (eq ?response "yes")
      then
      (modify ?task (completed yes))
      (printout t "Task " ?id " has been marked as complete." crlf)
   else
      (printout t "Task " ?id " remains incomplete." crlf))
)




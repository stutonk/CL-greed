;; EXTRA CREDIT:
;;
;; Create a program that will play the Greed Game.
;; Rules for the game are in GREED_RULES.TXT.
;;
;; You already have a DiceSet class and score function you can use.
;; Write a player class and a Game class to complete the project.  This
;; is a free form assignment, so approach it however you desire.

;; Dice

(defun roll (how-many)
  (loop repeat how-many collect (+ 1 (random 6))))

(defun n-score (n how-many &optional (one 0) (three (* n 100)))
  (multiple-value-bind (triple single) (floor how-many 3)
    (+ (* triple three) (* single one))))

(defun score (dice)
  (if (not dice)
      0
      (+ (n-score 1 (count 1 dice) 100 1000)
         (n-score 5 (count 5 dice) 50)
         (loop for i in '(2 3 4 6)
               sum (n-score i (count i dice))))))

(defun scoring-dice (dice)
  (+ (count 1 dice)
     (count 5 dice)
     (loop for i in '(2 3 4 8)
           sum (if (>= (count i dice) 3)
                   3
                   0))))

;; Player

(defclass player ()
  ((name :reader get-name :writer set-name)
   (score :reader get-score :writer set-score :initform 0)
   (scoring? :reader scoring? :writer set-scoring :initform nil)))

(defmethod play-round ((object player))
  (format t "~%--> Beginning player ~a's turn.~%" (get-name object))
  (let ((score (play-turn)))
    (if (scoring? object)
        (set-score (+ score (get-score object)) object)
        (when (> score 300)
          (format t "Player ~s may now accumulate score.~%" (get-name object))
          (set-scoring t object)
          (set-score score object)))))

(defun play-turn ()
  (let ((dice nil)
        (dice-left 5)
        (turn-score 0))
    (loop while t do
      (let ((roll-score 0))
        (format t "You roll ~r dice: ~a, "
                dice-left
                (setf dice (roll dice-left)))
        (format t "score: ~a~%" (incf roll-score (score dice)))
        (when (= roll-score 0)
          (format t "Sorry, you lose your turn.~%")
          (return-from play-turn roll-score))
        (incf turn-score roll-score)
        (decf dice-left (scoring-dice dice))
        (when (= dice-left 0) (incf dice-left 5))
        (when (end-turn? turn-score dice-left)
          (return turn-score))))
    turn-score))

(defun end-turn? (score dice)
  (loop while t do
    (format t "Yout score this turn: ~a.~%(R)oll ~r dice or (e)nd turn?: "
            score
            dice)
    (case (aref (read-line) 0)
      (#\r (return-from end-turn? nil))
      (#\R (return-from end-turn? nil))
      (#\e (return-from end-turn? t))
      (#\E (return-from end-turn? t)))))

;; Game

(defvar *final-round-score-threshhold* 3000)

(defclass game ()
  ((players :reader get-players :writer set-players)
   (dice :reader get-dice :writer set-dice)))

(defmethod init-game ((object game))
  (let ((num-players nil))
    (loop while (not (integerp num-players)) do
      (format t "Please enter the number of players: ")
      (setf num-players (ignore-errors (parse-integer (read-line)))))
    (set-players (loop for i from 1 to num-players collect
                                      (let ((player (make-instance 'player)))
                                        (format t "Please enter player ~r name: " i)
                                        (set-name (read-line) player)
                                        player))
                 object)))

(defmethod scores-string ((object game))
  (format nil "scores:~%~A~%"
          (mapcar (lambda (x) (format nil "~A: ~A"
                                      (get-name x)
                                      (get-score x)))
                  (get-players object))))

(defmethod rotate-players ((object game))
  (let ((players (get-players object)))
    (set-players (append (cdr players) (list (car players))) object)))

(defmethod play-game ((object game))
  (flet ((pred (x) (> x *final-round-score-threshhold*))
         (score (x) (get-score x)))
    (loop until (some #'pred
                      (mapcar #'score (get-players object)))
          do (format t "Current ~A" (scores-string object))
             (play-round (car (get-players object)))
             (rotate-players object))
    t))

(defmethod final-round ((object game))
  (format t "~%--- Beginning final round. ---~%")
  (mapcar (lambda (x) (play-round x)) (get-players object))
  t)

;; Doesn't account for a tie
(defmethod find-winner ((object game))
  (let ((winner (car (get-players object))))
    (loop for i in (cdr (get-players object)) do
      (when (> (get-score i) (get-score winner))
        (setf winner i)))
    (get-name winner)))

(defmethod announce-winner ((object game))
  (format t "And the winner is...~%")
  (format t "~A!!!~%" (find-winner object))
  (format t "Final ~A" (scores-string object))
  t)

;; Main Function

(defun play-greed ()
  (let ((game (make-instance 'game)))
    (init-game game)
    (play-game game)
    (final-round game)
    (announce-winner game)))

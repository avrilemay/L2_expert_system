; Nom ......... : SE_12.lisp
; Rôle ........ : Système expert pour id un chat
; Auteur ...... : Avrile Floro 
; Version ..... : V0.1 du 22/12/23
; Licence ..... : réalisé dans le cadre du cours d'Algo 1
; Usage : lisp puis (load "SE_12.lisp") puis (chat)

(load "SE_12_data.lisp")

; NAME : chat, lance le programme d'id du chat 
; ARGS : none
; USAGES : (chat)
; GLOBALS : prop-basique, Règles
; CALL : initialisation_prop, init_conclu, pose_questions, parcourt_regles, donne_resultats
; USER : top level

(defun chat ()
  (initialisation_prop prop-basique) ; initialise les propriétés à inconnu
  (init_conclu Règles) ; initialise les conclusions à nil
  (princ "Bonjour, je suis un système expert permettant d'identifier un chat.")
  (terpri)
  (pose_questions prop-basique)  ; pose les ? pour les prop basiques
  (terpri)
  (parcourt_regles Règles); on parcourt les règles pour modifier les conclusions
  (terpri)
  (princ "Résultat: ")
  (donne_resultats Règles) )


; NAME : initialisation_prop ; initialise les propriétés à inconnu
; ARGS : prop-basique
; USAGES : (initialisation_prop prop-basique)
; GLOBALS : prop-basique, Animal
; CALL : put
; USER : chat

(defun initialisation_prop (prop-basique)
  (cond
      ((not prop-basique)) ; si on a parcouru toutes les prop, on s'arrête
      (t (put 'Animal (caar prop-basique) 'inconnu)
        ; on met la propriété à inconnu et on continue 
        (initialisation_prop (cdr prop-basique)) ) ) )


; NAME : init_conclu ; initialise les conclusions à nil
; ARGS : Règles
; USAGES : (init_conclu Règles)
; GLOBALS : Règles, Animal
; CALL : put
; USER : chat

(defun init_conclu (regles)
  (cond
      ((not regles)) ; si on a parcouru toutes les conclusions, on s'arrête
      (t (put 'Animal (caaddr (car regles)) 'nil)
        ; on met la conclusion à nil et on continue
        (init_conclu (cdr regles)) ) ) )



; NAME : pose_questions ; parcourt les prop basiques appelle get-basic-value poiur les ?
; ARGS :  prop-basique
; USAGES : (pose_questions prop-basique)
; GLOBALS : prop-basique
; CALL : get-basic-value 
; USER : test_realisation_regle, pose_questions

(defun pose_questions (prop-basique)
  (cond
      ((not prop-basique)) ; si on a parcouru toutes les prop, on s'arrête
      ((get-basic-value (caar prop-basique)) ; on pose la question
        (pose_questions (cdr prop-basique)) ) ) ) ; on continue de parcourir les prop
 

; NAME : put ; met des valeurs dans les propriétés 
; ARGS :  symbole, attribut, valeur
; USAGES : (put 'Animal conclusion t)
; GLOBALS : Animal, Règles
; CALL : none 
; USER : initialisation_prop, init_conclu, apply-conclusion, get-basic-value

(defun put (symbole attribut valeur) (setf (get symbole attribut) valeur) valeur)


; NAME : get-basic-value ; màj prop basiques d'après les réponse de l'utilisateur
; ARGS :  prop &aux base read
; USAGES : (get-basic-value (caar prop-basique))
; GLOBALS : prop-basique, Animal
; CALL : put 
; USER : test_realisation_regle, pose_questions

(defun get-basic-value (prop &aux base read)
  (cond
      ((not (eq (get 'Animal prop 'inconnu) 'inconnu)) (get 'Animal prop))
        ; si la propriété n'est pas inconnue, on retourne sa valeur
      ((setq base (assoc prop prop-basique))
        ; sinon on affiche la question et on lit la réponse
        (princ (cdr base))
        (terpri)
        (princ "(répondez par nil/t/inconnu)")
        (terpri)
        (setq read (read))
        (cond
              ; on met à jour la propriété en fonction de la réponse
            ((eq read 't) (put 'Animal prop t))
            ((eq read 'nil) (put 'Animal prop nil) t)
            ((eq read 'inconnu) (put 'Animal prop 'inconnu))
            (t (princ "Réponse invalide, veuillez recommencer.") 
              ; si la réponse est invalide, on recommence
              (terpri) (get-basic-value prop)) ) ) ) )



; NAME : parcourt_regles ; parcourt les règles et appelle test_realisation_regle
; ARGS :  Règles
; USAGES : (parcourt_regles Règles)
; GLOBALS : Règles
; CALL : test_realisation_regle
; USER : chat

(defun parcourt_regles (regles)
  (cond
      ((not regles)) ; si on a parcouru toutes les règles, on s'arrête
      ((test_realisation_regle (car regles)) (parcourt_regles (cdr regles)))
        ; si la règle est vraie, on continue de parcourir les règles
      (t (parcourt_regles (cdr regles)) ) ) )
        ; sinon on continue de parcourir les règles 


; NAME : test_realisation_regle ; vérifie la réalisation d'une règle et appelle
; apply-conclusion si elle est vraie    
; ARGS :  Règles
; USAGES : (test_realisation_regle (car regles)
; GLOBALS : Règles
; CALL : apply-conclusion 
; USER : parcourt_regles

(defun test_realisation_regle (regles)
  (cond
      ((not regles) nil) ; si on a parcouru toutes les règles, on s'arrête
      ((apply (caadr regles) (cdadr regles)) 
        ; on applique la fonction de la règle aux arguments de la règle
        (apply-conclusion (caaddr regles)) ) ) )
          ; on applique la conclusion de la règle


; NAME : et ; vérifie si toutes les propriétés sont vraies
; ARGS :  &rest args
; USAGES : (et (est-vivant X) (est-chat X))
; GLOBALS : Animal, Règles
; CALL : none
; USER : test_realisation_regle (via apply)

(defun et (&rest args)
  (cond
      ((not args))  ; si on a parcouru tous les args, retourne vrai
      ((equal (get 'Animal (caar args)) t) (apply 'et (cdr args)))  
        ; si la propriété est t, on continue de parcourir les args 
      (t nil) ) )  ; sinon, on retourne faux 


; NAME : apply-conclusion ; met la conclusion à t
; ARGS :  conclusion 
; USAGES : (apply-conclusion (caaddr regles))
; GLOBALS : Animal, Règles
; CALL : put 
; USER : test_realisation_regle

(defun apply-conclusion (conclusion)
  (put 'Animal conclusion t) ) ; met la conclusion à t


; NAME : donne_resultats ; affiche les résultats
; ARGS :  Règles
; USAGES : (donne_resultats Règles)
; GLOBALS : Règles, Animal 
; CALL : none
; USER : chat

(defun donne_resultats (regles)
  (cond
      ((not regles) 'Merci) ; si on a parcouru toutes les conclusions, on s'arrête
      ((eq (get 'Animal (car (caddar regles))) t) ; si la conclusion est t
        (princ (format nil "~a " (car (caddar regles)))) (donne_resultats (cdr regles)) )
        ; on l'affiche et on continue de parcourir les conclusions
      (t (donne_resultats (cdr regles))) ) ) ; sinon on continue de parcourir les conclusions



(chat) ; on appelle la fonction chat



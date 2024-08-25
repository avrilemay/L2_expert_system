; Nom ......... : SE_12_data.lisp
; Role ........ : données pour le système expert
; Auteur ...... : Avrile Floro 
; Version ..... : V0.1 du 22/12/23
; Licence ..... : réalisé dans le cadre du cours d'Algo 1
; Usage : lisp puis (load "SE_12.lisp") puis (chat)

; NAME : Individus
; USAGES : liste des individus
; USER : initialisation_prop, init_conclu, put, get-basic-value, et, 
;   apply-conclusion, donne_resultats

(setq Individus '(Animal))

; NAME : prop-basique
; USAGES : liste des propriétés de base
; USER : chat, initialisaiton_prop, pose_questions, get-basic-value

(setq prop-basique
    '((est-vivant . "L'animal est-il vivant?")
      (est-chat . "L'animal est-il un chat?")
      (pese<4 . "Le chat pèse-t-il moins de 4 kilos?")
      (pese-4-7 . "Le chat pèse-t-il entre 4 et 7 kilos?")
      (pese>7 . "Le chat pèse-t-il plus de 7 kilos?")
      (est-couleur-solide . "Le chat est-il de couleur solide")
      (est-bicolore . "Le chat est-il bicolore?")
      (est-ecaille-tortue . "Le chat est-il de couleur écaille de tortue?")
      (est-calico . "Le chat est-il de couleur calico?")
      (est-colorpoint . "Le chat est-il de couleur colorpoint?")
      (est-tabby . "Le chat est-il de couleur tabby?")
      (a-poil-court . "Le chat a-t-il le poil court?")
      (a-poil-mi-long . "Le chat a-t-il le poil mi-long?")
      (a-poil-long . "Le chat a-t-il le poil long?")
      (a-poil-frisé . "Le chat a-t-il le poil frisé?")
      (a-pas-de-poil . "Le chat est-il sans poil?")
      (a-courtes-pattes . "Le chat a-t-il de courtes pattes?")
      (a-tête-plate . "Le chat a-t-il la tête plate?")
      (a-tête-fine . "Le chat a-t-il la tête fine?")
      (a-queue-courte . "Le chat a-t-il une queue courte?")
      (a-grandes-oreilles . "Le chat a-t-il de grandes oreilles?")
      (a-oreille-courbée . "Le chat a-t-il les oreilles courbées?")
      (a-oreille-pliée . "Le chat a-t-il les oreilles pliées?")
      (a-oreille-de-lynx . "Le chat a-t-il des oreilles de lynx?") ) )


; NAME : Règles 
; USAGES : liste des règles
; USER : chat, init_conclu, parcourt_regles, donne_resultats, put, 
;   test_realisation_regle, et, apply-conclusion, donne_resultats

(setq Règles
  '((R_chat 
       (et (est-vivant X) (est-chat X))
       (chat X) )
    (R_Manx 
        (et (chat X) (pese-4-7 X) (a-poil-court X) (a-queue-courte X))
        ; toutes les couleurs sont aceptées 
        (Manx X) )
    (R_Cornish-Rex 
        (et (chat X) (pese<4 X) (a-poil-frisé X) (a-tête-fine X) (a-grandes-oreilles X))
        (Cornish-Rex X) )
    (R_Bobtail-Japonais 
        (et (chat X) (pese<4 X) (a-queue-courte X))
        ; presque toutes les couleurs, poils longs ou courts 
        (Bobtail-Japonais X) )
    (R_Siamois  
        (et (chat X) (pese-4-7 X) (est-colorpoint X) (a-poil-court X) (a-tête-fine X))
        (Siamois X) )
    (R_Maine-Coon 
        (et (chat X) (pese>7 X) (est-couleur-solide X) (a-poil-long X) (a-oreille-de-lynx X))
        (Maine-Coon X) )
    (R_Siberien 
        (et (chat X) (pese-4-7 X) (a-poil-mi-long X) (a-oreille-de-lynx X))
        ; toutes les couleurs sont admises
        (Sibérien X) )
    (R_Scottish-Fold 
        (et (chat X) (pese-4-7 X) (est-couleur-solide X) (a-tête-plate X) (a-oreille-pliée X))
        (Scottish-Fold X) )
    (R_Persan 
        (et (chat X) (pese-4-7 X) (a-poil-long X) (a-tête-plate X))
        ; toutes les couleurs sont admises
        (Persan X) )
    (R_Abyssin 
        (et (chat X) (pese-4-7 X) (est-tabby X) (a-poil-court X) (a-tête-fine X))
        (Abyssin X) )
    (R_Sphynx 
        (et (chat X) (pese-4-7 X) (a-pas-de-poil X) (a-tête-fine X))
        (Sphynx X) )
    (R_Himalayen 
        (et (chat X) (pese>7 X) (est-colorpoint X) (a-poil-long X))
        (Himalayen X) )
    (R_Birman 
        (et (chat X) (pese-4-7 X) (est-colorpoint X) (a-poil-long X))
        (Birman X) )
    (R_Highlander 
        (et (chat X) (a-queue-courte X) (a-oreille-courbée X))
        ; toutes les couleurs sont autorisées et poils courts ou longs
        (Highlander X) )
    (R_Elf 
        (et (chat X) (pese-4-7 X) (a-pas-de-poil X) (a-oreille-courbée X))
        (Elf X) )
    (R_Selkirk-Rex 
        (et (chat X) (pese-4-7 X) (a-poil-frisé X) (a-tête-plate X))
        (Selkirk-Rex X) )
    (R_Norvégien 
        (et (chat X) (pese>7 X) (a-poil-mi-long X) (a-oreille-de-lynx X))
        (Norvégien X) )
    (R_Balinais 
        (et (chat X) (pese<4 X) (est-colorpoint X) (a-poil-mi-long X))
        (Balinais X) )
    (R_Turkish-Van 
        (et (chat X) (est-bicolore X) (a-poil-mi-long X) (a-oreille-de-lynx X))
        (Turkish-Van X) )
    (R_Munchkin 
        (et (chat X) (pese<4 X) (a-courtes-pattes X) (a-tête-plate X))
        (Munchkin X) )
    (R_LaPerm 
        (et (chat X) (pese<4 X) (a-poil-frisé X) (a-oreille-de-lynx X))
        (LaPerm X) )
    (R_Devon-Rex
        (et (chat X) (pese-4-7 X) (a-poil-court X) (a-poil-frisé X) (a-grandes-oreilles X))
        ; toutes les couleurs sont autorisées
        (Devon-Rex X) )
    (R_Chartreux
        (et (chat X) (pese-4-7 X) (est-couleur-solide X) (a-poil-court X))
        (Chartreux X) )
    (R_Bambino 
        (et (chat X) (pese<4 X) (a-pas-de-poil X) (a-courtes-pattes X) (a-grandes-oreilles X))
        (Bambino X) ) ) )


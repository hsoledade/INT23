/* Ce fichier est encodé en UTF-8 et suit la syntaxe du langage Prolog       */
/* Merci de NE PAS MODIFIER LE SYSTEME D'ENCODAGE                            */

/* Nom du binome :    Nicolas LEGRAND - Hazael SOLEDADE DE ARAUJO JUMONJI   */		
/*           (TODO : remplacez Nom1 et Nom2 par vos noms dans l'ordre alphabétique) */

/*****************************************************************************
*              Modélisation du domaine du problème des cruches
******************************************************************************/



/*****************************************************************************
* Question 0 :  
*
* Proposer une structure permettant de représenter un état pour le problème
* des cruches (nb il n'y a pas de relation à définir - décrire juste la
* structure que vous comptez utiliser, en précisant le sens de chaque argument)
*
* Réponse : (L'univers du problème) 
*			
			etat = {(P, G) tel que P ∈ [0,P_max], G ∈ [0,G_max]}

			Opérateurs:		Précondition:		Effets:	
			G -> P			G >= 0 ^ P <= P_max		(P, G) <- (MIN(P+G, P_max), MAX(P+G-P_max, 0))
			P -> G			P >= 0 ^ G <= G_max		(P, G) <- (MAX(P+G-G_max, 0), MIN(P+G, G_max))
			G -> F			G >= 0					(P, G) <- (P, 0)
			P -> F			P >= 0					(P, G) <- (0, G)
			F -> P			P <= P_max				(P, G) <- (P_max, G)
			F -> G			G <= G_max				(P, G) <- (P, G_max)

			(Un problème particulier)
			
			etat_ini = (P_ini, G_ini) (dépend du problème)
			but = {(P_but, G_but) tel que ...} (dépend du problème)
*
* où... 
*           - P représente le niveau de liquide à l'intérieur de la petite cruche
		    - G représente le niveau de liquide à l'intérieur de la grande cruche
			- P_max représente la capacité du petit cruche
			- G_max représente La capacité du grand cruche
			- etat = (P,G) represent les niveaux des liquides actuels dans chaque cruche.

			- P_ini représente le niveau de liquide initial de la petite cruche
		    - G_ini représente le niveau de liquide initial de la grande cruche
			- etat_ini = (P_ini, G_ini) représente le niveau initial de liquide dans chaque cruche
			
			- P_but représente le niveau de liquide but de la petite cruche
		    - G_but représente le niveau de liquide but de la grande cruche
			- but représente l'objectif et correspond généralement à la quantité de liquide souhaitée dans les cruches.

******************************************************************************/



/*****************************************************************************
* Question 1 : Définir un prédicat constructeur|accesseur, permettant de faire
* abstraction de la structure que vous avez choisie (et d'automatiser les test)

* cons_etat_cruche(?P, ?G, ?Etat)  
	qui est vrai si et seulement si Etat correspond au terme
	modélisant un état du domaine des cruches dans lequel 
	- le contenu de la petite cruche est P
	- le contenu de la grande cruche est G
******************************************************************************/

cons_etat_cruche(P, G, etat(P, G)).

/* Exemples:

	?- cons_etat_cruche(1, 2, Etat).		=>	Etat = etat(1, 2).
	?- cons_etat_cruche(_, 2, Etat).		=>	Etat = etat(_, 2).
	?- cons_etat_cruche(1, _, Etat).		=>	Etat = etat(1, _).
	?- cons_etat_cruche(1, 2, etat(1, 2)).   =>	true.
	?- cons_etat_cruche(1, _, etat(1, 2)).   =>	true.
	?- cons_etat_cruche(_, 2, etat(1, 2)).   =>	true.
	?- cons_etat_cruche(_, _, etat(1, 2)).   =>	true.
	?- cons_etat_cruche(3, _, etat(1, _)).   =>  false.
	?- cons_etat_cruche(_, 3, etat(1, 1)).   =>  false.

*/ 


/*****************************************************************************
* Question 2 : Ecrire le code du prédicat :

* etat_cruche(?Terme)  qui est vrai si et seulement si Terme est un terme prolog
*                      qui représente bien un état pour le problème des cruches.
******************************************************************************/

cap_P(5).
cap_G(10).

etat_cruche(etat(P,G)) :-
	P >= 0,
	cap_P(P_max),
	P =< P_max,
	
	G >= 0,
	cap_G(G_max),
	G =< G_max.


/*****************************************************************************
* Question 3 : Définir un prédicat :

* operateur(?Nom,?Etat,?NEtat)
*					qui est vrai si et seulement si Nom est le nom dun opérateur 
*					applicable pour le problème des cruches, permettant de  
*					passer dun état Etat à un successeur état NEtat.
******************************************************************************/




operateur('G -> P', etat(P, G), etat(NP, NG)) :-
    G >= 0,
	cap_P(P_max),
    P =< P_max,
    NP is min(P + G, P_max),
    NG is max(P + G - P_max, 0).

operateur('P -> G', etat(P, G), etat(NP, NG)) :-
    P >= 0,
	cap_G(G_max),
    G =< G_max,
    NG is min(P + G, G_max),
    NP is max(P + G - G_max, 0).

operateur('G -> F', etat(P, G), etat(P, 0)) :-
    G >= 0.

operateur('P -> F', etat(P, G), etat(0, G)) :-
    P >= 0.

operateur('F -> P', etat(P, G), etat(NP, G)) :-
	cap_P(P_max),
    P =< P_max,
    NP is P_max.

operateur('F -> G', etat(P, G), etat(P, NG)) :-
	cap_G(G_max),
    G =< G_max,
    NG is G_max.




/*****************************************************************************
* Question 4 : Définir le prédicat : 
* but(?Etat)   qui est vrai si et seulement si Etat est un état but pour 
*              le problème des cruches.
******************************************************************************/

but_donne(4).

but(etat(P, _)) :-
	but_donne(P).

but(etat(_, G)) :-
	but_donne(G).

/* Ce fichier est encodé en UTF-8 et suit la syntaxe du langage Prolog      */
/* Merci de NE PAS MODIFIER LE SYSTEME D'ENCODAGE     */

/* Nom du binome :    Nicolas LEGRAND - Hazael SOLEDADE DE ARAUJO JUMONJI   */
/*           (TODO : remplacez Nom1 et Nom2 par vos noms dans l'ordre alphabétique) */

/*****************************************************************************
 			    Introduction à l'Intelligence Artificielle					 
					ENSTA 1ère année - Cours INT23
*****************************************************************************/

/*****************************************************************************
* On considère le domaine de problème correspondant au jeu du taquin sur une
* grille de taille 4x4 et on décide de représenter un état par une structure 
* de la forme :
*  
*     et( A, B, C, D
*		  E, F, G, H
*		  I, J, K, L,
*		  M, N, O, P,
*		  CV
*		 )
*
* tel que : 
* - A,...,P représentent respectivement les contenus des 
*   différentes cases de la grille du taquin, lorsqu'elle est 
*	parcourue de haut en bas et de gauche à droite.
*   ils correspondent à des entiers tous différentes allant de 0 à 15 
*   (où 0 représente la case vide) 
*
* - CV représente le numéro de l'argument correspondant à la case vide 
*
* Exemple :  la grille suivante :
*
*				1   2   3   4  
*				5   6   7   8  
*				9  10  11  12  
*			    13  14  15   0  
*
*     sera représentée par le terme 
*		et(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,0,16)
*		car la position de la case vide correspond au 16e argument de la structure.
*
*  NB1  : l'information représentée par CV est redondante, mais elle évite d'avoir 
*         à parcourir la structure pour retrouver la position de la case vide
*
*  NB2  : cette représentation n'est pas optimale en terme d'espace
*		 On pourait par exemple représenter
*        la grille par un simple entier sur 64bits (4*16)	
* 		 mais elle est déjà plus économique qu'une simple liste de 16 entiers.		
*******************************************************************************/

/*****************************************************************************
 cons_etat_taquin(?Liste, ?EtatTaquin) est vrai 
				construit un  ?EtatTaquin à partir d'une grille 
				représentée par une simple liste dont les cases sont parcourues
				de gauche à droite  et de haut en bas (et inversement)
				
				mode d'appel (+,?) ou (?,+) 
				Ne vérifie pas que les cases sont bien remplies par des
				entiers entre 0 et 15
******************************************************************************/
cons_etat_taquin(Matrice, EtatTaquin) :-
		     Matrice = [A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P],
		     EtatTaquin =.. [et,A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P,CV],
			 arg(CV,EtatTaquin,0).

/* tests
cons_etat_taquin([1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,0],E).
cons_etat_taquin([0,2,3,4,5,6,7,8,9,10,11,12,13,14,15,1],E).
cons_etat_taquin([10,2,3,4,5,6,7,8,9,0,11,12,13,14,15,1],E).

cons_etat_taquin(M,et(0, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 1, 1)).

*/ 



/*****************************************************************************
* operateur(?Nom,?Etat,?NEtat) qui est vrai si et seulement si Nom est le nom
*							  d'un opérateur pour le problème du taquin
*							  applicable et permettant de faire passer d'un état
*							  Etat à un nouvel état NEtat.
******************************************************************************/

operateur('gauche', Etat, NEtat) :-
    Etat = et(A, B, C, D, 
		      E, F, G, H, 
			  I, J, K, L, 
			  M, N, O, P, CV),
    CV =\= 1, 
	CV =\= 5, 
	CV =\= 9, 
	CV =\= 13, 
    NEtat = et(A, B, C, D, 
	           E, F, G, H, 
			   I, J, K, L, 
			   M, N, O, P, CV_gauche),
    CV_gauche is CV - 1.


operateur('droite', Etat, NEtat) :-
    Etat = et(A, B, C, D, 
	          E, F, G, H, 
			  I, J, K, L, 
			  M, N, O, P, CV),
    CV =\= 4, 
	CV =\= 8, 
	CV =\= 12, 
	CV =\= 16, 
    NEtat = et(A, B, C, D, 
	           E, F, G, H, 
			   I, J, K, L, 
			   M, N, O, P, CV_droite),
    CV_droite is CV + 1.


operateur('haut', Etat, NEtat) :-
    Etat = et(A, B, C, D, 
	          E, F, G, H, 
			  I, J, K, L, 
			  M, N, O, P, CV),
    CV =\= 1, 
	CV =\= 2, 
	CV =\= 3, 
	CV =\= 4, 
    NEtat = et(A, B, C, D, 
	           E, F, G, H, 
			   I, J, K, L, 
			   M, N, O, P, CV_haut),
    CV_haut is CV - 4.


operateur('bas', Etat, NEtat) :-
    Etat = et(A, B, C, D, 
	          E, F, G, H, 
			  I, J, K, L, 
			  M, N, O, P, CV),
    CV =\= 13, 
	CV =\= 14, 
	CV =\= 15, 
	CV =\= 16,
    NEtat = et(A, B, C, D,
			   E, F, G, H, 
			   I, J, K, L, 
			   M, N, O, P, CV_bas),
    CV_bas is CV + 4.




/*****************************************************************************
* but(Etat)	  qui est vrai si et seulement si Etat est un état but pour 
*              le problème du taquin.
******************************************************************************/


but(Etat) :-
    Etat = et(A, B, C, D, 
			  E, F, G, H, 
			  I, J, K, L, 
			  M, N, O, P, _), 
    A =:= 1,
	B =:= 2, 
	C =:= 3, 
	D =:= 4,
    E =:= 5, 
	F =:= 6, 
	G =:= 7, 
	H =:= 8,
    I =:= 9, 
	J =:= 10, 
	K =:= 11, 
	L =:= 12,
    M =:= 13, 
	N =:= 14, 
	O =:= 15, 
	P =:= 0.
 

/*****************************************************************************
*Avertissement : 
* pour tester vos algorithmes sur le problème du taquin, devez faire attention
* au fait que l'espace d'état est composé de deux parties non connectées.
* Si vous choisissez un état au hasard... il est possible qu'il ne figure pas 
* dans la même composante connexe que votre but... et dans ce cas le problème
* n'aura pas de solution.
*
* Suggestion : implémentez une relation qui à partir de l'état correspondant
* a votre but, applique au hasard des opérateurs un certain nombre de fois
* pour obtenir un état qui se trouve forcément dans la même composantte connexe 
* que votre but.
* 
******************************************************************************/


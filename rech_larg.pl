/* Ce fichier est encodé en UTF-8 et suit la syntaxe du langage Prolog      */
/* Merci de NE PAS MODIFIER LE SYSTEME D'ENCODAGE     */

/* Ce fichier est encodé en UTF-8 et suit la syntaxe du langage Prolog      */
/* Merci de NE PAS MODIFIER LE SYSTEME D'ENCODAGE     */


/* Nom du binome :    Nicolas LEGRAND - Hazael SOLEDADE DE ARAUJO JUMONJI   */
/*           (TODO : remplacez Nom1 et Nom2 par vos noms dans l'ordre alphabétique) */

/*****************************************************************************
*					          PARTIE 4
*
* L'algorithme de recherche en profondeur s'implémente tres facilement en Prolog
* car la stratégie de preuve mise en oeuvre par le démonstrateur de Prolog
* suit elle même une stratégie en profondeur.
* 
* Le codage de l'algorithme de recherche en largeur est un peu moins direct
* car on a besoin de pouvoir connaitre tous les successeurs d'un état.
*
* Pour cela il existe un prédicat prédéfini en prolog, qui permet de trouver
* toutes les solutions d'un but. Ce prédicat s'appelle findall/3.
*
******************************************************************************/


/*****************************************************************************
1) lisez la documentation de ce prédicat en tapant help(findall/3).
     et testez le sur des exemples simples pour bien comprendre comment
     fonctionne ce prédicat.
******************************************************************************/


     /*
          findall(Num, member(Num, [1, 5, 10, 16]), List).
     */



/*****************************************************************************
* 2) Pour connaître les tous les succeseurs d'un état E il suffira alors 
* d'utiliser :
*      	...
*       findall(NE, operateur(OP,E,NE), Successeurs)
*       ....
*
* > vérifiez cela manuellement sur quelques états des cruches et|ou du taquin
* > nb : à la place de NE, vous pouvez aussi mettre n'importe quel terme qui contient NE.
******************************************************************************/

/*
     findall(etat(4,10), operador('P -> G', etat(5,9), etat(4,10)), [etat(4,10)]).
     
     findall(  et(A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, CV_gauche), 
               operador('gauche', etat(5,9), et(A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, CV_gauche)), 
               [et(A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, CV),
               et(A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, CV_gauche)]).
*/





/*****************************************************************************
* 3) Le codage de l'algorithme de recherche en profondeur nécessite alors
* de construire le graphe de recherche et sa frontière.
* une façon simple de représenter la structure de ce graphe est de 
* représenter chaque noeud par une structure de la forme : 
*
*      nd(E, Pere) 
* 
* où - E est l'état associé au noeud
*    - Pere est le noeud parent de ce noeud (ou nil si le noeud correspond à l'état initial)
* 
* On peut alors représenter la frontière simplement par une liste de noeuds.
* mais pour garantir que l'exploration s'effectue bien en largeur il faudra bien
* veiller à développer à chaque étape, le noeud le plus ancien parmi ceux de la frontière
* (attention à la façon dont vous rajoutez des noeuds à la frontière).
******************************************************************************/
 
 
 
 
 
 
/*****************************************************************************
* Definir le prédicat :
* rech_larg(+E,-Sol,-NNA,-NND) 
*		qui construit un chemin solution Sol depuis l'état E, en construisant le graphe
*        de recherche suivant une stratégie en largeur d'abord.
*		-NNA,-NND sont des entiers correspondants respectivement au nombre de noeuds
*		 apparus et développés 
*
* nb : Vous aurez besoin de définir 
*		- une procédure auxiliaire, qui explicite la frontière du graphe et les états déjà
*		- developpés et effectue la recherche
*		- une procédure auxiliaire qui reconstruit le chemin solution lorsqu'un état but a été atteint.
******************************************************************************/





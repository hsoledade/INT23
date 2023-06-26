/* Ce fichier est encodé en UTF-8 et suit la syntaxe du langage Prolog      */
/* Merci de NE PAS MODIFIER LE SYSTEME D'ENCODAGE     */


/* Nom du binome :    Nicolas LEGRAND - Hazael SOLEDADE DE ARAUJO JUMONJI   */
/*           (TODO : remplacez Nom1 et Nom2 par vos noms dans l'ordre alphabétique) */


/*****************************************************************************
* On suppose que l'on dispose d'un domaine de problème, caractérisé par
*
*  - une relation operateur/3
*  - une relation but/1
*
* On souhaite coder un algorithme de recherche de chemin solution de faisant
* aucune autre hypothèse que celle de la modélisation du domaine du problème
* a l'aide des relations précédentes.
*
* Définir les relations suivantes :
******************************************************************************/




/*****************************************************************************
* rprof(+Etat,-Solution)     qui est vrai si et seulement si Solution est une suite
*                            d'états caractérisant un chemin solution depuis Etat
*                            vers un état du But.
******************************************************************************/
rprof(Etat,[Etat]) :-
    but(Etat).

rprof(Etat,[Etat|Restesolution]):-
    operateur(_, Etat, EtatSuivant),
    rprof(EtatSuivant,Restesolution).

/*****************************************************************************
* rprof_ss_cycle(+Etat,-Solution)     qui est vrai si et seulement si Solution est
*           une suite d'états sans cycle, caractérisant un chemin solution depuis
*           Etat vers un état du But.
******************************************************************************/

rprof_ss_cycle(Etat, Solution) :-
  rprof_ss_cycle_visited(Etat, [], Solution).

rprof_ss_cycle_visited(Etat,_,[Etat]) :-
    but(Etat).

rprof_ss_cycle_visited(Etat, Visited,[Etat|Restesolution]) :-
  operateur(_, Etat, EtatSuivant),
  \+ member(EtatSuivant, Visited),
  rprof_ss_cycle_visited(EtatSuivant, [Etat|Visited], Restesolution).

/*****************************************************************************
* Une nouvelle version de ce prédicat permettant limiter
* la profondeur de recherche.
*  
* rprof_bornee(+Etat,-Solution,+ProfMax)
*     qui est vrai si et seulement si Solution est une suite d'au plus ProfMax
*     états caractérisant un chemin solution depuis Etat vers un état du But.
******************************************************************************/
rprof_bornee(Etat, Solution, ProfMax) :-
  rprof_bornee_recursif(Etat, [], Solution, ProfMax).

rprof_bornee_recursif(Etat, _, [Etat], _) :-
  but(Etat).

rprof_bornee_recursif(Etat, Visited, [Etat|Restesolution], ProfMax) :-
  ProfMax > 0,
  operateur(_, Etat, EtatSuivant),
  \+ member(EtatSuivant, Visited),
  NewProfMax is ProfMax - 1,
  rprof_bornee_recursif(EtatSuivant, [Etat|Visited], Restesolution, NewProfMax).

/*****************************************************************************
* rprof_incr(+Etat,-Solution,+ProfMax)
*     qui est vrai si et seulement si Solution est une suite d'au plus ProfMax
*     états caractérisant recherchée suivant une stratégie de recherche itérative
*     à profondeur incrémentale.
******************************************************************************/

rprof_incr(Etat, Solution, ProfMax) :-
  rprof_incr_recursif(Etat, 0, Solution, ProfMax).

rprof_incr_recursif(Etat,Prof, Solution, _) :-
  rprof_bornee(Etat, Solution, Prof).

rprof_incr_recursif(Etat, Prof, Solution, ProfMax) :-
  Prof < ProfMax,
  Newprof is Prof+1,
  rprof_incr_recursif(Etat, Newprof, Solution, ProfMax).
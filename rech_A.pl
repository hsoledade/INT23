/* Ce fichier est encodé en UTF-8 et suit la syntaxe du langage Prolog      */
/* Merci de NE PAS MODIFIER LE SYSTEME D'ENCODAGE     */


/*****************************************************************************
* rech_A(+Etat,-Solution,H,NNA,NND)	  qui est vrai si et seulement si Solution est 
*			une suite (sans cycle) d'états, caractérisant un chemin solution depuis
*			Etat vers un état du But, renvoyé par l'algorithme A* en utilisant
* 			la fonction heuristique H. NNA et NND représentent respectivement le `
* 			nombre total de noeuds apparus (i.e. la taille du graphe de recherche)
* 			et le nombre de noeuds développés.
******************************************************************************/

rech_A(Etat, Solution, H, NNA, NND) :-
    init(Etat, InitNode),
    rech_A_aux([InitNode], [], Solution, H, NNA, NND).

rech_A_aux([nd(Etat, Pere, G, H, F) | _], _, Solution, _, NNA, NND) :-
    goal(Etat),
    !,
    construire_solution(nd(Etat, Pere, _, _, _), [], Solution),
    NNA is 1,
    NND is 1.

rech_A_aux([Noeud | Frontiere], DejaVisites, Solution, H, NNA, NND) :-
    developper(Noeud, Frontiere, NouvelleFrontiere, DejaVisites, NouveauxDejaVisites, H),
    rech_A_aux(NouvelleFrontiere, NouveauxDejaVisites, Solution, H, NNA1, NND1),
    NNA is NNA1 + 1,
    NND is NND1 + 1.

developper(nd(E, Pere, G, _, _), Frontiere, NouvelleFrontiere, DejaVisites, NouveauxDejaVisites, H) :-
    findall(NE, operateur(OP, E, NE), Successeurs),
    ajouter_successeurs(Successeurs, E, Pere, G, Frontiere, NouvelleFrontiere),
    append(DejaVisites, [E], NouveauxDejaVisites),
    evaluer_successeurs(Successeurs, E, G, Pere, H).

ajouter_successeurs([], _, _, _, Frontiere, Frontiere).
ajouter_successeurs([NE | Successeurs], E, Pere, G, Frontiere, NouvelleFrontiere) :-
    \+ deja_visite(NE, Pere, Frontiere),
    !,
    GNE is G + 1,
    HNE is 0, % À remplacer par l'appel à votre fonction heuristique H pour évaluer H(NE)
    FNE is GNE + HNE,
    append(Frontiere, [nd(NE, Pere, GNE, HNE, FNE)], FrontiereTemp),
    ajouter_successeurs(Successeurs, E, Pere, G, FrontiereTemp, NouvelleFrontiere).
ajouter_successeurs([_ | Successeurs], E, Pere, G, Frontiere, NouvelleFrontiere) :-
    ajouter_successeurs(Successeurs, E, Pere, G, Frontiere, NouvelleFrontiere).

deja_visite(_, _, []).
deja_visite(E, Pere, [nd(E, _, _, _, _) | _]) :-
    meme_etat(E, Pere).
deja_visite(E, Pere, [_ | AutresNoeuds]) :-
    deja_visite(E, Pere, AutresNoeuds).

meme_etat(etat(A, B), etat(A, B)).

evaluer_successeurs([], _, _, _, _).
evaluer_successeurs([NE | Successeurs], E, G, Pere, H) :-
    \+ deja_visite(NE, Pere, Successeurs),
    !,
    GNE is G + 1,
    HNE is 0, % À remplacer par l'appel à votre fonction heuristique H pour évaluer H(NE)
    FNE is GNE + HNE,
    evaluer_successeurs(Successeurs, E, G, Pere, H).
evaluer_successeurs([_ | Successeurs], E, G, Pere, H) :-
    evaluer_successeurs(Successeurs, E, G, Pere, H).

construire_solution(nil, Acc, Acc).
construire_solution(nd(E, Pere, _, _, _), Acc, Solution) :-
    construire_solution(Pere, [E | Acc], Solution).


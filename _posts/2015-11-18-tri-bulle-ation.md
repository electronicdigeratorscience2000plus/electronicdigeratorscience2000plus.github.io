---
layout: post
title: Tri économe
author: Lyxia
---

C'est un fait bien connu : un tri par comparaisons doit effectuer
au moins $$\Omega(n\log(n))$$ comparaisons.

Dans un cours d'algo, tout le monde regarde ses notes et constate que le
dernier cours sur le tri fusion se termine ainsi : "(...)
$$\mathcal{O}(n\log(n))\, \square$$". Le problème du tri est résolu, on passe
au TD.

## Au-delà des grandes lettres rondes

Concrètement, que sont ces $$\Omega(n\log(n))$$ et $$\mathcal{O}(n\log(n))$$
lorsque $$n$$ prend la valeur choisie au hasard de $$3 \times
1034482758620689655172413793$$ par exemple ?  Y a-t-il quelque chose entre les
deux ? Le tri est une opération tellement commune, ça vaut le coup de
l'optimiser autant que possible !

Parmi les algorithmes de tri par comparaisons, dans leurs pires cas respectifs,
lesquels en font absolument le moins ? Appelons *éco-tri* (*pour un tri
économe*&#x2122;) un tel tri, et notons donc $$\operatorname{eco}(n)$$ le
nombre maximum de comparaisons nécessaires pour *éco-trier* $$n$$ éléments.

### Minorant, rappel

Si on fixe le nombre $$n$$ d'éléments à trier, tout algorithme de tri peut-être
vu comme une descente dans un *arbre de décision*. On commence à la racine, qui
indique deux éléments $$a$$ et $$b$$ à comparer, et on descend à gauche si
$$a\lt b$$, à droite sinon[^sym] ; on recommence dans le sous-arbre suivant
jusqu'à atteindre une feuille qui détient l'unique permutation des éléments qui
soit compatible avec les résultats des comparaisons faites sur le chemin.

<figure>
<img src="/public/sort3tree.png"
     title="Fait avec Diagrams en Haskell."
     alt="si a < b alors si b < c alors a, b, c sinon si a < c alors a, c, b sinon c, a, b
                   sinon si a < c alors b, a, c sinon si b < c alors b, c, a sinon c, b, a"/>
<figcaption>Arbre de décision pour un tri de trois éléments.
</figcaption>
</figure>

Pour qu'un tel arbre donne un tri correct, toutes les permutations des entrées
doivent figurer dans les feuilles, qui sont donc au nombre de $$n!$$.

Finalement, l'arbre étant binaire, on a une inégalité liant la profondeur au
nombre de feuilles. Or, la profondeur d'un arbre de décision correspond
exactement au nombre de comparaisons à effectuer dans le pire cas. On en déduit
*le* minorant :

$$\left\lceil\log(n!)\right\rceil\leq\operatorname{eco}(n).$$

## Majorant simple

Déjà $$\operatorname{eco}(n)$$ est majoré par les complexités des tris que l'on
connaît déjà, comme le tri fusion :

$$\operatorname{eco}(n)\leq\operatorname{fusion}(n)$$

où

$$\operatorname{fusion}(1)=0,$$

$$\operatorname{fusion}(n)=
\operatorname{fusion}\left(\left\lfloor\frac{n}{2}\right\rfloor\right)+
\operatorname{fusion}\left(\left\lceil\frac{n}{2}\right\rceil\right)+
n-1.
$$

Voilà un premier encadrement. Bien évidemment, quand les encadrants sont
égaux on en déduit l'encadré. Mais ça ne va pas loin.

|------------------------------|---|---|---|---|---|----|----|----|----|----|
| $$n$$                        | 1 | 2 | 3 | 4 | 5 |  6 |  7 |  8 |  9 | 10 |
|------------------------------|---|---|---|---|---|----|----|----|----|----|
| $$\operatorname{fusion}(n)$$ | 0 | 1 | 3 | 5 | 8 | 11 | 14 | 17 | 21 | 25 |
|------------------------------|---|---|---|---|---|----|----|----|----|----|
| $$\operatorname{eco}(n)$$    | 0 | 1 | 3 | 5 | ? |  ? |  ? |  ? |  ? |  ? |
|------------------------------|---|---|---|---|---|----|----|----|----|----|
| $$\lceil\log(n!)\rceil$$     | 0 | 1 | 3 | 5 | 7 | 10 | 13 | 16 | 19 | 22 |
|------------------------------|---|---|---|---|---|----|----|----|----|----|

En fait, le tri fusion est le plus proche du minorant parmi les algorithmes de
tri les plus connus[^tris], à égalité avec le tri par **insertion** !
L'arnaque : comme on compte seulement les comparaisons, décaler des éléments
dans un tableau est une opération de bureaucratie, qui ne coûte rien.
Évidemment, il faut alors effectuer l'insertion par dichotomie.

À l'étape $$k$$, un nouvel élément est inséré parmi les $$k-1$$
précédents. On a donc

$$\operatorname{insert}(n) = \sum_{k=1}^n \lceil\log_2(k)\rceil,$$

et on peut effectivement montrer que[^bij]

$$\operatorname{insert}(n) = \operatorname{fusion}(n).$$

---

## Tri de Ford-Johnson (1959)

Ford comme dans Ford-Fulkerson (flot maximum) et Bellman-Ford (plus courts
chemins ; Johnson comme dans Steinhaus-Johnson-Trotter (énumération de
permutations).

Aussi appelé "tri fusion par insertion" ; on espère du progrès en
empruntant à ce qui se fait de mieux dans le domaine.

### Première étape : partition

On partitionne les $$n$$ éléments en $$k=\left\lfloor\frac{n}{2}\right\rfloor$$
paires ordonnées disjointes $$a \leq b$$ (au coût d'autant de comparaisons), et
éventuellement un élément à part que l'on notera $$a_{k+1}$$.

### Deuxième étape : tri récursif

On trie récursivement les $$k$$ paires selon leurs plus grands éléments.
On peut alors les numéroter $$a_1 \leq b_1, \dots, a_k \leq b_k$$,
tel que pour tout $$i\in[1, k-1]$$, on a $$b_i \leq b_{i+1}$$.

#### Visualisation

Un ordre total peut être vu comme un graphe, et un tri par comparaisons
cherche à le reconstituer en choisissant des arêtes à révéler, et en déduisant
les autres par transitivité. Une objectif équivalent est de découvrir un
chemin orienté entre chaque paire d'éléments.

<figure>
<img src="/public/fordjohnson.png"
     title="Fait en TikZ.">
<figcaption>Sous-ordre dévoilé après la deuxième étape.
</figcaption>
</figure>

### Dernière étape : fusion par insertion

On insère les $$a_i$$ dans la chaîne des $$b_i$$ par recherche binaire,
dans un ordre minimisant le nombre de comparaisons nécessaires.

$$a_1$$ s'insère gratuitement avant $$b_1$$, on a : $$a_1 \leq b_1 \leq
b_2 \leq \dots$$

Ensuite, $$a_2$$ et $$a_3$$ peuvent tous les deux s'insérer en deux
comparaisons. Avant $$b_3$$ se trouvent en effet quatre interstices : avant
$$a_1$$, entre $$a_1$$ et $$b_1$$, entre $$b_1$$ et $$b_2$$, et entre $$b_2$$
et $$b_3$$ (voir la figure ci-dessus). Cependant, insérer $$a_2$$ puis $$a_3$$
nécessiterait en fait cinq insertions, contrairement à l'ordre inverse, $$a_3$$
puis $$a_2$$, qui est le bon.

<figure>
<img src="/public/fordjohnson2.png"
     title="Fait en TikZ.">
</figure>

De la même manière, on insère $$a_5, a_4$$ pour trois comparaisons chacun ;
$$a_{11},\dots,a_6$$ pour quatre ; $$a_{21},\dots,a_{12}$$ pour cinq ; etc.

La suite $$1,3,5,11,21,\dots$$ des indices séparant ces groupes, dite *de
Jacobsthal*, suit une simple relation de récurrence linéaire du second ordre :

$$J_0 = 0, J_1 = 1,$$

$$J_n = J_{n-1} + 2 J_{n-2}.$$

## Encadrement, bis

Il y a une formule donnant le nombre maximum de comparaisons
du tri de Ford-Johnson :

$$\operatorname{FJ}(n) = \sum_{k=1}^n
  \left\lceil\log_2\left(\frac{3k}{4}\right)\right\rceil$$

Et il colle assez bien à notre minorant.

|---------------------------|---|---|---|---|---|----|----|----|----|----|----|
| $$n$$                     | 1 | 2 | 3 | 4 | 5 |  6 |  7 |  8 |  9 | 10 | 11 |
|---------------------------|---|---|---|---|---|----|----|----|----|----|----|
| $$\operatorname{FJ}(n)$$  | 0 | 1 | 3 | 5 | 7 | 10 | 13 | 16 | 19 | 22 | 26 |
|---------------------------|---|---|---|---|---|----|----|----|----|----|----|
| $$\operatorname{eco}(n)$$ | 0 | 1 | 3 | 5 | 7 | 10 | 13 | 16 | 19 | 22 | 26 |
|---------------------------|---|---|---|---|---|----|----|----|----|----|----|
| $$\lceil\log(n!)\rceil$$  | 0 | 1 | 3 | 5 | 7 | 10 | 13 | 16 | 19 | 22 | 26 |
|---------------------------|---|---|---|---|---|----|----|----|----|----|----|

### Trop beau

|---------------------------|--|--|--|----|----|----|----|----|----|----|----|----|
| $$n$$                     |12|13|14| 15 | 16 | 17 | 18 | 19 | 20 | 21 | 22 | 23 |
|---------------------------|--|--|--|----|----|----|----|----|----|----|----|----|
| $$\operatorname{FJ}(n)$$  |30|34|38| 42 | 46 | 50 | 54 | 58 | 62 | 66 | 71 | 76 |
|---------------------------|--|--|--|----|----|----|----|----|----|----|----|----|
| $$\operatorname{eco}(n)$$ |30|34|38| 42 |  ? |  ? |  ? |  ? | 62 | 66 | 71 |  ? |
|---------------------------|--|--|--|----|----|----|----|----|----|----|----|----|
| $$\lceil\log(n!)\rceil$$  |29|33|37| 41 | 45 | 49 | 53 | 57 | 62 | 66 | 70 | 75 |
|---------------------------|--|--|--|----|----|----|----|----|----|----|----|----|

On a $$\lceil\log(n!)\rceil \lt \operatorname{FJ}(n)$$ pour $$12\leq n \leq
19$$.  Étonamment, il y a à nouveau égalité pour $$n=20,21$$, mais elle
disparaît pour de bon[^citenec] après $$n \geq 22$$.

Malgré les apparences de ces tableaux, l'algorithme de Ford-Johnson
n'est pas un éco-tri en général.

Dans l'ordre chronologique, à coups de force brute électronique, on a trouvé :

- 1965, $$\operatorname{eco}(12)=30$$ ;
- 1994, $$\operatorname{eco}(13)=34$$ ;
- 2004, $$\operatorname{eco}(14)=38$$, $$\operatorname{eco}(22)=71$$[^vingt-deux] ;
- 2007, $$\operatorname{eco}(15)=42$$.

Donc l'algorithme de Ford-Johnson est un éco-tri pour ces valeurs, et que le
minorant n'est pas optimal.

---

## Références

- *The Art of Computer Programming, Vol. 3., Sorting and Searching*, Knuth, 1998.
  Forcément. Contient un chapitre sur les tris optimaux.

- [*Towards Optimal Sorting of 16 Elements*](http://arxiv.org/abs/1108.0866),
  Peczarski, 2011. Un des rares papiers apparement libres sur le sujet.

- *A Tournament Problem*, Ford, Johnson, 1959. L'origine de l'algorithme.

- *The Ford-Johnson algorithm is not optimal*, Manacher, 1979. Le seul résumé
  trouvable mentionne la construction de contre-exemples pour $$t > 189$$.

- [http://www.xomnom.com/fja.html](http://www.xomnom.com/fja.html)
  La page d'où je tire la description de l'algorithme,
  puisque je n'ai pas TACP sous la main.

---

## Appendice

> Que valent $$\lceil\log_2(n!)\rceil$$ et
> $$\operatorname{fusion}(n)$$ lorsque $$n=3 \times
> 1034482758620689655172413793$$ ?

<script type="text/javascript">
  function f() {
    var x = document.getElementById("spoiler");
    x.style = "color:#333333";
  }
  function g() {
    var x = document.getElementById("spoiler");
    x.style = "color:#F0F0F0;background-color:#F0F0F0";
  }
</script>

Réponse :
<span
  id="spoiler"
  style="color:#F0F0F0;background-color:#F0F0F0"
  onmouseover="f()"
  onmouseout="g()"
>
  Respectivement 278947972620843831669777498112[^reponse1] et
  280565481222168823727989709973.
  Tout ceci était un chipotage sur cet écart relatif inférieur à 0.6%.  
  Ford-Johnson prend 279112619665353928462337967605 comparaisons, avec un écart
  relatif au minorant de 0.06%. Le commerçant préférera donc parler du facteur
  10.
</span>

---

[^sym]: Les fanatiques de symétrie pourront supposer que tous les éléments sont
    distincts, ce qui n'apporte rien, ou considérer une comparaison trivaluée,
    (`LT | EQ | GT`), ce qui ne fait que compliquer les choses sans rien changer
    au résultat non plus.

[^tris]: Tris par sélection, à bulles, au revoir. Le tri rapide est lent ; lui
    rajouter un bon choix de pivot coûte trop cher. Le tri par tas a mangé un
    facteur 2, puisqu'il faut faire deux comparaisons pour déterminer l'enfant
    avec lequel on échange son parent.

[^bij]: Y aurait-il une bijection naturelle entre les comparaisons des deux
    algorithmes ?

[^citenec]: Je ne suis pas 100% sûr de ça en fait. Citation nécessaire.
    Je nJe ne trouve pas de contre-exemple pour $$n \le 10000$$.

[^vingt-deux]: (Cet exposant n'est pas une puissance.)
    J'aimerais aussi savoir pourquoi 22.
    L'article convoité se trouve derrière un
    [mur de péage](http://link.springer.com/article/10.1007/s00453-004-1100-7).

[^reponse1]: (Lui non plus.)
    Admirez aussi sa factorisation en nombres premiers :
    $$2^{47}\times1982044556007479$$ !

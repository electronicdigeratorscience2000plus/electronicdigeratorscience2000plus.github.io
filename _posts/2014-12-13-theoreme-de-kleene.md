---
layout: post
title: Diviser avec <code>sed</code>
author: Lyxia
---

<p hidden>
$$
\def\alt{+}
\def\cat{}
\def\define{\overset{\text{def}}=}
\def\ini{\text{i}}
\def\acc{\text{a}}
\def\automaton{\mathcal{A}}
\def\N{\mathbb{N}}
\def\eword{\epsilon}
\def\I{\mathcal{I}}
$$
</p>

##Divisibilité par sept

L'autre jour je me demandais comment déterminer la divisibilité d'un (grand)
entier par sept, car je ne connais effectivement pas de critère de
divisibilité *simple* pour ce nombre. Je retiendrai la première réponse à
<a href="http://math.stackexchange.com/questions/489392/divisibility-by-7">
cette question sur math.SE</a> : doubler le chiffre de poids
faible et le soustraire du reste préserve la divisibilité par sept[^1].
Mouais... Finalement je ne suis pas entièrement convaincu de l'efficacité de
la méthode, ni celle des "graphes de divisibilité" dans la réponse suivante,
par rapport à la méthode classique de la division posée.
L'optimiste en moi répondra qu'une division par sept n'est pas si dure à
poser mentalement de toute façon.

Algorithmiquement, *à diviseur $$d$$ et base $$b$$ fixés*,
le calcul du reste d'une division euclidienne implémenté comme on le
fait à l'école primaire a une complexité en temps linéaire, et en mémoire
constante[^opt]. Donc la division est un automate.

<figure>
<img src="/public/mod7automaton.png"
     title="On n'a pas envie de savoir à quoi ça ressemble en base dix."
     alt="Image d'automate"/>
<figcaption>Automate reconnaissant les multiples de sept en base deux.
</figcaption>
</figure>

Or les **langages reconnaissables** par des automates forment une très jolie
classe, riche par ses différentes caractérisations.
Une d'elles me motive particulièrement.

_Théorème de Kleene_ : un langage est reconnaissable si et
seulement s'il est rationnel.

Pour rappel, les **langages rationnels** sont définis par
des expressions dites **rationnelles**, dont les opérateurs sont :

- la concaténation (le plus souvent implicite par juxtaposition,
  aussi $$\cdot$$),
- l'union (ici $$+$$, aussi $$\cup$$ ou  `|`)
- et l'étoile de Kleene (ici $${}^\star$$, aussi $${}^*$$).

<figure>
\begin{equation}
LL' \define \{mm':m\in L, m'\in L'\}\\
L+L' \define L\cup L'\\
L^\star \define \{m_1\dots m_n:n\in\N; \forall i\in [1;n], m_i\in L\}\\
\end{equation}
<figcaption>Opérations rationnelles.</figcaption>
</figure>

Un corollaire de ce théorème est que la classe des langages rationnels
est, entre autres, close par intersection et passage au complémentaire.
C'est une propriété non évidente du point de vue des expressions rationnelles,
mais les opérations ensemblistes booléennes sont tout à fait triviales
à effectuer sur des automates.

Le sens du théorème "rationnel $$\to$$ reconnaissable" est le plus facile.
On traduit par induction les trois opérations élémentaires sur les langages
en opérations sur les automates[^NFA].

Le sens un peu moins évident dit que tout langage reconnaissable est défini
par une expression rationnelle. Les expressions rationnelles, c'est simple.
Donc on a un critère simple pour la divisibilité par n'importe quel entier,
et on a un outil tout-fait pour l'implémenter ! (*Hum !*)

## La preuve

Le **langage initial**[^i] $$L_e$$ d'un état $$e$$ de l'automate est
l'ensemble des mots $$m$$ qui partant d'un état initial $$e^\ini$$ mènent
à l'état $$e$$ :

$$L_e \define \{m \in \Sigma^\star
:\exists e^\ini\in I, e^\ini \overset{m}{\to} e \}$$

Clairement, le langage reconnu par un automate est égal à l'union des
langages initiaux de ses états acceptants $$e^\acc$$ :

$$L(\automaton) = \bigcup_{e^\acc\in A} L_{e^\acc}$$

Remarque : dans un automate associé à une division
(comme l'exemple ci-dessus),
les langages initiaux sont les classes de congruence modulo $$d$$.
On construira une expression rationnelle pour chacun de ces langages
puis on donnera le tout à `sed`, qui n'aura plus qu'à associer des nombres
au bon motif. (*Tout va comme sur des roulettes.*)

Une transition $$e' \overset{\sigma}{\longrightarrow} e \in\Delta$$ ($$\sigma\in\Sigma$$)
dans l'automate se traduit en une inclusion
$$L_{e'}\cat\sigma \subseteq L_e$$ ;
en prenant en compte toutes les transitions, on obtient des *équations
linéaires* :

$$L_e = \sum_{e'\in E} L_{e'}\cat\Delta_{e',e} + \I_e$$

où
$$\displaystyle\Delta_{e',e} \define
\sum_{\sigma:(e',\sigma,e)\in\Delta} \sigma$$
et $$\I_e$$ vaut $$\epsilon$$[^epsilon] si $$e$$ est un état initial,
$$\emptyset$$ sinon.

<figure>
{% capture equations %}
\begin{array}{lcccccc}
{% for i in (0..6) %}
L_{{i}} &=& L_{{i | divided_by: 2}}\cat\mathtt{ {% cycle '1': 0,1 %} }
&\alt& L_{{i | plus: 1 | divided_by: 2 | plus: 3}}\cat\mathtt{ {% cycle '2': 1,0 %} }
{% if i == 0 or i == 1 %} &\alt& \mathtt{ {% cycle '3': 0,1 %} }{% else %}&&{% endif %}
{% if i < 6 %}\\{% endif %}
{% endfor %}
\end{array}
{% endcapture %}{{equations | strip_newlines | remove: ' '}}
<figcaption>
Équations associées à l'automate dessiné ci-dessus.</figcaption>
</figure>

Matriciellement, on a

$$L = L\Delta + \I.$$

Ou, avec des matrices augmentées,

$$\bar{L} \define (L;\epsilon)$$

$$\bar{\Delta}\define\left(\begin{matrix}\Delta\\\I\end{matrix}\right)$$

cela se réécrit évidemment

$$\bar{L}=\bar{L}\bar{\Delta}.$$

### Automate généralisé

Dans cette construction-là, les coefficients de la matrice $$\bar{\Delta}$$
sont des langages faits de mots à zéro ou une lettre.
Au cours de la résolution, on aura aussi affaire à des systèmes $$L=L\Delta$$
avec des langages a priori quelconques pour coefficients de $$\Delta$$.
Cette généralisation s'interprète automatiquement[^auto] ;
on peut penser à $$\Delta$$ comme une matrice de transition,
définissant un **automate généralisé**[^general] :
un automate non déterministe où les transitions sont étiquettées non par des
lettres mais par des langages ; pour définir l'acceptation d'un mot lu en
entrée, il faut alors deviner non seulement les transitions à suivre,
mais aussi une factorisation adaptée du mot, chaque facteur devant
appartenir au langage qui étiquette la transition correspondante.

L'algorithme décrit dans la suite peut être traduit en termes
de transformations d'automates généralisés, ce qui donne
l'**algorithme de McNaughton et Yamada**[^ici].

### Résolution d'une équation

On considère ici une seule équation linéaire de langages, de forme générale :
\\[X=X\Lambda+\Xi,\\]
d'inconnue $$X$$, et paramètres $$\Lambda$$ et $$\Xi$$ (éventuellement vides).

Dans le contexte d'un système linéaire, $$\Xi$$ est une combinaison linéaire
d'inconnues distinctes de $$X$$ et de coefficients de $$\I$$.
Par exemple, dans $$L_0 = L_0\mathtt{0} + L_3\mathtt{1} + \mathtt{0}$$,
on a $$X=L_0$$, $$\Lambda=\mathtt{0}$$, $$\Xi=L_3\mathtt{1}+\mathtt{0}$$.

On résout :

\begin{align}
  X           &=X\Lambda+\Xi\\\\\\
  X(1-\Lambda)&=\Xi\\\\\\
  X           &=\Xi(1-\Lambda)^{-1}\\\\\\
\end{align}

`/me chantonne.` Développons...

\begin{align}
  X&=\Xi(1+\Lambda+\Lambda\Lambda+\Lambda\Lambda\Lambda+\dots)\\\\\\
  X&=\Xi\Lambda^\star
\end{align}

Ce pipeautage est une fausse preuve du vrai *lemme d'Arden*[^exo],
qui donne $$X=\Xi\Lambda^\star$$ comme solution.

Cette solution est unique si et seulement si $$\Lambda$$ est sans mot vide ;
c'est le cas lorsque les équations décrivent des automates
sans $$\epsilon$$-transitions.
Plus généralement, $$\Xi\Lambda^\star$$ est toujours la plus petite solution
au sens de l'inclusion.
Dans tous les cas on peut montrer que par ce minimum on obtient bien les
langages initiaux d'un automate[^fixpoint].

### Pivot de Gauss

Le lemme d'Arden et la substitution sont les opérations de base
qui permettent en fait d'exécuter un pivot de Gauss sur
le système du pipeau suivant :

\\[L(1-\Delta) = \I.\\]

- Une équation

  $$L_i=\sum_kL_k\Delta_{k,i}+\I_i$$

  devient, par application du lemme d'Arden,

  $$L_i
    =\sum_{k\neq i}L_k\Delta_{k,i}\Delta_{i,i}^\star+\I_i\Delta_{i,i}^\star.$$

  Ça revient à normaliser le coefficient diagonal
  "$$1-\Delta_{i,i}$$" de la $$i$$-ème colonne[^transpose] de "$$1-\Delta$$".

- Après cela, on réécrit l'équation

  $$L_i = \sum_{k\neq i}L_k\Delta'_{k,i} + \I'_i$$

  on substitue $$L_i$$ dans une autre équation (pour $$i\neq j$$)

  $$L_j = \sum_kL_k\Delta_{k,j} + \I_j$$

  ce qui donne

  $$L_j = \sum_{k\neq i}L_k(\Delta_{k,j}+\Delta'_{k,i}\Delta_{i,j})
  + \I_j + \I'_i\Delta_{i,j}.$$

  C'est l'addition d'un multiple,
  avec coefficient $$\Delta_{i,j}$$, de la $$i$$-ème colonne
  à la $$j$$-ème colonne de "$$1-\Delta$$".

La réduction termine après élimination de toutes les variables
dans le membre de droite, quand $$\Delta=0$$.
Le pivot de Gauss donne une solution linéaire en $$\I$$,
qui se résume au produit par une matrice que l'on notera
$$\Delta^\star$$:

$$L=\I\Delta^\star.$$

Les expressions rationnelles issues de la construction de $$\Delta^\star$$
peuvent dépendre de l'ordre dans lequel on résout les équations,
mais les langages sous-jacents sont les mêmes.

### On peut diviser avec `sed`

Sur ces idées, j'ai écrit un
[solveur d'équations linéaires de langages](http://www.eleves.ens.fr/home/xia/sandbox/kleene)
(prétexte à faire du JS),
et un petit programme qui convertit le résultat et plus encore,
une liste d'expressions rationnelles, en script `sed` :
il lit un mot d'une ligne et répond avec le premier langage
dans la liste qui contient la ligne d'entrée.

L'objectif de départ étant de faire des divisions,
[ici](http://www.eleves.ens.fr/home/xia/sandbox/sedify/mod7base10.sed)
se trouve un script `sed` (0.5 Mo !) qui "calcule" le reste de la division
de l'entrée en base dix par sept. D'autres exemples sont à trouver
[là](http://www.eleves.ens.fr/home/xia/sandbox/sedify).
Si vous tenez à calculer des divisions par votre nombre préféré
à coup d'expressions rationnelles, la page du solveur a des boutons pour ça.

### Ce qui me dépasse

Une implémentation naïve donne des expressions de
tailles exponentielles en la taille du système. Y aurait-il des moyens
pratiques de réduire la taille des expressions ? Ou au contraire,
peut-on montrer l'impossibilité de la tâche ?

Généralisations dans d'autres structures que $$\Sigma^\star$$,
comme les demi-anneaux et algèbres de Kleene[^graph]...

---

[^1]: Parce que 7 divise 21, en bases $$3 + 7k$$, $$k\geq 0$$.

[^opt]: C'est optimal quand $$d$$ possède un diviseur premier avec $$b$$.

[^NFA]: <a href="http://hackingoff.com/compilers/regular-expression-to-nfa-dfa">
      Cette page</a> dessine des automates reconnaissant le langage défini
      par les expressions rationnelles qu'on lui donne.

[^i]: En fait, dans mes cours j'ai plutôt vu défini
      le **langage résiduel** d'un état $$e$$ de l'automate :
      l'ensemble des mots qui en partant de $$e$$ (au lieu d'un état initial)
      mènent à un état acceptant.
      Le langage reconnu par un automate est égal à
      l'union des langages résiduels de ses états initiaux.
      On obtient aussi des équations linéaires, sauf que
      les "coefficients" sont à gauche des inconnues $$L(e)$$ et
      un terme constant $$\epsilon$$ apparaît pour les états acceptants
      plutôt qu'initiaux.
      Mais dans le contexte de la reconnaissance de multiples,
      les langages initiaux associent un sens plus naturel aux états des
      automates, du moins lorsque l'on lit les nombres de gauche à droite.

      Les langages résiduels ou initiaux sont aussi utiles dans l'étude
      des automates minimaux (plus petits automates reconnaissant leur
      langage).

[^epsilon]: $$\{\epsilon\}$$, aussi noté $$1\,$$ car on est dans un
      semi-anneau. L'ensemble vide est lui noté $$0$$.

[^auto]: Il faut lire "automate-iquement" bien sûr.

[^general]: Appelation qui coïncide avec
      [ce cours](http://li.linguist.univ-paris-diderot.fr/PagesCours/pdf/poly-li324-1.pdf)
      que j'ai trouvé par hasard, apparement dans un cursus de linguistique.
      On parle d'"extended automaton" dans le poly du cours 2.20.2 du MPRI
      ([Fondations mathématiques de la théorie des automates](https://wikimpri.dptinfo.ens-cachan.fr/doku.php?id=cours:c-2-20-2))

      Ce type d'automate généralise les automates (non) déterministes,
      avec ou sans $$\epsilon$$-transition... (Points de suspension du pipeau,
      c'est en fait tout ce que j'ai comme exemples.)

[^ici]: Décrit succinctement dans le premier lien de la note
      précédente[^general]. Pour plus de clarté, un algorithme dans le
      sens inverse est parfois attribué à ces mêmes noms ;
      voir note [^NFA].

[^exo]: À faire proprement en exercice ; points bonus pour
      une application du théorème de point fixe de Kleene. (Il est partout.)

[^fixpoint]: Une construction itérative des langages initiaux,
      en limitant le nombre de transitions parcourues depuis un état initial
      par exemple, créée un point fixe à la Kleene.

[^transpose]: Se rappeler que celui qui écrit ces lignes a décidé de tout
      transposer pour le confort de tous.

[^graph]: [Ce premier résultat Google](http://www.diva-portal.org/smash/get/diva2:690270/FULLTEXT01.pdf)
      pour la requête "matrix Kleene star" contient un autre exemple :
      dans l'algèbre min-plus,
      l'étoile de Kleene d'une matrice d'adjacence donne les longueurs
      des plus courts chemins entre les sommets !


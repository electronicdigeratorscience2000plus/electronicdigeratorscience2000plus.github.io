---
layout: post
title: Hello world, et \( \pi \)
---

Bonjour le monde ! Ceci est le premier billet sur ce blog collectif
francophone qui parlera de maths, d'informatique, de linguistique et
de choses apparentées.

Pour commencer, voici un billet de maths élémentaires qui n'est bien
sûr qu'un prétexte pour montrer le joli rendu des formules de maths en
$$\LaTeX$$ par [MathJax](http://www.mathjax.org/).

---------------------

Quelques formules où le nombre $$\pi$$ intervient
-------------------------------------------------

Je[^1] n'ai jamais été un fanatique de $$\pi$$, ni de
[l'autre prétendant](http://www.tauday.com/tau-manifesto) au statut de
constante fondamentale du cercle euclidien. Généralement je considère
que la vraie beauté des mathématiques est dans ses concepts et non
dans des nombres individuels. Pourtant, en y réfléchissant récemment,
je me suis rendu compte que $$\pi$$) avait tendance à apparaître dans
plein de formules remarquables où on ne l'attend pas. Bien sûr, on
trouve sur la Wikipédia anglophone une
[liste](http://en.wikipedia.org/wiki/List_of_formulae_involving_π)
certainement non exhaustive de telles formules. Voici une petite
sélection.

### L'identité d'Euler : $$e^{i\pi} + 1 = 0$$

Impossible d'y échapper : cette formule est souvent vendue auprès du
grand public comme un summum de la beauté mathématique[^2], avec ses 5
constantes et 3 opérations fondamentales. C'est plutôt classe mais
pourquoi se cantonnner à un cas particulier de $$ \exp(ix) = \cos(x) +
i \sin(x) $$ ? Voilà une formule qui exprime à merveille comment
algèbre, géométrie et analyse sont unifiées dans le plan complexe.

Une preuve de ce résultat, c'est d'écrire les séries entières des deux
côtés et de simplement constater que ça marche. Mais comme $$t \mapsto
e^{it}$$ est une fonction à variable réelle, on peut se passer des
arguments d'analyse complexe (car c'est bien de ça dont il
s'agissait : l'unique prolongement analytique de l'exponentielle). On
peut constater par exemple que $$t \mapsto \cos(t) + i \sin(t)$$ est
solution de la bonne équation différentielle, ou encore qu'elle
vérifie la propriété de morphisme et que sa dérivée en 0 est $$i$$.

### Le problème de Bâle

Il s'agit d'un défi résolu par Euler :

$$ \zeta(2) = \sum_{n=1}^\infty \frac{1}{n^2} = \frac{\pi^2}{6} $$

C'est quand même très surprenant. Ce résultat a connu beaucoup de
preuves différentes, certaines élémentaires mais reposant sur des
calculs astucieux à base de fonctions trigonométriques. La
démonstration d'Euler était une arnaque que l'analyse complexe a su
justifier _a posteriori_ (voir plus loin).

Autre démonstration célèbre à base de séries de Fourier : appliquer
l'identité de Parseval à une fonction "dents de scie", définie sur une
période $$]-\pi, \pi]$$ comme $$x \mapsto x$$. J'ai découvert le
résultat avec cette preuve en Terminale : coup de foudre immédiat !
Vouloir comprendre la preuve m'a motivé à apprendre les bases de la
théorie des espaces de Hilbert.

Plus généralement, tous les $$\zeta(2n)$$ pour $$n \in
\mathbb{N}*$$[^3] sont des multiples rationnels de $$\pi^{2n}$.

### L'inégalité de Wirtinger

Encore un petit coup de Fourier : en comparant les coefficients de
Fourier d'une fonction 1-périodique et de sa dérivée on obtient

$$ \int_0^1 |f(t)|^2 dt \leq \frac{1}{4\pi^2}\int_0^1 |f'(t)|^2 dt $$

Par exemple en travaillant sur des lacets simples dans le plan
euclidien on peut obtenir l'inégalité isopérimétrique dont le cas
d'égalité est le cercle : nous voilà revenus aux bases.

### Le produit de Wallis

Un grand classique taupinal à base d'intégration par parties permet
d'obtenir

$$ \prod_{n=1}^\infty \left( \frac{2n}{2n-1}\times\frac{2n}{2n+1} $$

Les formules faisant apparaître $$\pi$$ comme somme ou produit infini
avec des fractions sont légion (pensons par exemple à $$\arctan(1)$$
avec sa série entière ; ç'aurait été plus original avec du $$\pi^k,
k>1$$, tout ça…). Si celle-ci a l'honneur d'être choisie comme
représentante du genre, c'est à cause de…

### La formule de Stirling !

$$ n! \underset{n \to \infty}{\sim} \sqrt{2\pi n} \left( \frac{n}{e} \right)^n $$

Trop fort. On obtient ça à un facteur près en passant au logarithme et
en bidouillant avec des séries téléscopiques ; la constante
$$\sqrt{2\pi}$$ est obtenue en injectant l'équivalent dans le produit
de Wallis.

Donald Knuth a une
[démonstration alternative](https://apetresc.wordpress.com/2010/12/28/knuths-why-pi-talk-at-stanford-part-1/)
de l'apparition de $$\pi$$ là-dedans, qui relie nombres de Catalan et
quart de disque.[^4]

### Formules trigonométriques stylées

$$ \frac{\sin(\pi z)}{\pi z} = \prod_{n=1}^\infty \left( 1 - \frac{z^2}{n^2} \right) $$

C'est le théorème de factorisation de Hadamard[^5] qui justifie
rigoureusement ce qu'Euler avait affirmé par simple analogie avec les
polynômes, qui se factorisent à partir de leur racines. On en déduit
$$\zeta(2)$$ en développant et en comparant les coefficients avec la
série entière du sinus. Pour $$z=\frac{1}{2}$$ c'est la formule de
Wallis qu'on retrouve.

Ce même théorème, appliqué à $$\sin(z) - z\cos(z)$$, mène à un truc
hallucinant :

$$ \sum_{x>0, \tan(x)=x} \frac{1}{x^2} = \frac{1}{10} $$

Encore une fois, d'autres preuves sont possibles, par exemple en se
basant sur des fonctions de Green[^6].

### En guise de conclusion

Le nombre $$\pi$$, c'est frais[^7], l'analyse complexe, c'est encore
mieux ! D'ailleurs, une grande absente de cette liste de formules,
c'est la formule intégrale de Cauchy, omise car sa grande beauté est
indépendante de la présence ou non de $$\pi$$ dans le facteur
constant.


[^1]: C'est ici, après un message collectif de bienvenue, que la voix
      individuelle de l'auteur de cet article fait surface.

[^2]: Trouvé sur Wikipédia : Keith Devlin aurait écrit "Like a
      Shakespearean sonnet that captures the very essence of love, or
      a painting that brings out the beauty of the human form that is
      far more than just skin deep, Euler's equation reaches down into
      the very depths of existence". Ça serait pas un peu exagéré ?

[^3]: Même si Bourbaki ne l'a pas voulu, l'usage du "gras tableau
      noir" pour les ensembles usuels est une superbe convention, même
      à l'écrit.

[^4]: Vous venez sans doute de lire l'information la plus
      intéressante de ce billet.

[^5]: C'est-à-dire le théorème de Weierstrass dans le cas d'une
      fonction d'ordre fini.

[^6]: Voir à ce propos cet épique
      [devoir maison](http://jimmy-leucate.fr/wp-content/uploads/2013/11/DL-du-27-02-2012-enonce.pdf)
      donné à Fermat en MP* où on étudie le problème de
      Sturm-Liouville, en traitant pour les besoins du sujet le
      théorème d'Ascoli et la théorie des opérateurs auto-adjoints
      compacts, pour aboutir à la fin sur ce $$\frac{1}{10}$$.

[^7]: "cool" en français, évidemment…


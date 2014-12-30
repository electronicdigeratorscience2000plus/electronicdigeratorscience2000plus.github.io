---
layout: post
title: Système métrique anglais et des choses plus sérieuses
author: oudi
---


Pour parler un peu de science amusante, pourquoi ne pas discuter des systèmes 
métriques ? Quand se pose la question des mesures des poids, distances, volumes 
de choses liquides ou sèches[^1], les peuples et les ministères ne semblent 
jamais à court d'idées farfelues. Du moins, jusqu'à l'époque moderne et 
l'hégémonie du triste, insipide et totalitaire *Système International*. 
Mais nous nous égarons.

Prenez, par exemple, le système de mesure des masses *avoirdupois*[^2] 
post-elizabéthain, qui est grosso modo celui qu'utilisent officiellement les 
Américains et officieusement les Britanniques. Il contient sept unités :

- on prend pour unité de base la *drachme* (en anglais actuel *drachm* ou 
  *dram*), qui correspond à 1,772 g ;

- 16 drachmes font une *once* (*ounce*) ;

- 16 onces font une *livre* (*pound*) ;

- 14 livres font une *pierre* (*stone*) ;

- 2 pierres font un *quart* (*quarter*, qui se dit par ailleurs *sak de leine* 
  en anglo-normand) ;

- 4 quarts font un *quintal* (*hundredweight*, qui fait, pour ceux qui suivent, 
  environ 50,8kg) ;

- 20 quintaux font une *tonne* (*ton*, qui fait donc... un peu plus qu'une 
  tonne).

C'est beau, c'est joyeux, c'est coloré ! Mais surtout, c'est l'occasion de se 
poser des problèmes mathématiques. Qu'est-ce, en somme, qu'un système métrique ?
C'est un système de représentation des nombres (qui doit avoir certaines 
qualités : être agréable, pratique, intuitif). Par exemple, au lieu de dire 
"À la saison dernière, ma châtaigneraie a donné exactement 1367399 drachmes de 
châtaignes", on dira "2 tonne, 7 quintaux, 2 quarts, 1 pierre, 7 livres, 6 onces
et 7 drachmes de châtaignes". C'est plus parlant, on se représente plus aisément
la quantité, et on peut arrêter d'écouter l'exploitant agricole après "quintaux"
car on a déjà l'information intéressante.

Finalement, qu'a-t-on fait ? On a représenté l'entier 1367399 comme une somme de
sept éléments : le nombre de tonnes, de quintaux, de quarts, de pierres, de 
livres, d'onces et de drachmes. Cette décomposition a l'avantage d'exister pour 
tout nombre entier, et d'être unique si on s'interdit de dire des choses 
étranges comme "17 onces" au lieu de "une livre et une once". Autrement dit, on 
va considérer que l'ensemble "drachmes" contient 16 éléments (0 drachme, 1 
drachme, ..., 15 drachmes), l'ensemble "onces" en contient aussi 16, l'ensemble 
"livres" 14, etc. Seul l'ensemble "tonnes" contient une infinité d'éléments, 
mais celui-ci est un peu particulier, nous y reviendrons.

Le mathématicien N.G. de Bruijn s'est intéressé à ces questions de 
représentation des nombres comme sommes, dans un petit article très agréable de 
1956[^3]. Toute la première partie de ce billet sera essentiellement un 
recopiage de cet article.

##Bases additives

Ainsi donc, le système *avoirdupois* est pour nous une façon de représenter tout
entier de manière unique comme une somme de 7 entiers pris dans 7 ensembles 
prédéfinis. Généralisons cette idée.

*Définition* : on appelle **base additive** de $$\mathbb{N}$$ une famille 
$$(A_i)_{i \in I}$$ de parties de $$\mathbb{N}$$ indexée par $$I$$ fini ou 
infini, telles que tout entier $$n\in \mathbb{N}$$ s'écrit de manière unique 
comme somme (finie) d'éléments $$n=\sum_{i \in I} a_i$$ où $$a_i \in A_i$$. 
Dans ce cas on note 

$$\bigoplus_{i \in I} A_i = \mathbb{N}.$$

*Exemple* : en observant le fonctionnement des systèmes métriques, on a une 
procédure pour construire des bases additives. On se donne une suite 
$$(x_k)_{k\geq 1}$$ d'entiers supérieurs ou égaux à $$2$$, puis on note

$$ X_0 = 1 \ , \ X_n = \prod_{k=1}^{n} x_k \ \mathrm{pour} \ n\geq 1.$$

Enfin, on pose $$A_n = \{ 0, X_n, 2X_n, \dots, (x_{n+1}-1)X_n \}$$. Alors on a 
$$\bigoplus_{n \geq 0} A_n = \mathbb{N}$$. On appelle 
**système métrique britannique** une base additive de cette forme.

Dans le cas du système *avoirdupois*, la suite $$(x_k)$$ commence par 
$$(16,16,14,2,...)$$. C'est une suite finie, mais imaginons un instant qu'elle 
soit infinie. Alors, les entiers $$(X_n)$$ représentent le poids en drachmes 
d'une drachme, d'une once, d'une livre, etc. Les ensembles $$(A_n)$$ 
représentent les nombres de drachmes, d'onces, de livres... dans la masse 
considérée. Il est facile de se convaincre que ces ensembles forment une base 
additive.

Étant donné une base additive $$(A_i)_{i \in I}$$, on peut en construire 
beaucoup d'autres en effectuant un **regroupement par paquets** : on décompose 
$$I$$ comme union disjointe $$I = \bigsqcup_{j \in J} I_j$$, et on note 
$$B_j = \sum_{i \in I_j} A_i$$, c'est-à-dire que les éléments de $$B_j$$ 
s'écrivent comme des sommes finies $$\sum_{i \in I_j} a_i$$ où $$a_i \in A_i$$. 
Alors les $$(B_j)_{j \in J}$$ forment encore une base additive.

Cette manipulation permet en particulier d'obtenir le système *avoirdupois*, 
pour lequel on n'avait qu'une suite $$(x_n)$$ finie. Il suffit de continuer 
cette suite n'importe comment, puis de regrouper tous les ensembles à partir du 
septième[^4]. Ce n'est pas un hasard, car on a le joli théorème suivant :

*Théorème (de De Bruijn)* : Toute base additive de $$\mathbb{N}$$ peut s'obtenir
comme regroupement par paquets d'un système métrique britannique.

##Bases multiplicatives

Ainsi donc le cas des bases additives de $$\mathbb{N}$$ est bien compris. Mais 
qu'en est-il, par exemple, des bases multiplicatives ?

*Définition* : on appelle **base multiplicative** de $$\mathbb{N}^*$$ une 
famille $$(A_i)_{i \in I}$$ de parties de $$\mathbb{N}^*$$ indexée par $$I$$ 
fini ou infini, telles que tout entier $$n\in \mathbb{N}^*$$ s'écrit de manière 
unique comme produit (fini) d'éléments $$n=\prod_{i \in I} a_i$$ où 
$$a_i \in A_i$$. Dans ce cas on note 

$$\bigotimes_{i \in I} A_i = \mathbb{N}^*.$$

*Question* : pour ceux qui suivent : pourquoi ne s'intéresse-t-on pas aux bases 
multiplicatives de $$\mathbb{N}$$ ?

En fait on va être modeste et s'intéresser par la suite au cas d'une base 
constituée de deux ensembles. Remarquons que 

$$A \otimes B = \mathbb{N}^* \ \Longleftrightarrow \ \bigsqcup_{b\in B} bA = \mathbb{N}^*$$

où le symbole $$\bigsqcup$$ désigne une union disjointe.

###Densités asymptotiques

Pour $$A \subset \mathbb{N}$$, on définit

$$d^+ (A) = \limsup_{n} \frac{\# A\cap [1;n]}{n},$$

$$d^- (A) = \liminf_{n} \frac{\# A\cap [1;n]}{n}.$$

Lorsque ces deux quantités sont égales, on dit que A 
**admet une densité asymptotique** et on note $$d(A)$$ leur valeur commune, qui 
est aussi la limite de $$\frac{\# A\cap [1;n]}{n}$$.

Quel est le rapport avec la choucroute ? C'est le petit théorème suivant.

*Théorème* : Si $$A \otimes B = \mathbb{N}^*$$ alors 

$$\frac{1}{d^+ (A)} \leq \sum_{b \in B} \frac1b \leq \frac{1}{d^- (A)},$$

en interprétant $$\frac10$$ comme $$+\infty$$.

On va démontrer ce théorème, en commençant par un petit lemme :

*Lemme* : $$d^{\pm} (bA) = \frac1b d^{\pm}(A)$$.

*Démonstration du lemme* : 
  On remarque que $$\# A\cap [1;n] = \# bA\cap [1;bn]$$ donc

  $$\frac1b \limsup_{n} \frac{\# A\cap [1;n]}{n} =  \limsup_{n} \frac{\# bA\cap [1;bn]}{bn} \leq \limsup_{m} \frac{\#   bA\cap [1;m]}{m}$$

  donc $$\frac1b d^+ (A) \leq d^+ (bA)$$. Dans l'autre sens, on remarque que 
  $$\# bA\cap [1;m] = \# A\cap [1;\lfloor \frac{m}{b} \rfloor]$$ donc

  $$ \limsup_{m} \frac{\# bA\cap [1;m]}{m} = \limsup_{m} \frac{\lfloor \frac{m}{b} \rfloor}{m} \frac{\# A\cap [1;\lfloor \frac{m}{b} \rfloor]}{\lfloor \frac{m}{b} \rfloor} \leq \frac1b \limsup_{n} \frac{\# A\cap [1;n]}{n} $$

  donc $$\frac1b d^+ (A) \geq d^+ (bA)$$ et donc c'est égal. Pour la $$\liminf$$ 
  c'est pareil. $$\Box$$

Passons à la preuve légèrement plus intéressante du théorème. Par le 
[lemme de Fatou](http://fr.wikipedia.org/wiki/Lemme_de_Fatou), 

$$\sum_{b\in B} \liminf_{n} \frac{\# bA\cap [1;n]}{n} \leq \liminf_{n} \sum_{b\in B} \frac{\# bA\cap [1;n]}{n}.$$

Or le terme de droite vaut $$1$$ puisque les $$bA$$ partitionnent 
$$\mathbb{N}^*$$. Quant au terme de gauche, il vaut

$$\sum_{b\in B} d^- (bA) = d^- (A) \sum_{b\in B} \frac1b$$

par le lemme, et donc l'inégalité précédente donne 

$$\sum_{b \in B} \frac1b \leq \frac{1}{d^- (A)}$$

ce qui est la moitié du théorème. Pour l'autre moitié, on distingue deux cas :

- Si $$\sum_{b \in B} \frac1b = + \infty$$, il n'y a rien à prouver.
- Si $$\sum_{b \in B} \frac1b$$ est finie, on remarque que 
  $$\frac{\# bA\cap [1;n]}{n} \leq \frac{\lfloor \frac{n}{b} \rfloor}{n} \leq \frac1b$$
  puis on applique le lemme de Fatou[^5] à $$\frac1b-\frac{\# bA\cap [1;n]}{n}$$,
  et on simplifie les $$\sum_{b \in B} \frac1b$$. On obtient
  
  $$\sum_{b\in B} \limsup_{n} \frac{\# bA\cap [1;n]}{n} \geq \limsup_{n} \sum_{b\in B} \frac{\# bA\cap [1;n]}{n}$$

  et comme précédemment, le terme de droite vaut 1 et le terme de gauche vaut 
  $$d^+ (A) \sum_{b\in B} \frac1b$$ par le lemme, ce qui termine la preuve.

*Corollaire* : Si $$A \otimes B = \mathbb{N}^*$$ et si $$A$$ admet une densité 
asymptotique alors

$$\frac{1}{d(A)} = \sum_{b \in B} \frac1b .$$

####Quelques exemples d'utilisation

- Soit $$r\in \mathbb{N}^*$$, on pose 
   $$A = \{n \in \mathbb{N}^* \ \mathrm{t.q. } \ r \ \mathrm{ne \ divise \ pas} \ n\}$$
   et $$B=\{1, r, r^2, r^3, \dots \}$$. On a clairement 
   $$A \otimes B = \mathbb{N}^*$$, et $$A$$ a pour densité $$\frac{r-1}{r}$$, 
   donc on découvre avec stupeur que
   
  $$\sum_{k\geq 0} \frac{1}{r^k} = \frac{r}{r-1}.$$
   
- Soit $$B=\{1,4,9,16,\dots\}$$ l'ensemble des carrés, et $$A$$ l'ensemble des 
   nombres *squarefree*, c'est-à-dire divisibles par aucun carré (*i.e.* 
   produits de nombres premiers distincts). On a aussi $$A \otimes B = \mathbb{N}^*$$,
   de plus $$\sum_{n\geq 1} \frac{1}{n^2} = \frac{\pi ^2}{6}$$, et donc la 
   densité des nombres *squarefree* vaut $$\frac{6}{\pi^2}$$. Évidemment il y 
   a une arnaque : je n'ai pas prouvé que $$A$$ avait une densité (ce qui n'est 
   pas facile à prouver, et sans doute plus profond que la valeur elle-même...).
   
- Dans la même veine, je ne sais pas grand chose de $$\zeta(3)$$, mais je suis 
   convaincu que c'est l'inverse de la densité des nombres *cubefree* !

###Vers une classification

De même que N.G. de Bruijn a classifié toutes les bases additives de 
$$\mathbb{N}$$, peut-on classifier toutes les bases multiplicatives de 
$$\mathbb{N}^*$$ ? La question n'est pas simple. La décomposition en facteurs 
premiers nous donne une bijection entre $$\mathbb{N}^*$$ et 
$$\mathbb{N}^{(\mathbb{N})}$$, les suites d'entiers à support fini. De plus
cette bijection conjugue la multiplication des entiers avec l'addition des 
suites. Donc une base multiplicative de $$\mathbb{N}^*$$ équivaut à une base 
additive de $$\mathbb{N}^{(\mathbb{N})}$$. Or celles-ci ne sont pas, à ma 
connaissance, classifiées (pas même d'ailleurs celles de $$\mathbb{N}^2$$, avis 
aux amateurs). Ça donne toutefois une recette pour fabriquer des bases 
multiplicatives, que voici.

- Pour tout nombre premier $$p$$, on choisit une base additive 
  $$(A^p_i)_{i\in I}$$ de $$\mathbb{N}$$ (il est important que l'ensemble 
  d'indices $$I$$ soit le même pour tout $$p$$).
- Pour $$i\in I$$ on pose $$\mathcal{A}_i$$,
  l'ensemble des entiers qui s'écrivent comme produits 
  _finis_ $$\prod_{p \ \mathrm{ premier}} p^{a^p_i}$$ où $$a^p_i \in A^p_i$$.
- Alors les $$(\mathcal{A}_i)_{i \in I}$$ forment une base multiplicative de 
  $$\mathbb{N}^*$$. 

Les deux exemples donnés précédemment sont de ce type, mais
en voici un qui ne l'est pas. Pour $$p$$ premier, on note $$\nu_p(n)$$ la 
*valuation $$p$$-adique* de $$n$$, c'est-à-dire la puissance à laquelle apparaît
$$p$$ dans la décomposition en facteurs premiers de $$n$$. On pose 
$$A=\{n \in \mathbb{N}^* \ \mathrm{ t.q. } \ \nu_2(n) = \nu_3(n)\}$$ et 
$$B=\{2^n, n\in\mathbb{N}\} \cup \{3^n, n\in\mathbb{N}\}$$, c'est une base
multiplicative qui n'est pas obtenue par la recette.

Je laisse ici ces considérations vagues, et vous enjoins à jouer avec le 
corollaire énoncé plus haut sans trop vous préocupper de montrer que les 
ensembles admettent une densité (de toute façon je suis convaincu que de tels 
ensembles sont tous assez sympa pour en admettre une). Par exemple, dans le 
paragraphe précédent, que vaut la densité de $$A$$ ?

---

[^1]: Car il existe des [dénominations différentes](http://fr.wikipedia.org/wiki/Anciennes_unités_de_mesure_françaises#Unit.C3.A9s_de_volume_et_de_capacit.C3.A9)
      pour ces deux choses.

[^2]: À prononcer avec l'accent anglais. C'est la contraction d'une locution en 
      anglo-normand qui signifie en fait "avoirs de poids", c'est-à-dire les 
      biens, les possessions du point de vue du poids, puisqu'il s'agissait de 
      standardiser les échanges marchands. L'origine géographique de ce système 
      reste incertaine, mais on peut dater son arrivée en Angleterre aux 
      environs du 13ème siècle.

[^3]: de Bruijn, N. G. On number systems. *Nieuw Arch. Wisk.* (3) 4 (1956), 
      15–17. Voir aussi un [article plus détaillé](http://arxiv.org/abs/1301.6208v2)
      (*i.e.* sans arnaque) par M.B. Nathanson.

[^4]: On pourrait aussi adapter la définition d'une base additive pour des 
      suites $$(x_n)$$ finies, mais dont le dernier élément vaut $$+\infty$$.

[^5]: Rappelons que pour utiliser le lemme de Fatou il faut que les fonctions 
      soient positives. Il m'est arrivé d'écrire de grosses bêtises en oubliant 
      cette hypothèse...

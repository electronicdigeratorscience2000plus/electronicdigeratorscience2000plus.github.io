---
layout: post
title: Hello world, et $$\pi$$
---

Bonjour le monde ! Ceci est le premier billet sur ce blog collectif
francophone qui parlera de maths, d'informatique, de linguistique et
de choses apparentées.

Pour commencer, voici un billet de maths élémentaires qui n'est bien
sûr qu'un prétexte pour montrer le joli rendu des formules de maths en
$$\LaTeX$$ par [MathJax](http://www.mathjax.org/).

Quelques formules où le nombre $$\pi$$ intervient
---------------------

Je[^1] n'ai jamais été un fanatique de $$\pi$$, ni de
[l'autre prétendant](http://www.tauday.com/tau-manifesto) au statut de
constante fondamentale du cercle euclidien. Généralement je considère
que la vraie beauté des mathématiques est dans ses concepts et non
dans des nombres individuels. Pourtant, en y réfléchissant récemment,
je me suis rendu compte que \( \pi \) avait tendance à apparaître dans
plein de formules remarquables où on ne l'attend pas. Bien sûr, on
trouve sur la Wikipédia anglophone une
[liste](http://en.wikipedia.org/wiki/List_of_formulae_involving_π)
certainement non exhaustive de telles formules. Voici une petite
sélection.

### L'identité d'Euler : $$e^{i\pi} + 1 = 0$$

Impossible d'y échapper : cette formule est souvent vendue auprès du
grand public comme un summum de la beauté mathématique, avec ses 5
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



$$ \sum_{n=1}^\infty \frac{1}{n^2} = \frac{\pi^2}{6} $$

$$ n! \sim_{n \to \infty} \sqrt{2\pi n} \left( \frac{n}{e} \right)^n $$

[^1]: C'est ici, après un message collectif de bienvenue, que la voix
      individuelle de l'auteur de cet article fait surface.



# Test technique Leboncoin

Test technique réalisé à la demande de M. Kader DANON.

### Rappel des consignes
Les points attendus du projet sont :

- [x]  Architecture qui respecte le principe de responsabilité unique
- [x]  Création des interfaces sans utiliser de storyboard ni SwiftUI
- [x]  Développement en Swift
- [x]  Code versionné sur Github
- [x]  Aucune librairie externe utilisée
- [x]  Projet compatible avec iOS 14+

Points supplémentaires :

- [x]  Tests unitaires
- [x]  Efforts UX/UI
- [x]  Performances de l'application
- [x]  Code swifty

L'application consiste en une liste d'items provenant d'une API.
Chaque item affiché comporte :
- image
- titre
- prix
- date
- catégorie
- indicateur dans le cas où l'item est urgent

Au toucher sur un item, une vue comportant tous ces éléments ainsi qu'une description de l'item est affichée.\
Une attention particulière est portée pour que cette vue affiche la totalité du titre dans le cas ou celui ci est long.

Les items sont triés par date ; ceux qui sont marqués "urgent" sont placés en haut de liste.

Un filtre est également disponible pour permettre à l'utilisateur de filter les items par catégorie.

### Poins d'amélioration relevés

#### Orientations paysage sur iPhone.
Même si la grande majorité des applications disponibles ne supportent pas ces orientations, il pourrait être intéressant de les gérer.

#### Documentation du code
La plupart du code est lisible facilement, mais un peu de documentation pourrait aider des futurs développeurs travaillant sur le projet.

#### Meilleure gestion des caches
Dans le cadre de ce projet, les caches sont uniquement stockés en mémoire et n'ont aucune gestion de taille ni de durée. Si le projet devenait plus important, une meilleure gestion de ces derniers serait fortement recommandée.

#### Écoute des évènements réseau
Il peut y avoir des situations dans lesquelles un utilisateur n'a pas une bonne connexion. Pour une meilleure expérience utilisateur, l'appli pourrait écouter les évènements (connexion/déconnexion) pour charger les éléments au moment où une connexion s'établit, au lieu d'attendre une action de l'utilisateur.

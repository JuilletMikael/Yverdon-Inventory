# Yverdon-Inventory

Cours **Infrastructure de Données** de la filière Ingénierie des Médias, HEIG-VD.

Ce projet est basé sur ce répo : [https://github.com/MediaComem/comem-infradon](https://github.com/MediaComem/comem-infradon)

## Contexte

La personne en charge du Service technique de la Commune d'Yverdon-les-Bains gère depuis 2018 le mobilier urbain (bancs, lampadaires, fontaines, poubelles, bornes de recharge) dans des fichiers Excel. Elle note les signalements de la population, enregistre les interventions de maintenance et tient une liste de fournisseurs.

Vous recevez les **4 fichiers Excel** tels quels. Votre mission : en faire une **infrastructure de données** fonctionnelle, optimisée et utile.

> **Note** : toutes les données du projet sont **fictives**. Les noms, numéros de téléphone, coordonnées et autres informations personnelles ont été générés pour les besoins du cours et ne correspondent à aucune personne réelle.

Pour plus d'information allez voir le dossier "wiki" de ce projet.

## Débuter

### Près-requis

Dépendance et versions nécésaire pour ce projet : 

* Visual Studio code [V1.1 ou plus tard](https://code.visualstudio.com/)
* Virtualisation Docker [V29 ou plus tard](https://www.docker.com/)

### Configuration

Création du container postgress : 
```shell
docker compose
```

Default values : 
- POSTGRES_USER: infradon
- POSTGRES_PASSWORD: infradon
- POSTGRES_DB: infradon

## Structure du répertoire

* Astuce : essayez la commande bash tree

```shell

// A remplir

```

## Collaborer
### Flux de travail Git

Nous utilisons le flux de travail Gitflow pour gérer nos branches :

- `main` : code prêt pour la production
- `develop` : branche de développement principale
- `feature/*` : nouvelles fonctionnalités
- `release/*` : préparation de la publication
- `hotfix/*` : corrections d'urgence pour la production
- `bugfix/*` : corrections de bogues pour le développement

Convention de nommage des branches :

- Features : `feature/nom-descriptif`
- Bugfixes : `bugfix/description-du-problème`
- Hotfixes : `hotfix/problème-critique`
- Releases : `release/numéro-de-version`

### Processus de développement

1. Créez une nouvelle branche à partir de 'develop' pour votre travail.
2. Apportez vos modifications sous forme de commits petits et ciblés.
3. Poussez votre branche et créez une Pull Request.
4. Demandez une révision.
5. Après approbation, fusionnez à l'aide d'un Merge.

### Commits conventionnels

Nous suivons strictement la spécification des commits conventionnels. Chaque message de commit doit être structuré comme suit :

```
<type>: <description>

[optional body]

[optional footer(s)]
```

Types :

- `feat` : nouvelle fonctionnalité
- `fix` : correction de bug
- `docs` : modifications de la documentation
- `style` : modifications du style du code (formatage, etc.)
- `refactor` : refactorisation du code
- `test` : ajout ou modification de tests
- `chore` : tâches de maintenance

Examples:

```
feat: add login functionality
fix: correct timeout handling
docs: update API documentation
```

Pour plus d'informations sur les commits conventionnels, rendez-vous sur [conventionalcommits.org](https://www.conventionalcommits.org/).

## Contact

Si vous avez des questions, vous pouvez nous contacter en créant une Issue.

## Licence

Ce matériel est mis à disposition sous licence [Creative Commons Attribution 4.0 International (CC BY 4.0)](https://creativecommons.org/licenses/by/4.0/).
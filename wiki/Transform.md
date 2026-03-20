# Intro 
Nous allons essayer d'expliquer ici comment gérer la transformation des données.

Nous commencerons par les tables intermédiaires, puis nous passerons à la base de données finale.

# Faciles ROUGE

Est-ce que l'on modifie toutes les valleurs dans staging ou ça reste clean ?

## Staging Signalement

| Staging column | Destination table and column | description |
|-------- |--------| --------|
| Urgence     | table urgence   | Valleur par défault ?     |
| Status     | table etats_tickets   | Valleur par défaut ?    |

## Staging inventaire

| Staging column | Destination table and column | description |
|-------- |--------| --------|
| type     | table types_inventaires   |   |
| materiaux     | table materiaux   |   |
| etat     | table etats_inventaires   | Valleur par défaut ?    |

## Staging intervention

| Staging column | Destination table and column | description |
|-------- |--------| --------|
| type_intervention     | table type_intervention   | A uniformiser  |

## Staging Fournisseurs

| Staging column | Destination table and column | description |
|-------- |--------| --------|
| type_materiel     | table type_materiel   | A uniformiser |


# Moyen VERT

## Staging Signalement

| Staging column | Destination table and column | description |
|-------- |--------| --------|
| remarques     | table types_signalements   | A définir à la main |

Pour les remarques, il faut annaliser les valleurs et définir quelque part quels valeurs sont choissient et pourquoi. 
ex. objet cassé pour Vitrine cassée ou défectueux pour Éclaire mal

## Staging Etat-facture

| Staging column | Destination table and column | description |
|-------- |--------| --------|
| -     | table etats_signalements  | A définir à la main |

Il n'existe pas de données existantes pour ces valleures, losr ce que nous inséreront ces valleurs nous définieront la valleur de non définie.

Valleurs : non définie, payé, non-payée (valleur par défault)






# staging.FournisseurContact

| Staging column | Destination table and column | description |
|-------- |--------| --------|
| entreprise     | Center   | Right    |

class FournisseurContact {
    entreprise : TEXT
    contact : TEXT
    telephone : TEXT
    email : TEXT
    type_materiel : TEXT
    remarques : TEXT
  }
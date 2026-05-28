# Limitations

Dans le projet actuel, nous avons diverses limitations qui rendent le projet pas complètement implémentable.

## Interventions

Lors de l’implémentation des interventions, une problématique est survenue au niveau du lien entre un objet de l’inventaire et l’objet spécifié dans la table des interventions.

Dans la table `staging.interventions`, un objet est défini par son type et son lieu, par exemple : *"Banc Chemin de Maillefer"*.

Dans la table d’inventaire, nous définissons le type d’objet et son lieu. Par exemple, dans les données de base :

| id    | type | materiau | lieu              |
| ----- | ---- | -------- | ----------------- |
| B-001 | banc | bois     | Avenue de la Gare |
| B-019 | Banc | metal    | Avenue de la Gare |

Comme on peut le voir ici, il n’est pas possible de différencier précisément, depuis les interventions, sur quel objet une intervention a été réalisée.

Ainsi, lors de l’insertion, nous avons choisi de prendre le premier élément de la liste par défaut. Ce n’est pas idéal et cela reste temporaire.

De plus, le lien est complexe car nous devons à chaque fois normaliser les valeurs avant de les comparer, en fonction du type et du lieu.

```sql
INNER JOIN staging.inventaire_mobilier inv_stage
    ON (
        CASE
            WHEN LOWER(s.objet) LIKE '%banc%' THEN 'banc'
            WHEN LOWER(s.objet) LIKE '%lampadaire%' THEN 'lampadaire'
            WHEN LOWER(s.objet) LIKE '%poubelle%' THEN 'poubelle'
            WHEN LOWER(s.objet) LIKE '%corbeille%' THEN 'corbeille'
            WHEN LOWER(s.objet) LIKE '%fontaine%' THEN 'fontaine'
            WHEN LOWER(s.objet) LIKE '%borne%' THEN 'borne'
            WHEN LOWER(s.objet) LIKE '%panneau%' THEN 'panneau'
            WHEN LOWER(s.objet) LIKE '%eclairage%' THEN 'eclairage'
        END
    )
    =
    (
        CASE
            WHEN LOWER(inv_stage.type) LIKE '%banc%' THEN 'banc'
            WHEN LOWER(inv_stage.type) LIKE '%lampadaire%' THEN 'lampadaire'
            WHEN LOWER(inv_stage.type) LIKE '%poubelle%' THEN 'poubelle'
            WHEN LOWER(inv_stage.type) LIKE '%corbeille%' THEN 'corbeille'
            WHEN LOWER(inv_stage.type) LIKE '%fontaine%' THEN 'fontaine'
            WHEN LOWER(inv_stage.type) LIKE '%borne%' THEN 'borne'
            WHEN LOWER(inv_stage.type) LIKE '%panneau%' THEN 'panneau'
            WHEN LOWER(inv_stage.type) LIKE '%eclairage%' THEN 'eclairage'
        END
    )
    AND LOWER(public.unaccent(s.objet))
    LIKE '%' || LOWER(public.unaccent(inv_stage.lieu)) || '%'
    AND inv_stage.id = (
        SELECT inv_stage2.id
        FROM staging.inventaire_mobilier inv_stage2
        WHERE (
            CASE
                WHEN LOWER(s.objet) LIKE '%banc%' THEN 'banc'
                WHEN LOWER(s.objet) LIKE '%lampadaire%' THEN 'lampadaire'
                WHEN LOWER(s.objet) LIKE '%poubelle%' THEN 'poubelle'
                WHEN LOWER(s.objet) LIKE '%corbeille%' THEN 'corbeille'
                WHEN LOWER(s.objet) LIKE '%fontaine%' THEN 'fontaine'
                WHEN LOWER(s.objet) LIKE '%borne%' THEN 'borne'
                WHEN LOWER(s.objet) LIKE '%panneau%' THEN 'panneau'
                WHEN LOWER(s.objet) LIKE '%eclairage%' THEN 'eclairage'
            END
        )
        =
        (
            CASE
                WHEN LOWER(inv_stage2.type) LIKE '%banc%' THEN 'banc'
                WHEN LOWER(inv_stage2.type) LIKE '%lampadaire%' THEN 'lampadaire'
                WHEN LOWER(inv_stage2.type) LIKE '%poubelle%' THEN 'poubelle'
                WHEN LOWER(inv_stage2.type) LIKE '%corbeille%' THEN 'corbeille'
                WHEN LOWER(inv_stage2.type) LIKE '%fontaine%' THEN 'fontaine'
                WHEN LOWER(inv_stage2.type) LIKE '%borne%' THEN 'borne'
                WHEN LOWER(inv_stage2.type) LIKE '%panneau%' THEN 'panneau'
                WHEN LOWER(inv_stage2.type) LIKE '%eclairage%' THEN 'eclairage'
            END
        )
        AND LOWER(public.unaccent(s.objet))
        LIKE '%' || LOWER(public.unaccent(inv_stage2.lieu)) || '%'
        ORDER BY inv_stage2.id
        LIMIT 1
    )
```

Finalement, cette partie du code filtre correctement les données mais elle provoque une perte de 13 valeurs.

Malheureusement, l’origine de cette perte n’a pas été identifiée. Nous en déduisons que si nous arrivons à faire des correspondances plus fidèles avec les identifiants des objets directement, cela pourrait régler le problème.

---

## Signalement

Pour les signalements, la problématique est exactement la même que précédemment pour les inventaires, ce qui entraîne les mêmes difficultés.

---

# Améliorations futures

## Ticket

La définition d’un ticket est floue, ce qui provoque quelques problèmes dans l’implémentation. En effet, un ticket regroupe plusieurs signalements et plusieurs interventions, mais nous ne savons pas clairement quand un ticket est ouvert ou fermé.

Il agit ici davantage comme une table intermédiaire. On pourrait lui ajouter des dates de début et de fin, ce qui permettrait de rendre les valeurs plus uniques, de mieux filtrer les tickets, et d’identifier les interventions par ticket plutôt que par état.

---

## Lien entre fournisseurs et inventaire

Le lien se fait via une facture, or nous n’avons pas implémenté ce lien étant donné qu’un inventaire ne peut pas avoir de facture.

Nous disposons cependant d’un document qui permettrait de faire le lien entre fournisseur et inventaire. C’est une fonctionnalité à implémenter.


> Note : texte corrigé par ChatGPT le 28 mai 2026 prompt "Corrige l'orthographe de ce texte : [texte]"
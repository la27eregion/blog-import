# Import WordPress

## L'environnement

1. Dupliquez le fichier .env.example et renommez le .env
2. Dans ce fichier .env, intégrez les données :
- l'adresse de l'instance
- le jeton secret
- l'identifiant du site dans lequel vous voulez importer

## Les scripts

### Installer les dépendances Ruby

```bash
bundle install
```

### Importer depuis WordPress

```bash
bundle exec ruby bin/import.rb 
```

### Convertir pour Osuny

```bash
bundle exec ruby bin/convert.rb
```

Pour convertir un seul fichier

```bash
bundle exec ruby bin/convert.rb 99
```

### Exporter vers Osuny

```bash
bundle exec ruby bin/export.rb
```

Pour exporter un seul fichier

```bash
bundle exec ruby bin/export.rb 99
```

Problèmes 
- 10331 : ok, image supprimée et envoyée à la main
- 112 : ok, slug corrigé à la main
- 14201 : ok, slug corrigé à la main
- 4794 : ok, slug corrigé à la main
- 6211 : ok, image réduite et envoyée à la main

A analyser
- 14050 : Comment (mieux) travailler avec la recherche quand on est une collectivité ?
- 2384 : Dominic Campbell : FUTUREGOV et le marché de l'innovation au Royaume Uni
- 4107 : « Le théâtre des négociations » où comment ré(ver)inventer la COP 21 (2/5)
- 4312 : Retour sur la 2e Semaine de l'Innovation Publique - Épisode 2
- 4846 : Déploiement, changement d’échelle, essaimage… Un nouveau champ expérimental dans l’innovation publique ?
- 4883 : Audrey Tang, qui es-tu ? (1/2)
- 5049 : La 27e Région sur la voie des Communs
- 5517 : La gare TER de demain, une nouvelle résidence de La 27e Région.
- 6861 : Coopératives d’habitat : un modèle en commun pour repenser le logement social ?
- 7642 : Innovation publique et doctorants en Cifre, même combat !
- 7693 : Et l'AG de la 27e Région, c'était comment?
- 8315 : Enacting the commons, c'est parti !
- 8780 : Rapport d'activité de la 27e Région en 2019
- 8821 : Pour préparer demain, observer les transformations publiques par temps de crise
- 8877 : Réflexes publics - premier panorama des controverses et des terrains d'enquête
- 9214 : Six pistes prospectives pour bâtir les capacités publiques post-covid
- 9463 : Les communs négatifs : prendre le problème à l’envers ?
- 9495 : Rapport d'activité 2020 : notre année autour de 10 moments forts
- 9560 : Du Nord au Sud en passant par les Alpes : cap sur 9 lieux créateurs de communs
- 9767 : Histoires d’eau: 3 nuances de gestion en commun

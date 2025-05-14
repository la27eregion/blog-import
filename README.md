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
- 14050 : ?
- 2384 : ?
- 4107 : ?
- 4312 : ?
- 4846 : ?
- 4883 : ?
- 5049 : ?
- 5517 : ?
- 6861 : ?
- 7642 : ?
- 7693 : ?
- 8315 : ?
- 8780 : ?
- 8821 : ?
- 8877 : ?
- 9214 : ?
- 9463 : ?
- 9495 : ?
- 9560 : ?
- 9767 : ?

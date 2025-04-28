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

### Exporter vers Osuny

```bash
bundle exec ruby bin/export.rb
```

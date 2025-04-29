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


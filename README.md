# recette_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

# Recette App

Application mobile de gestion et de découverte de recettes.

## Présentation

Recette App permet de consulter des recettes, de rechercher une recette, de filtrer les recettes par catégorie et d'ajouter de nouvelles recettes.

L'application propose également un mode clair et un mode sombre ainsi qu'une interface responsive adaptée aux différentes tailles d'écran.

## Fonctionnalités

- Page d'accueil
- Liste de toutes les recettes
- Recherche de recettes
- Filtrage par catégorie
- Consultation du détail d'une recette
- Ajout d'une nouvelle recette
- Validation du formulaire
- Mode clair et mode sombre
- Interface responsive mobile/tablette
- Navigation avec GoRouter

## Écrans

L'application contient les écrans suivants :

1. **Accueil**
2. **Toutes les recettes**
3. **Détail d'une recette**
4. **Ajouter une recette**
5. **Paramètres**

## Modèle de données

Chaque recette contient les informations suivantes :

- id

- name

- description

- category

Les données sont séparées de l'interface utilisateur dans le dossier data/.

## Responsive Design

L'application utilise une interface adaptée aux différentes tailles d'écran.

Sur mobile, les recettes sont affichées sous forme de liste.

Sur tablette et écran plus large, les recettes sont organisées sous forme de grille.

## Recherche et filtrage

- La liste des recettes permet :

- de rechercher une recette par son nom ;

- de filtrer les recettes selon leur catégorie ;

- de combiner la recherche et le filtre.

## Ajout d'une recette

Le formulaire permet d'ajouter une nouvelle recette avec :

- un nom ;

- une description ;

- une catégorie.

## Installation

### Prérequis

Installer :

- Flutter
- Dart
- Chrome ou un appareil compatible Flutter

### Instructions de lancement

Lancer l'application :

```Dans l-invite de commande taper :
flutter run
```

Pour lancer directement sur Chrome :

```bash
flutter run -d chrome
```



## Captures d'écran

### Accueil
[Accueil](capture_ecran/Home.png)

### Liste des recettes
[Recettes](capture_ecran/Liste.png)

### Détail
[Détail](capture_ecran/Détail.png)

### Ajouter une recette
[Ajouter](capture_ecran/FormulaireAjout.png)

### Paramètres
[Paramètres](capture_ecran/Parametres.png)
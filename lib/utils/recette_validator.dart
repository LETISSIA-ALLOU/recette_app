import '../models/recette.dart';

/// Vérifie que les informations obligatoires d'une recette sont valides.
String? validateRecipe({
  required String name,
  required String description,
  required String category,
}) {
  if (name.trim().isEmpty) {
    return 'Le nom de la recette est obligatoire.';
  }

  if (description.trim().isEmpty) {
    return 'La description est obligatoire.';
  }

  if (category.trim().isEmpty) {
    return 'La catégorie est obligatoire.';
  }

  return null;
}

/// Génère le prochain ID disponible.
int generateRecipeId(List<Recette> recipes) {
  if (recipes.isEmpty) {
    return 1;
  }

  final maxId = recipes
      .map((recipe) => recipe.id)
      .reduce((a, b) => a > b ? a : b);

  return maxId + 1;
}
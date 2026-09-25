import 'package:flutter_test/flutter_test.dart';
import 'package:recette_app/data/recette_data.dart';
import 'package:recette_app/models/recette.dart';
import 'package:recette_app/utils/recette_validator.dart';

void main() {
  group('Tests unitaires - validation des recettes', () {
    test('une recette valide ne retourne aucune erreur', () {
      final result = validateRecipe(
        name: 'Pizza',
        description: 'Pizza maison',
        category: 'Italienne',
      );

      expect(result, isNull);
    });

    test('le nom est obligatoire', () {
      final result = validateRecipe(
        name: '',
        description: 'Pizza maison',
        category: 'Italienne',
      );

      expect(result, isNotNull);
    });

    test('la description est obligatoire', () {
      final result = validateRecipe(
        name: 'Pizza',
        description: '',
        category: 'Italienne',
      );

      expect(result, isNotNull);
    });

    test('la catégorie est obligatoire', () {
      final result = validateRecipe(
        name: 'Pizza',
        description: 'Pizza maison',
        category: '',
      );

      expect(result, isNotNull);
    });

    test('les espaces seuls sont considérés comme une valeur vide', () {
      final result = validateRecipe(
        name: '   ',
        description: 'Pizza maison',
        category: 'Italienne',
      );

      expect(result, isNotNull);
    });
  });

  group('Tests unitaires - génération des IDs', () {
    test('génère l ID 1 lorsque la liste est vide', () {
      final result = generateRecipeId([]);

      expect(result, 1);
    });

    test('génère le prochain ID disponible', () {
      final testRecipes = [
        Recette(
          id: 1,
          name: 'Pizza',
          description: 'Pizza maison',
          category: 'Italienne',
        ),
        Recette(
          id: 2,
          name: 'Salade',
          description: 'Salade composée',
          category: 'Végétarienne',
        ),
        Recette(
          id: 5,
          name: 'Gâteau',
          description: 'Gâteau au chocolat',
          category: 'Dessert',
        ),
      ];

      final result = generateRecipeId(testRecipes);

      expect(result, 6);
    });

    test('le nouvel ID est supérieur au plus grand ID existant', () {
      final result = generateRecipeId(recettes);

      final maxId = recettes
          .map((recipe) => recipe.id)
          .reduce((a, b) => a > b ? a : b);

      expect(result, greaterThan(maxId));
    });
  });

  group('Tests unitaires - données des recettes', () {
    test('les recettes existantes ont des IDs uniques', () {
      final ids = recettes.map((recipe) => recipe.id).toList();

      expect(ids.toSet().length, ids.length);
    });

    test('chaque recette possède les informations obligatoires', () {
      for (final recipe in recettes) {
        expect(recipe.name.trim(), isNotEmpty);
        expect(recipe.description.trim(), isNotEmpty);
        expect(recipe.category.trim(), isNotEmpty);
      }
    });
  });
}
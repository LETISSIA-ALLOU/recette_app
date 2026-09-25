import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:recette_app/main.dart';

void main() {
  group('Tests de recherche et filtrage des recettes', () {
    Future<void> openRecipesScreen(WidgetTester tester) async {
      await tester.pumpWidget(const RecipeApp());
      await tester.pumpAndSettle();

      await tester.tap(find.text('Voir tout'));
      await tester.pumpAndSettle();
    }

    testWidgets(
      'permet de rechercher une recette par son nom',
      (WidgetTester tester) async {
        await openRecipesScreen(tester);

        final searchField = find.byType(TextField);

        await tester.enterText(searchField, 'Pizza');
        await tester.pumpAndSettle();

        expect(find.text('Pizza'), findsWidgets);
        expect(find.text('Poulet braisé'), findsNothing);
        expect(find.text('Spaghetti bolognaise'), findsNothing);
      },
    );

    testWidgets(
      'permet de filtrer les recettes par catégorie',
      (WidgetTester tester) async {
        await openRecipesScreen(tester);

        await tester.tap(find.text('Italienne').first,);
        await tester.pumpAndSettle();

        expect(find.text('Pizza'), findsWidgets);
        expect(find.text('Spaghetti bolognaise'), findsWidgets);
        expect(find.text('Poulet braisé'), findsNothing);
        expect(find.text('Gâteau au chocolat'), findsNothing);
      },
    );

    testWidgets(
      'permet de combiner recherche et filtre par catégorie',
      (WidgetTester tester) async {
        await openRecipesScreen(tester);

        // Sélection de la catégorie Italienne.
        await tester.tap(find.text('Italienne').first,);
        await tester.pumpAndSettle();

        // Recherche de Pizza.
        final searchField = find.byType(TextField);

        await tester.enterText(searchField, 'Pizza');
        await tester.pumpAndSettle();

        expect(find.text('Pizza'), findsWidgets);
        expect(find.text('Spaghetti bolognaise'), findsNothing);
        expect(find.text('Poulet braisé'), findsNothing);
      },
    );

    testWidgets(
      'affiche un message lorsqu aucune recette ne correspond',
      (WidgetTester tester) async {
        await openRecipesScreen(tester);

        final searchField = find.byType(TextField);

        await tester.enterText(
          searchField,
          'Recette qui nexiste pas',
        );
        await tester.pumpAndSettle();

        expect(
          find.text('Aucune recette trouvée.'),
          findsOneWidget,
        );
      },
    );
  });
}
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:recette_app/main.dart';

void main() {
  group('Recipe App - Tests des widgets', () {
    testWidgets(
      'affiche la page d accueil et les recettes populaires',
      (WidgetTester tester) async {
        await tester.pumpWidget(const RecipeApp());
        await tester.pumpAndSettle();

        expect(find.text('Bienvenue'), findsOneWidget);
        expect(find.text('Recettes populaires'), findsOneWidget);
        expect(find.text('Poulet braisé'), findsOneWidget);
      },
    );

    testWidgets(
      'navigue vers la liste des recettes',
      (WidgetTester tester) async {
        await tester.pumpWidget(const RecipeApp());
        await tester.pumpAndSettle();

        await tester.tap(find.text('Voir tout'));
        await tester.pumpAndSettle();

        expect(find.text('Toutes les recettes'), findsOneWidget);
        expect(find.text('Pizza'), findsOneWidget);
        expect(find.text('Spaghetti bolognaise'), findsOneWidget);
      },
    );

    testWidgets(
      'affiche les erreurs de validation du formulaire',
      (WidgetTester tester) async {
        await tester.pumpWidget(const RecipeApp());
        await tester.pumpAndSettle();

        await tester.tap(find.text('Ajouter'));
        await tester.pumpAndSettle();

        expect(find.text('Ajouter une recette'), findsOneWidget);

        await tester.tap(find.text('Ajouter la recette'));
        await tester.pumpAndSettle();

        expect(find.text('Veuillez saisir le nom de la recette.'), findsOneWidget);
        expect(
          find.text('Veuillez saisir une description.'),
          findsOneWidget,
        );
        expect(find.text('Veuillez saisir une catégorie.'), findsOneWidget);
      },
    );

    testWidgets(
      'ouvre le détail d une recette',
      (WidgetTester tester) async {
        await tester.pumpWidget(const RecipeApp());
        await tester.pumpAndSettle();

        await tester.tap(find.text('Poulet braisé'));
        await tester.pumpAndSettle();

        expect(find.text('Détail de la recette'), findsOneWidget);
        expect(find.text('Poulet braisé'), findsOneWidget);
        expect(
          find.text(
            'Un délicieux poulet braisé accompagné de légumes.',
          ),
          findsOneWidget,
        );
      },
    );

    testWidgets(
  'permet de rechercher une recette',
  (WidgetTester tester) async {
    await tester.pumpWidget(const RecipeApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Voir tout'));
    await tester.pumpAndSettle();

    final searchField = find.byType(TextField);

    await tester.enterText(searchField, 'Pizza');
    await tester.pumpAndSettle();

    expect(find.text('Pizza'), findsWidgets);
    expect(find.text('Poulet braisé'), findsNothing);
    expect(find.text('Spaghetti bolognaise'), findsNothing);
  },
);
  });
}
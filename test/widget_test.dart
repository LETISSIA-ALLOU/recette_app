import 'package:flutter_test/flutter_test.dart';

import 'package:recette_app/main.dart';

void main() {
  testWidgets('Recipe App se lance correctement', (WidgetTester tester) async {
    await tester.pumpWidget(const RecipeApp());

    expect(find.text('Bienvenue'), findsOneWidget);
  });
}
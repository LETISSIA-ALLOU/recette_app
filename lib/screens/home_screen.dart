import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../data/recette_data.dart';
import '../widgets/recipe_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final popularRecipes = recettes.take(3).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Recette App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => context.go('/settings'),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isTablet = constraints.maxWidth >= 600;

          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1000),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Bienvenue',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Découvrez de délicieuses recettes.',
                    ),
                    const SizedBox(height: 24),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Recettes populaires',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge,
                        ),
                        TextButton(
                          onPressed: () => context.go('/recipes'),
                          child: const Text('Voir tout'),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    Expanded(
                      child: isTablet
                          ? GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 16,
                                mainAxisSpacing: 8,
                                childAspectRatio: 3.2,
                              ),
                              itemCount: popularRecipes.length,
                              itemBuilder: (context, index) {
                                final recipe = popularRecipes[index];

                                return RecipeCard(
                                  recipe: recipe,
                                  onTap: () => context.go(
                                    '/recipes/${recipe.id}',
                                  ),
                                );
                              },
                            )
                          : ListView.builder(
                              itemCount: popularRecipes.length,
                              itemBuilder: (context, index) {
                                final recipe = popularRecipes[index];

                                return RecipeCard(
                                  recipe: recipe,
                                  onTap: () => context.go(
                                    '/recipes/${recipe.id}',
                                  ),
                                );
                              },
                            ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.go('/add'),
        icon: const Icon(Icons.add),
        label: const Text('Ajouter'),
      ),
    );
  }
}
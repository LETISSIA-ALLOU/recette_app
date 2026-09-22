import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../data/recette_data.dart';

class RecipeDetailScreen extends StatelessWidget {
  final int recipeId;

  const RecipeDetailScreen({
    super.key,
    required this.recipeId,
  });

  @override
  Widget build(BuildContext context) {
    final recipe = recettes.firstWhere(
      (recipe) => recipe.id == recipeId,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Détail de la recette'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 700),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      child: Text(
                        recipe.name[0].toUpperCase(),
                        style: const TextStyle(fontSize: 30),
                      ),
                    ),

                    const SizedBox(height: 24),

                    Text(
                      recipe.name,
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium,
                    ),

                    const SizedBox(height: 12),

                    Chip(
                      label: Text(recipe.category),
                    ),

                    const SizedBox(height: 24),

                    Text(
                      'Description',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge,
                    ),

                    const SizedBox(height: 8),

                    Text(recipe.description),

                    const SizedBox(height: 32),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () => context.go('/recipes'),
                        icon: const Icon(Icons.arrow_back),
                        label: const Text('Retour aux recettes'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
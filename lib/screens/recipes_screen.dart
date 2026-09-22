import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../data/recette_data.dart';
import '../models/recette.dart';
import '../widgets/category_chip.dart';
import '../widgets/recipe_card.dart';
import '../widgets/search_bar_widget.dart';

class RecipesScreen extends StatefulWidget {
  const RecipesScreen({super.key});

  @override
  State<RecipesScreen> createState() => _RecipesScreenState();
}

class _RecipesScreenState extends State<RecipesScreen> {
  String searchQuery = '';
  String selectedCategory = 'Toutes';

  @override
  Widget build(BuildContext context) {
    final categories = [
      'Toutes',
      ...recettes.map((recipe) => recipe.category).toSet(),
    ];

    final filteredRecipes = recettes.where((Recette recipe) {
      final matchesSearch = recipe.name
          .toLowerCase()
          .contains(searchQuery.toLowerCase());

      final matchesCategory = selectedCategory == 'Toutes' ||
          recipe.category == selectedCategory;

      return matchesSearch && matchesCategory;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Toutes les recettes'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isTablet = constraints.maxWidth >= 600;

          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1000),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    SearchBarWidget(
                      onChanged: (value) {
                        setState(() {
                          searchQuery = value;
                        });
                      },
                    ),

                    const SizedBox(height: 16),

                    // Filtres par catégorie
                    SizedBox(
                      height: 45,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: categories.length,
                        separatorBuilder: (_, _) =>
                            const SizedBox(width: 8),
                        itemBuilder: (context, index) {
                          final category = categories[index];

                          return CategoryChip(
                            category: category,
                            selected: selectedCategory == category,
                            onSelected: () {
                              setState(() {
                                selectedCategory = category;
                              });
                            },
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Liste des recettes
                    Expanded(
                      child: filteredRecipes.isEmpty
                          ? const Center(
                              child: Text(
                                'Aucune recette trouvée.',
                                style: TextStyle(fontSize: 16),
                              ),
                            )
                          : isTablet
                              ? GridView.builder(
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 16,
                                    mainAxisSpacing: 8,
                                    childAspectRatio: 3.2,
                                  ),
                                  itemCount: filteredRecipes.length,
                                  itemBuilder: (context, index) {
                                    final recipe = filteredRecipes[index];

                                    return RecipeCard(
                                      recipe: recipe,
                                      onTap: () => context.go(
                                        '/recipes/${recipe.id}',
                                      ),
                                    );
                                  },
                                )
                              : ListView.builder(
                                  itemCount: filteredRecipes.length,
                                  itemBuilder: (context, index) {
                                    final recipe = filteredRecipes[index];

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
    );
  }
}
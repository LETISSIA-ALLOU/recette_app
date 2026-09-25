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

  /// Retourne la liste des catégories disponibles.
  List<String> get categories {
    return [
      'Toutes',
      ...recettes.map((recipe) => recipe.category).toSet(),
    ];
  }

  /// Filtre les recettes selon le texte recherché
  /// et la catégorie sélectionnée.
  List<Recette> get filteredRecipes {
    final query = searchQuery.trim().toLowerCase();

    return recettes.where((recipe) {
      final matchesSearch =
          query.isEmpty || recipe.name.toLowerCase().contains(query);

      final matchesCategory =
          selectedCategory == 'Toutes' ||
          recipe.category == selectedCategory;

      return matchesSearch && matchesCategory;
    }).toList();
  }

  void _searchRecipes(String value) {
    setState(() {
      searchQuery = value;
    });
  }

  void _filterByCategory(String category) {
    setState(() {
      selectedCategory = category;
    });
  }

  @override
  Widget build(BuildContext context) {
    final recipes = filteredRecipes;

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
                    // Recherche
                    SearchBarWidget(
                      onChanged: _searchRecipes,
                    ),

                    const SizedBox(height: 16),

                    // Filtrage par catégorie
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
                              _filterByCategory(category);
                            },
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Résultat de la recherche et du filtrage
                    Expanded(
                      child: recipes.isEmpty
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
                                  itemCount: recipes.length,
                                  itemBuilder: (context, index) {
                                    final recipe = recipes[index];

                                    return RecipeCard(
                                      recipe: recipe,
                                      onTap: () {
                                        context.go(
                                          '/recipes/${recipe.id}',
                                        );
                                      },
                                    );
                                  },
                                )
                              : ListView.builder(
                                  itemCount: recipes.length,
                                  itemBuilder: (context, index) {
                                    final recipe = recipes[index];

                                    return RecipeCard(
                                      recipe: recipe,
                                      onTap: () {
                                        context.go(
                                          '/recipes/${recipe.id}',
                                        );
                                      },
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
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopdde/controllers/category_controller.dart';
import 'package:shopdde/controllers/subcategory_controller.dart';
import 'package:shopdde/models/category.dart';
import 'package:shopdde/models/subcategory.dart';
import 'package:shopdde/views/screens/detail/screens/widgets/subcategory_tile_widget.dart';
import 'package:shopdde/views/screens/nav_screens/widgets/header_widget.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  late Future<List<Category>> futureCategories;
  Category? _selectedCategory;
  List<Subcategory> _subcategories = [];
  final SubcategoryController _subcategoryController = SubcategoryController();

  @override
  void initState() {
    super.initState();
    futureCategories = CategoryController().loadCategories();
    futureCategories.then((categories) {
      for (var category in categories) {
        if (category.name == "Fashion") {
          setState(() {
            _selectedCategory = category;
          });
          _loadSubcategories(category.name);
          break;
        }
      }
    });
  }

  Future<void> _loadSubcategories(String categoryName) async {
    try {
      final subcategories =
      await _subcategoryController.getSubCategoriesByCategoryName(categoryName);
      setState(() {
        _subcategories = subcategories;
      });
    } catch (error) {
      debugPrint('Error loading subcategories: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize: Size.fromHeight(MediaQuery.of(context).size.height *20),
          child: const HeaderWidget(),
      ),
        body: Row(

              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left Panel: Categories
                Expanded(
                  flex: 2,
                  child: Container(
                    color: Colors.grey.shade200,
                    child: FutureBuilder(
                      future: futureCategories,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text('Error: ${snapshot.error}'),
                          );
                        } else {
                          final categories = snapshot.data!;
                          return ListView.builder(
                            itemCount: categories.length,
                            itemBuilder: (context, index) {
                              final category = categories[index];
                              return ListTile(
                                onTap: () {
                                  setState(() {
                                    _selectedCategory = category;
                                  });
                                  _loadSubcategories(category.name);
                                },
                                title: Text(
                                  category.name,
                                  style: GoogleFonts.quicksand(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: _selectedCategory == category
                                        ? Colors.blue
                                        : Colors.black,
                                  ),
                                ),
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
                ),
                // Right Panel: Subcategories
                Expanded(
                  flex: 5,
                  child: _selectedCategory != null
                      ? SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            _selectedCategory!.name,
                            style: GoogleFonts.quicksand(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.7,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: AspectRatio(
                            aspectRatio: 16 / 9,
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                      _selectedCategory!.banner),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                        _subcategories.isNotEmpty
                            ? GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: _subcategories.length,
                            gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisSpacing: 8,
                              crossAxisSpacing: 8,
                              childAspectRatio: 2 / 3,
                            ),
                            itemBuilder: (context, index) {
                              final subcategory =
                              _subcategories[index];
                              return SubcategoryTileWidget(
                                image: subcategory.image,
                                title:
                                subcategory.subCategoryName,
                              );
                            },

                        )
                            : Center(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              'No subcategories',
                              style: GoogleFonts.quicksand(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.7,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                      : Container(),
                ),
              ],
            ),



    );
  }
}

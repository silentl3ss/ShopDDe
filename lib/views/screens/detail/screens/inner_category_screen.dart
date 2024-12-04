
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopdde/controllers/subcategory_controller.dart';
import 'package:shopdde/models/category.dart';
import 'package:shopdde/models/subcategory.dart';
import 'package:shopdde/views/screens/detail/screens/widgets/inner_banner_widget.dart';
import 'package:shopdde/views/screens/detail/screens/widgets/inner_header_widget.dart';
import 'package:shopdde/views/screens/detail/screens/widgets/subcategory_tile_widget.dart';

class InnerCategoryScreen extends StatefulWidget {
    final Category category;

  const InnerCategoryScreen({super.key, required this.category});

  @override
  State<InnerCategoryScreen> createState() => _InnerCategoryScreenState();
}

class _InnerCategoryScreenState extends State<InnerCategoryScreen> {

  late Future<List<Subcategory>> _subCategories;
  final SubcategoryController _subcategoryController = SubcategoryController();
  @override
  void initState(){
    super.initState();
    _subCategories = _subcategoryController.getSubCategoriesByCategoryName(widget.category.name);
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: PreferredSize(preferredSize: Size.fromHeight(MediaQuery.of(context).size.height*20),
         child: const InnerHeaderWidget(),
     ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            InnerBannerWidget(image: widget.category.banner),
            Center(child: Text('Shop By Subcategries',style: GoogleFonts.quicksand(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.7,
            ),),
            ),

            FutureBuilder(future: _subCategories, builder: (context, snapshot){
              if(snapshot.connectionState == ConnectionState.waiting){
                return const Center(child: CircularProgressIndicator(),

                );
              }else if(snapshot.hasError) {
                return Center(child: Text('Error ${snapshot.error}'),
                );
              } else if(!snapshot.hasData || snapshot.data!.isEmpty){
                return const Center(
                  child: Text('No Categories'),
                );
              }else {
                final subcategories = snapshot.data!;
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Column(
                    children: List.generate((subcategories.length/7).ceil(),
              (setIndex) {
                      //for each row , caculate the starting and ending indices
              final start = setIndex * 7;
              final end = (setIndex + 1) * 7;

              //Create a padding widget to add spacing arround the row
                return Padding(padding: EdgeInsets.all(8.9),
                child: Row(
                  //create a row of  the subcategory tie
                  children: subcategories.sublist(start,end>subcategories.
                  length?subcategories.length:end).map((subcategory)=>SubcategoryTileWidget(
                    image: subcategory.image,
                    title: subcategory.subCategoryName,))
                      .toList(),
                ),

                  );


              })),
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}

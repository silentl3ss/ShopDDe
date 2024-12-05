
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopdde/controllers/subcategory_controller.dart';
import 'package:shopdde/models/category.dart';
import 'package:shopdde/models/subcategory.dart';
import 'widgets/inner_banner_widget.dart';
import 'package:shopdde/views/screens/detail/screens/widgets/inner_category_content_widget.dart';
import 'package:shopdde/views/screens/detail/screens/widgets/inner_header_widget.dart';



import 'package:shopdde/views/screens/nav_screens/account_screen.dart';
import 'package:shopdde/views/screens/nav_screens/cart_screen.dart';
import 'package:shopdde/views/screens/nav_screens/category_screen.dart';
import 'package:shopdde/views/screens/nav_screens/favorite_screen.dart';
import 'package:shopdde/views/screens/nav_screens/stores_screen.dart';

class InnerCategoryScreen extends StatefulWidget {
    final Category category;

  const InnerCategoryScreen({super.key, required this.category});

  @override
  State<InnerCategoryScreen> createState() => _InnerCategoryScreenState();
}

class _InnerCategoryScreenState extends State<InnerCategoryScreen> {
  int pageIndex = 0;



  @override
  Widget build (BuildContext context) {


    final List<Widget> pages = [
      InnerCategoryContentWidget(category: widget.category,),
    const FavoriteScreen(),
    const CategoryScreen(),
    const StoresScreen(),
    const CartScreen(),
     AccountScreen(),
    ];



    return Scaffold(


      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.purple,
          unselectedItemColor: Colors.grey,
          currentIndex: pageIndex,
          onTap: (value) {
            setState(() {
              pageIndex = value;
            });
          },
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(icon: Image.asset("assets/icons/home.png", width: 25,),label: "Home"),
            BottomNavigationBarItem(icon: Image.asset("assets/icons/love.png",width: 25,),label: "Favorite"),
            const    BottomNavigationBarItem(icon: Icon(Icons.category), label: "Catories"),
            BottomNavigationBarItem(icon: Image.asset("assets/icons/mart.png",width: 25,),label: "Stores"),
            BottomNavigationBarItem(icon: Image.asset("assets/icons/cart.png",width: 25,),label: "Cart"),
            BottomNavigationBarItem(icon: Image.asset("assets/icons/user_main.png",width: 25,),label: "Account"),
          ]),

      body: pages[pageIndex],

    );
  }
}

import 'package:deli_meals/components/main_drawer.dart';
import 'package:deli_meals/models/meal.dart';
import 'package:deli_meals/pages/categories_page.dart';
import 'package:deli_meals/pages/favorite_page.dart';
import 'package:flutter/material.dart';

class TabsPage extends StatefulWidget {
  final List<Meal> favoriteMeals;
  const TabsPage({
    super.key,
    required this.favoriteMeals,
  });

  @override
  State<TabsPage> createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {
  int _selectedPageIndex = 0;
  List<Map<String, Object>> _pages = [];
  @override
  void initState() {
    super.initState();
    _pages = [
      {'screens': CategoriesPage(), 'title': 'DeliMeals'},
      {
        'screens': FavoritePage(
          favoriteMeals: widget.favoriteMeals,
        ),
        'title': 'Favoritos'
      }
    ];
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedPageIndex]['title'] as String),
      ),
      drawer: MainDrawer(),
      body: _pages[_selectedPageIndex]['screens'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex,
        onTap: _selectPage,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categorias',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favoritos',
          )
        ],
      ),
    );
  }
}

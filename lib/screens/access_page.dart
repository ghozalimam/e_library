import 'package:flutter/material.dart';
import 'catalog_screen.dart';
import 'search_screen.dart';
import 'favorites_screen.dart';
import 'profile_screen.dart';
import '../models/book.dart';

class AccessPage extends StatefulWidget {
  final String userName;
  final String userEmail;
  final String userPhotoUrl;
  final List<Book> favoriteBooks;

  AccessPage({
    required this.userName,
    required this.userEmail,
    required this.userPhotoUrl,
    required this.favoriteBooks,
  });

  @override
  _AccessPageState createState() => _AccessPageState();
}

class _AccessPageState extends State<AccessPage> {
  int _currentIndex = 0;
  late String _userName;
  late String _userEmail;
  late String _userPhotoUrl;

  @override
  void initState() {
    super.initState();
    _userName = widget.userName;
    _userEmail = widget.userEmail;
    _userPhotoUrl = widget.userPhotoUrl;
  }

  void _updateUserProfile(String name, String email, String photoUrl) {
    setState(() {
      _userName = name;
      _userEmail = email;
      _userPhotoUrl = photoUrl;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      CatalogScreen(),
      SearchScreen(),
      FavoritesScreen(),
      ProfileScreen(
        userName: _userName,
        userEmail: _userEmail,
        userPhotoUrl: _userPhotoUrl,
        onProfileUpdated: _updateUserProfile,
      ),
    ];

    return Scaffold(
      body: Stack(
        children: [
          _pages[_currentIndex],
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                  ),
                ],
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildNavItem(0, Icons.home_outlined, 'Home'),
                      _buildNavItem(1, Icons.search, 'Search'),
                      _buildNavItem(
                          2, Icons.favorite_border_outlined, 'Favorite'),
                      _buildNavItem(3, Icons.person_outline, 'Profile'),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final isSelected = _currentIndex == index;
    final Color selectedColor = Color(0xFF2DA89B); // Warna teal
    final Color unselectedColor = Colors.grey;

    return InkWell(
      onTap: () => setState(() => _currentIndex = index),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? selectedColor : unselectedColor,
              size: 24,
            ),
            SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? selectedColor : unselectedColor,
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

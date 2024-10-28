import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/book_data.dart';
import '../models/book.dart';
import '../providers/favorites_provider.dart';
import 'book_detail_screen.dart';
import 'favorites_screen.dart';

class CatalogScreen extends StatefulWidget {
  @override
  _CatalogScreenState createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  int selectedCategory = 0;
  final categories = ['All', 'Recent books', 'Popular', 'Nature'];
  late List<Book> books;

  @override
  void initState() {
    super.initState();
    books = BookData.getBooks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.menu_book,
                                color: Colors.teal,
                                size: 32,
                              ),
                              SizedBox(width: 10),
                              Text(
                                'E-Library',
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.teal,
                                ),
                              ),
                            ],
                          ),
                          IconButton(
                            icon: Icon(Icons.notifications_outlined),
                            color: Colors.teal,
                            onPressed: () {
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    children: List.generate(
                      categories.length,
                      (index) => GestureDetector(
                        onTap: () => setState(() => selectedCategory = index),
                        child: Container(
                          margin: EdgeInsets.only(
                            left: index == 0 ? 20 : 8,
                            right: index == categories.length - 1 ? 20 : 8,
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            color: selectedCategory == index
                                ? Colors.teal
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            categories[index],
                            style: TextStyle(
                              color: selectedCategory == index
                                  ? Colors.white
                                  : Colors.grey[600],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: AssetImage('assets/images/read.jpg'),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.6),
                        BlendMode.darken,
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Discover, Track, and Enjoy\nYour Favorite Books on\nNovelHub',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          height: 1.5,
                        ),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text('Explore',
                            style:
                                TextStyle(fontSize: 16, color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Popular Books',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(Icons.arrow_forward, color: Colors.grey[600]),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: List.generate(
                      books.length,
                      (index) => BookCard(
                        book: books[index],
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BookDetailScreen(
                                book: books[index],
                                onDelete: (_) {},
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'New Arrivals',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(Icons.arrow_forward, color: Colors.grey[600]),
                    ],
                  ),
                ),

                // New Arrivals List
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: List.generate(
                      books.length,
                      (index) => BookCard(
                        book: books[index],
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BookDetailScreen(
                                book: books[index],
                                onDelete: (_) {},
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
class BookCard extends StatelessWidget {
  final Book book;
  final Function() onTap;

  const BookCard({
    Key? key,
    required this.book,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(right: 16),
        width: 120,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 180,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: AssetImage(book.thumbnailUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  book.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  book.author,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Consumer<FavoritesProvider>(
                  builder: (context, favoritesProvider, child) {
                    final isFavorite = favoritesProvider.isBookmarked(book);
                    return IconButton(
                      icon: Icon(
                        isFavorite ? Icons.bookmark : Icons.bookmark_border,
                        color: isFavorite ? Colors.teal : Colors.grey,
                        size: 20,
                      ),
                      onPressed: () {
                        favoritesProvider.toggleFavorite(book);
                      },
                      constraints: BoxConstraints(),
                      padding: EdgeInsets.zero,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

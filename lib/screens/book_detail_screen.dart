import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/book.dart';
import '../providers/favorites_provider.dart';
import 'edit_book_screen.dart';

class BookDetailScreen extends StatelessWidget {
  final Book book;
  final Function(Book) onDelete;

  BookDetailScreen({required this.book, required this.onDelete});

  void _showReadingView(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.teal),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(
              book.title,
              style: TextStyle(
                color: Colors.teal,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(
                    context.watch<FavoritesProvider>().isBookmarked(book)
                        ? Icons.bookmark
                        : Icons.bookmark_border,
                    color: Colors.teal),
                onPressed: () {
                  final favoritesProvider = context.read<FavoritesProvider>();
                  favoritesProvider.toggleFavorite(book);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(favoritesProvider.isBookmarked(book)
                          ? 'Added to favorites'
                          : 'Removed from favorites'),
                      backgroundColor: favoritesProvider.isBookmarked(book)
                          ? Colors.green
                          : Colors.red,
                    ),
                  );
                },
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Text(
                  book.description,
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.8,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            backgroundColor: Colors.transparent,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    book.thumbnailUrl,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.edit, color: Colors.white),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditBookScreen(book: book),
                    ),
                  );
                },
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Transform.translate(
              offset: Offset(0, -30),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            book.title,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'by ${book.author}',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildStat('Year', book.year),
                            Container(
                              height: 40,
                              width: 1,
                              color: Colors.grey[300],
                            ),
                            _buildStat('Rating', '4.5'),
                            Container(
                              height: 40,
                              width: 1,
                              color: Colors.grey[300],
                            ),
                            _buildStat('Pages', '256'),
                          ],
                        ),
                      ),
                      SizedBox(height: 24),
                      Text(
                        'Preview',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 12),
                      Text(
                        book.description,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                          height: 1.5,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // Implement Read More functionality
                        },
                        child: Text(
                          'Read More',
                          style: TextStyle(
                            color: Colors.teal,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 24),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () => _showReadingView(context),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.teal,
                                padding: EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              icon: Icon(Icons.book_outlined,
                                  color: Colors.white),
                              label: Text(
                                'Read Book',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                          SizedBox(width: 16),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: IconButton(
                              icon: Icon(
                                context
                                        .watch<FavoritesProvider>()
                                        .isBookmarked(book)
                                    ? Icons.bookmark
                                    : Icons.bookmark_border,
                              ),
                              onPressed: () {
                                final favoritesProvider =
                                    context.read<FavoritesProvider>();
                                favoritesProvider.toggleFavorite(book);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        favoritesProvider.isBookmarked(book)
                                            ? 'Added to favorites'
                                            : 'Removed from favorites'),
                                    backgroundColor:
                                        favoritesProvider.isBookmarked(book)
                                            ? Colors.green
                                            : Colors.red,
                                  ),
                                );
                              },
                              color: Colors.teal,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 24),
                      ElevatedButton.icon(
                        onPressed: () => onDelete(book),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          padding: EdgeInsets.symmetric(
                              vertical: 14, horizontal: 20),
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        icon: Icon(
                          Icons.delete_outline,
                          color: Colors.white,
                          size: 24,
                        ),
                        label: Text(
                          'Delete Book',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
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

  Widget _buildStat(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}

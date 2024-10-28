import 'package:flutter/foundation.dart';
import '../models/book.dart';

class FavoritesProvider with ChangeNotifier {
  final List<Book> _favoriteBooks = [];

  List<Book> get favoriteBooks => _favoriteBooks;

  bool isBookmarked(Book book) {
    return _favoriteBooks.contains(book);
  }

  void toggleFavorite(Book book) {
    if (_favoriteBooks.contains(book)) {
      _favoriteBooks.remove(book);
    } else {
      _favoriteBooks.add(book);
    }
    notifyListeners();
  }
}

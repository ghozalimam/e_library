import '../models/book.dart';

class BookData {
  static List<Book> getBooks() {
    return [
      Book(
        title: 'Flutter for Beginners',
        thumbnailUrl: 'assets/images/flutter book.png',
        year: '2021',
        description: 'A comprehensive guide to get started with Flutter.',
        author: 'John Doe',
      ),
      Book(
        title: 'Dart Programming',
        thumbnailUrl: 'assets/images/project.jpeg',
        year: '2020',
        description: 'Learn the Dart programming language for Flutter.',
        author: 'Jane Smith',
      ),
      Book(
        title: 'Advanced Flutter',
        thumbnailUrl: 'assets/images/advance.png',
        year: '2022',
        description: 'Deep dive into advanced Flutter concepts.',
        author: 'Mike Johnson',
      ),
    ];
  }

  static void addBook(Book newBook) {}
}

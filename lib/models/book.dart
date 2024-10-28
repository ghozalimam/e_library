class Book {
  String title;
  String description;
  String author;
  String year;
  String thumbnailUrl;
  bool isFavorite;

  Book({
    required this.title,
    required this.description,
    required this.author,
    required this.year,
    required this.thumbnailUrl,
    this.isFavorite = false,
  });
}
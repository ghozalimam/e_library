import 'package:flutter/material.dart';
import '../data/book_data.dart';
import '../models/book.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late List<Book> allBooks;
  late List<Book> filteredBooks;
  String query = '';

  @override
  void initState() {
    super.initState();
    allBooks = BookData.getBooks(); 
    filteredBooks = allBooks;
  }

  void _filterBooks(String query) {
    final filtered = allBooks.where((book) {
      return book.title.toLowerCase().contains(query.toLowerCase()) ||
          book.year.contains(query) ||
          book.description.toLowerCase().contains(query.toLowerCase());
    }).toList();

    setState(() {
      this.query = query;
      filteredBooks = filtered;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pencarian E-Library'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: _filterBooks,
              decoration: InputDecoration(
                labelText: 'Cari Judul, Tahun, atau Deskripsi',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredBooks.length,
              itemBuilder: (context, index) {
                final book = filteredBooks[index];
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Image.asset(
                      book.thumbnailUrl,
                      width: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text(book.title),
                    subtitle: Text('${book.year} - ${book.description}'),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/favorites_provider.dart';
import '../models/book.dart';
import 'book_detail_screen.dart';

class FavoritesScreen extends StatelessWidget {
 @override
 Widget build(BuildContext context) {
   return Consumer<FavoritesProvider>(
     builder: (context, favoritesProvider, child) {
       final favoriteBooks = favoritesProvider.favoriteBooks;

       return Scaffold(
         backgroundColor: Colors.grey[100],
         body: SafeArea(
           child: Column(
             children: [
               Container(
                 padding: EdgeInsets.all(20),
                 decoration: BoxDecoration(
                   color: Colors.white,
                   boxShadow: [
                     BoxShadow(
                       color: Colors.black12,
                       blurRadius: 5,
                     )
                   ],
                 ),
                 child: Column(
                   children: [
                     Row(
                       children: [
                         Icon(
                           Icons.bookmark,
                           color: Colors.teal,
                           size: 24,
                         ),
                         SizedBox(width: 8),
                         Text(
                           'My Favorites',
                           style: TextStyle(
                             fontSize: 24,
                             fontWeight: FontWeight.bold,
                             color: Colors.teal,
                           ),
                         ),
                       ],
                     ),
                     SizedBox(height: 16),
                     Text(
                       'You have ${favoriteBooks.length} favorite books',
                       style: TextStyle(
                         color: Colors.grey[600],
                         fontSize: 16,
                       ),
                     ),
                   ],
                 ),
               ),
               Expanded(
                 child: favoriteBooks.isEmpty
                     ? Center(
                         child: Column(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             Container(
                               padding: EdgeInsets.all(20),
                               decoration: BoxDecoration(
                                 color: Colors.teal.withOpacity(0.1),
                                 shape: BoxShape.circle,
                               ),
                               child: Icon(
                                 Icons.bookmark_border,
                                 size: 80,
                                 color: Colors.teal,
                               ),
                             ),
                             SizedBox(height: 24),
                             Text(
                               'No Favorite Books Yet',
                               style: TextStyle(
                                 fontSize: 20,
                                 fontWeight: FontWeight.bold,
                                 color: Colors.teal,
                               ),
                             ),
                             SizedBox(height: 8),
                             Text(
                               'Tap the bookmark icon on books\nto add them to favorites',
                               textAlign: TextAlign.center,
                               style: TextStyle(
                                 fontSize: 16,
                                 color: Colors.grey[600],
                                 height: 1.5,
                               ),
                             ),
                           ],
                         ),
                       )
                     : Padding(
                         padding: EdgeInsets.all(16),
                         child: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Container(
                               padding: EdgeInsets.all(16),
                               decoration: BoxDecoration(
                                 color: Colors.white,
                                 borderRadius: BorderRadius.circular(12),
                                 boxShadow: [
                                   BoxShadow(
                                     color: Colors.black.withOpacity(0.05),
                                     blurRadius: 10,
                                   )
                                 ],
                               ),
                               child: Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceAround,
                                 children: [
                                   _buildStat('Total Books', favoriteBooks.length.toString()),
                                   Container(height: 40, width: 1, color: Colors.grey[300]),
                                   _buildStat('Last Added', 'Today'),
                                 ],
                               ),
                             ),
                             SizedBox(height: 20),
                             Expanded(
                               child: GridView.builder(
                                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                   crossAxisCount: 2,
                                   childAspectRatio: 0.75,
                                   crossAxisSpacing: 16,
                                   mainAxisSpacing: 16,
                                 ),
                                 itemCount: favoriteBooks.length,
                                 itemBuilder: (context, index) {
                                   final book = favoriteBooks[index];
                                   return Dismissible(
                                     key: Key(book.title),
                                     direction: DismissDirection.endToStart,
                                     background: Container(
                                       alignment: Alignment.centerRight,
                                       padding: EdgeInsets.only(right: 20.0),
                                       decoration: BoxDecoration(
                                         color: Colors.red,
                                         borderRadius: BorderRadius.circular(12),
                                       ),
                                       child: Icon(
                                         Icons.delete,
                                         color: Colors.white,
                                       ),
                                     ),
                                     onDismissed: (direction) {
                                       favoritesProvider.toggleFavorite(book);
                                       ScaffoldMessenger.of(context).showSnackBar(
                                         SnackBar(
                                           content: Text('${book.title} removed from favorites'),
                                           action: SnackBarAction(
                                             label: 'Undo',
                                             onPressed: () {
                                               favoritesProvider.toggleFavorite(book);
                                             },
                                           ),
                                         ),
                                       );
                                     },
                                     child: BookCard(book: book),
                                   );
                                 },
                               ),
                             ),
                           ],
                         ),
                       ),
               ),
             ],
           ),
         ),
       );
     },
   );
 }

 Widget _buildStat(String label, String value) {
   return Column(
     children: [
       Text(
         value,
         style: TextStyle(
           fontSize: 24,
           fontWeight: FontWeight.bold,
           color: Colors.teal,
         ),
       ),
       SizedBox(height: 4),
       Text(
         label,
         style: TextStyle(
           color: Colors.grey[600],
           fontSize: 14,
         ),
       ),
     ],
   );
 }
}

class BookCard extends StatelessWidget {
 final Book book;

 const BookCard({Key? key, required this.book}) : super(key: key);

 @override
 Widget build(BuildContext context) {
   return GestureDetector(
     onTap: () {
       Navigator.push(
         context,
         MaterialPageRoute(
           builder: (context) => BookDetailScreen(
             book: book,
             onDelete: (_) {},
           ),
         ),
       );
     },
     child: Stack(
       children: [
         Container(
           decoration: BoxDecoration(
             color: Colors.white,
             borderRadius: BorderRadius.circular(12),
             boxShadow: [
               BoxShadow(
                 color: Colors.black.withOpacity(0.1),
                 blurRadius: 4,
                 offset: Offset(0, 2),
               ),
             ],
           ),
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Expanded(
                 child: Container(
                   decoration: BoxDecoration(
                     borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                     image: DecorationImage(
                       image: AssetImage(book.thumbnailUrl),
                       fit: BoxFit.cover,
                     ),
                   ),
                 ),
               ),
               Container(
                 padding: EdgeInsets.all(12),
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Text(
                       book.title,
                       maxLines: 2,
                       overflow: TextOverflow.ellipsis,
                       style: TextStyle(
                         fontSize: 14,
                         fontWeight: FontWeight.bold,
                       ),
                     ),
                     SizedBox(height: 4),
                     Text(
                       book.author,
                       style: TextStyle(
                         color: Colors.grey[600],
                         fontSize: 12,
                       ),
                     ),
                     SizedBox(height: 8),
                     Container(
                       padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                       decoration: BoxDecoration(
                         color: Colors.teal.withOpacity(0.1),
                         borderRadius: BorderRadius.circular(12),
                       ),
                       child: Text(
                         book.year,
                         style: TextStyle(
                           color: Colors.teal,
                           fontSize: 12,
                           fontWeight: FontWeight.w500,
                         ),
                       ),
                     ),
                   ],
                 ),
               ),
             ],
           ),
         ),
         // Remove button
         Positioned(
           top: 8,
           right: 8,
           child: Container(
             decoration: BoxDecoration(
               color: Colors.white,
               shape: BoxShape.circle,
               boxShadow: [
                 BoxShadow(
                   color: Colors.black12,
                   blurRadius: 4,
                 ),
               ],
             ),
             child: IconButton(
               icon: Icon(Icons.bookmark, color: Colors.teal),
               onPressed: () {
                 Provider.of<FavoritesProvider>(context, listen: false)
                     .toggleFavorite(book);
                 ScaffoldMessenger.of(context).showSnackBar(
                   SnackBar(
                     content: Text('${book.title} removed from favorites'),
                     action: SnackBarAction(
                       label: 'Undo',
                       onPressed: () {
                         Provider.of<FavoritesProvider>(context, listen: false)
                             .toggleFavorite(book);
                       },
                     ),
                   ),
                 );
               },
               iconSize: 20,
               padding: EdgeInsets.all(8),
               constraints: BoxConstraints(),
             ),
           ),
         ),
       ],
     ),
   );
 }
}
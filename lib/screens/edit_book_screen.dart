import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myapp/screens/book_detail_screen.dart';
import '../models/book.dart';

class EditBookScreen extends StatefulWidget {
  final Book book;

  EditBookScreen({required this.book});

  @override
  _EditBookScreenState createState() => _EditBookScreenState();
}

class _EditBookScreenState extends State<EditBookScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _authorController;
  late TextEditingController _yearController;
  XFile? _coverImage;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.book.title);
    _descriptionController =
        TextEditingController(text: widget.book.description);
    _authorController = TextEditingController(text: widget.book.author);
    _yearController = TextEditingController(text: widget.book.year);
  }

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    _coverImage = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {});
  }

  void _saveChanges() {
    if (_formKey.currentState!.validate()) {
      widget.book.title = _titleController.text;
      widget.book.description = _descriptionController.text;
      widget.book.author = _authorController.text;
      widget.book.year = _yearController.text;
      if (_coverImage != null) {
        widget.book.thumbnailUrl = _coverImage!.path;
      }
      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Book updated successfully!'),
          backgroundColor: Colors.teal,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _authorController.dispose();
    _yearController.dispose();
    super.dispose();
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Colors.teal),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey[300]!),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey[300]!),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.teal),
          ),
          filled: true,
          fillColor: Colors.grey[50],
        ),
        validator: validator ??
            (value) {
              if (value == null || value.isEmpty) {
                return '$label cannot be empty';
              }
              return null;
            },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.teal),
          onPressed: () {
            // Tampilkan dialog konfirmasi
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  title: Text(
                    'Discard Changes?',
                    style: TextStyle(
                      color: Colors.teal,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  content: Text('Do you want to save changes before leaving?'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context); 
                        Navigator.pop(context); 
                      },
                      child: Text(
                        'Discard',
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context); 
                        if (_formKey.currentState!.validate()) {
                          widget.book.title = _titleController.text;
                          widget.book.description = _descriptionController.text;
                          widget.book.author = _authorController.text;
                          widget.book.year = _yearController.text;
                          if (_coverImage != null) {
                            widget.book.thumbnailUrl = _coverImage!.path;
                          }

                          
                          Navigator.pop(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BookDetailScreen(
                                book: widget.book,
                                onDelete: (_) {},
                              ),
                            ),
                          );

                  
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Book updated successfully!'),
                              backgroundColor: Colors.teal,
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              action: SnackBarAction(
                                label: 'OK',
                                textColor: Colors.white,
                                onPressed: () {},
                              ),
                            ),
                          );
                        }
                      },
                      child: Text(
                        'Save',
                        style: TextStyle(
                          color: Colors.teal,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
        title: Text(
          'Edit Book',
          style: TextStyle(
            color: Colors.teal,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Stack(
                    children: [
                      Container(
                        width: 150,
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 10,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: _coverImage != null
                              ? Image.file(
                                  File(_coverImage!.path),
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(
                                  widget.book.thumbnailUrl,
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: _pickImage,
                          child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.teal,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 32),

                _buildTextField(
                  controller: _titleController,
                  label: 'Title',
                  icon: Icons.book,
                ),
                _buildTextField(
                  controller: _authorController,
                  label: 'Author',
                  icon: Icons.person,
                ),
                _buildTextField(
                  controller: _yearController,
                  label: 'Year',
                  icon: Icons.calendar_today,
                ),
                _buildTextField(
                  controller: _descriptionController,
                  label: 'Description',
                  icon: Icons.description,
                  maxLines: 4,
                ),

                SizedBox(height: 24),
                Container(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _saveChanges,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Save Changes',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

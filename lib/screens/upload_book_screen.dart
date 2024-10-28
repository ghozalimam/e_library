import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../models/book.dart';
import '../data/book_data.dart';

class UploadBookScreen extends StatefulWidget {
  @override
  _UploadBookScreenState createState() => _UploadBookScreenState();
}

class _UploadBookScreenState extends State<UploadBookScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();
  XFile? _coverImage;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    try {
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          _coverImage = image;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal memilih gambar: $e')),
      );
    }
  }

  void _uploadBook() {
    if (_formKey.currentState!.validate()) {
      if (_coverImage == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Silakan pilih gambar sampul buku')),
        );
        return;
      }

      final newBook = Book(
        title: _titleController.text,
        description: _descriptionController.text,
        author: _authorController.text,
        year: _yearController.text,
        thumbnailUrl: _coverImage!.path,
      );

      // Menambahkan buku baru ke BookData
      BookData.addBook(newBook);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Buku berhasil diunggah')),
      );

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Buku'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    width: 150,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: _coverImage == null
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add_photo_alternate, size: 40),
                              SizedBox(height: 8),
                              Text('Pilih Sampul Buku'),
                            ],
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.file(
                              File(_coverImage!.path),
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                ),
              ),
              SizedBox(height: 24),
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Judul Buku',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Judul buku tidak boleh kosong';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _authorController,
                decoration: InputDecoration(
                  labelText: 'Penulis',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama penulis tidak boleh kosong';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _yearController,
                decoration: InputDecoration(
                  labelText: 'Tahun Terbit',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Tahun terbit tidak boleh kosong';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Deskripsi',
                  border: OutlineInputBorder(),
                ),
                maxLines: 4,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Deskripsi tidak boleh kosong';
                  }
                  return null;
                },
              ),
              SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _uploadBook,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Upload Buku',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _authorController.dispose();
    _yearController.dispose();
    super.dispose();
  }
}
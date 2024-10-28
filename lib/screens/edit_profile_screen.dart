import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
 final String currentName;
 final String currentEmail;
 final String currentPhotoUrl;

 EditProfileScreen({
   required this.currentName,
   required this.currentEmail,
   required this.currentPhotoUrl,
 });

 @override
 _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
 final _formKey = GlobalKey<FormState>();
 late TextEditingController _nameController;
 late TextEditingController _emailController;
 XFile? _newProfileImage;
 bool _isLoading = false;

 @override
 void initState() {
   super.initState();
   _nameController = TextEditingController(text: widget.currentName);
   _emailController = TextEditingController(text: widget.currentEmail);
 }

 Future<void> _pickImage() async {
   final ImagePicker picker = ImagePicker();
   try {
     final XFile? image = await picker.pickImage(
       source: ImageSource.gallery,
       maxWidth: 512,
       maxHeight: 512,
       imageQuality: 75,
     );
     if (image != null) {
       setState(() {
         _newProfileImage = image;
       });
     }
   } catch (e) {
     ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(content: Text('Error picking image')),
     );
   }
 }

 Future<void> _saveChanges() async {
   if (_formKey.currentState!.validate()) {
     setState(() {
       _isLoading = true;
     });

     try {
       await Future.delayed(Duration(seconds: 1));

       Navigator.pop(context, {
         'name': _nameController.text,
         'email': _emailController.text,
         'photoUrl': _newProfileImage?.path ?? widget.currentPhotoUrl,
       });
     } catch (e) {
       ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(content: Text('Error saving changes')),
       );
     } finally {
       setState(() {
         _isLoading = false;
       });
     }
   }
 }

 @override
 Widget build(BuildContext context) {
   return Scaffold(
     backgroundColor: Colors.grey[100],
     appBar: AppBar(
       backgroundColor: Colors.transparent,
       elevation: 0,
       leading: IconButton(
         icon: Icon(Icons.arrow_back, color: Colors.teal),
         onPressed: () => Navigator.pop(context),
       ),
       title: Text(
         'Edit Profile',
         style: TextStyle(
           color: Colors.teal,
           fontWeight: FontWeight.bold,
         ),
       ),
     ),
     body: SingleChildScrollView(
       child: Padding(
         padding: EdgeInsets.all(20),
         child: Form(
           key: _formKey,
           child: Column(
             children: [
               Stack(
                 alignment: Alignment.center,
                 children: [
                   Container(
                     width: 120,
                     height: 120,
                     decoration: BoxDecoration(
                       shape: BoxShape.circle,
                       border: Border.all(
                         color: Colors.teal,
                         width: 2,
                       ),
                     ),
                     child: ClipOval(
                       child: _newProfileImage != null
                           ? Image.file(
                               File(_newProfileImage!.path),
                               fit: BoxFit.cover,
                             )
                           : widget.currentPhotoUrl.isNotEmpty
                               ? Image.asset(
                                   widget.currentPhotoUrl,
                                   fit: BoxFit.cover,
                                 )
                               : Icon(
                                   Icons.person,
                                   size: 60,
                                   color: Colors.grey[400],
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
                           border: Border.all(
                             color: Colors.white,
                             width: 2,
                           ),
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
               SizedBox(height: 32),

               // Name Field
               Container(
                 decoration: BoxDecoration(
                   color: Colors.white,
                   borderRadius: BorderRadius.circular(12),
                   boxShadow: [
                     BoxShadow(
                       color: Colors.black.withOpacity(0.05),
                       blurRadius: 10,
                     ),
                   ],
                 ),
                 child: TextFormField(
                   controller: _nameController,
                   decoration: InputDecoration(
                     labelText: 'Name',
                     prefixIcon: Icon(Icons.person_outline, color: Colors.teal),
                     border: OutlineInputBorder(
                       borderRadius: BorderRadius.circular(12),
                       borderSide: BorderSide.none,
                     ),
                     filled: true,
                     fillColor: Colors.white,
                   ),
                   validator: (value) {
                     if (value == null || value.isEmpty) {
                       return 'Please enter your name';
                     }
                     return null;
                   },
                 ),
               ),
               SizedBox(height: 20),

               // Email Field
               Container(
                 decoration: BoxDecoration(
                   color: Colors.white,
                   borderRadius: BorderRadius.circular(12),
                   boxShadow: [
                     BoxShadow(
                       color: Colors.black.withOpacity(0.05),
                       blurRadius: 10,
                     ),
                   ],
                 ),
                 child: TextFormField(
                   controller: _emailController,
                   keyboardType: TextInputType.emailAddress,
                   decoration: InputDecoration(
                     labelText: 'Email',
                     prefixIcon: Icon(Icons.email_outlined, color: Colors.teal),
                     border: OutlineInputBorder(
                       borderRadius: BorderRadius.circular(12),
                       borderSide: BorderSide.none,
                     ),
                     filled: true,
                     fillColor: Colors.white,
                   ),
                   validator: (value) {
                     if (value == null || value.isEmpty) {
                       return 'Please enter your email';
                     }
                     if (!value.contains('@')) {
                       return 'Please enter a valid email';
                     }
                     return null;
                   },
                 ),
               ),
               SizedBox(height: 32),
               SizedBox(
                 width: double.infinity,
                 height: 50,
                 child: ElevatedButton(
                   onPressed: _isLoading ? null : _saveChanges,
                   style: ElevatedButton.styleFrom(
                     backgroundColor: Colors.teal,
                     shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(12),
                     ),
                     elevation: 0,
                   ),
                   child: _isLoading
                       ? SizedBox(
                           width: 20,
                           height: 20,
                           child: CircularProgressIndicator(
                             strokeWidth: 2,
                             valueColor:
                                 AlwaysStoppedAnimation<Color>(Colors.white),
                           ),
                         )
                       : Text(
                           'Save Changes',
                           style: TextStyle(
                             fontSize: 16,
                             fontWeight: FontWeight.bold,
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

 @override
 void dispose() {
   _nameController.dispose();
   _emailController.dispose();
   super.dispose();
 }
}
import 'package:flutter/material.dart';
import 'edit_profile_screen.dart';
import 'dart:io';

class ProfileScreen extends StatelessWidget {
  final String userName;
  final String userEmail;
  final String userPhotoUrl;
  final Function(String, String, String) onProfileUpdated;

  ProfileScreen({
    required this.userName,
    required this.userEmail,
    required this.userPhotoUrl,
    required this.onProfileUpdated,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: SingleChildScrollView(
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
                        Stack(
                          children: [
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.teal,
                                  width: 2,
                                ),
                              ),
                              child: CircleAvatar(
                                backgroundColor: Colors.grey[200],
                                backgroundImage: userPhotoUrl.startsWith('http')
                                    ? NetworkImage(userPhotoUrl)
                                        as ImageProvider
                                    : FileImage(File(userPhotoUrl)),
                                child: userPhotoUrl.isEmpty
                                    ? Icon(Icons.person,
                                        size: 40, color: Colors.grey[400])
                                    : null,
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: Colors.teal,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.edit,
                                  size: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                userName,
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                userEmail,
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Stats Section
              Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  children: [
                    _buildStatCard('Books Read', '23', Icons.book),
                    SizedBox(width: 20),
                    _buildStatCard('Favorites', '12', Icons.favorite),
                    SizedBox(width: 20),
                    _buildStatCard('Reviews', '8', Icons.star),
                  ],
                ),
              ),

              // Menu Items
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    _buildMenuItem(
                      'Edit Profile',
                      Icons.person_outline,
                      () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditProfileScreen(
                              currentName: userName,
                              currentEmail: userEmail,
                              currentPhotoUrl: userPhotoUrl,
                            ),
                          ),
                        );

                        if (result != null) {
                          onProfileUpdated(
                            result['name'],
                            result['email'],
                            result['photoUrl'],
                          );
                        }
                      },
                    ),
                    _buildMenuItem(
                      'Change Password',
                      Icons.lock_outline,
                      () {
                        
                      },
                    ),
                    _buildMenuItem(
                      'Reading History',
                      Icons.history,
                      () {
                       
                      },
                    ),
                    _buildMenuItem(
                      'Notifications',
                      Icons.notifications_outlined,
                      () {
                        
                      },
                    ),
                    _buildMenuItem(
                      'Settings',
                      Icons.settings_outlined,
                      () {
                        
                      },
                    ),
                    _buildMenuItem(
                      'Help Center',
                      Icons.help_outline,
                      () {
                        
                      },
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.of(context).pushReplacementNamed('/login');
                        },
                        icon: Icon(Icons.logout),
                        label: Text('Logout'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          padding: EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(16),
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
        child: Column(
          children: [
            Icon(icon, color: Colors.teal, size: 24),
            SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(String title, IconData icon, VoidCallback onTap) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
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
      child: ListTile(
        onTap: onTap,
        leading: Icon(icon, color: Colors.teal),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Colors.grey,
        ),
      ),
    );
  }
}

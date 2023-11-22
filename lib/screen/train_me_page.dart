import 'dart:io';
import 'dart:typed_data';

import 'package:academia/auth/auth_page.dart';
import 'package:academia/componentes/MySearchDelegate.dart';
import 'package:academia/screen/exercises_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:image_picker/image_picker.dart';

class TrainMe extends StatefulWidget {
  const TrainMe({super.key});

  @override
  State<TrainMe> createState() => _TrainMeState();
}

class _TrainMeState extends State<TrainMe> {
  //signout button
  void signOutUser() async {
    await FirebaseAuth.instance.signOut();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => AuthPage()));
  }

  final _user = FirebaseAuth.instance.currentUser;
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: const Text('Train me')),
        backgroundColor: Color.fromRGBO(28, 43, 69, 1),
        elevation: 2,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: MySearchDelegate());
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: Container(
          color: Color.fromRGBO(28, 43, 69, 1),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    // Seus outros widgets aqui
                    UserAccountsDrawerHeader(
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(28, 43, 69, 1),
                      ),
                      accountName: Padding(
                        padding: EdgeInsets.only(top: 30.0),
                        child: Text(
                          _user?.displayName ?? 'Usuário',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      accountEmail: Padding(
                        padding: EdgeInsets.only(bottom: 0.0),
                        child: Text(
                          _user?.email ?? 'Email',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      currentAccountPicture: GestureDetector(
                        onTap: () async {
                          setState(() {
                            _isLoading = true;
                          });
                          final ImagePicker _picker = ImagePicker();
                          XFile? image = await _picker.pickImage(
                              source: ImageSource.camera);

                          if (image != null) {
                            final String filePath = image.path;
                            File imageFile = File(filePath);

                            try {
                              // Upload to Firebase storage
                              final ref = FirebaseStorage.instance
                                  .ref('/user_image/${_user?.uid}.jpg');
                              await ref.putFile(imageFile);

                              // Get URL
                              final url = await ref.getDownloadURL();

                              // Update user profile
                              // Update user profile
                              await _user?.updatePhotoURL(url);
                              _user?.reload().then((_) {
                                setState(() {
                                  _isLoading = false;
                                });
                              });
                            } catch (e) {
                              print('Failed to upload image: $e');
                            }
                          }
                        },
                        child: _isLoading
                            ? CircularProgressIndicator()
                            : CircleAvatar(
                                radius: 64,
                                backgroundColor: Colors.white,
                                backgroundImage: NetworkImage(FirebaseAuth
                                        .instance.currentUser?.photoURL ??
                                    'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png'),
                              ),
                      ),
                    ),
                  ],
                ),
                ListTile(
                  title: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 70.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        fixedSize: Size(60, 40),
                      ),
                      onPressed: signOutUser,
                      child: Text('Logout'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Exercises(),
    );
  }
}

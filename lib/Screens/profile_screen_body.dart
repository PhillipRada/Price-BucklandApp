import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileBody extends StatefulWidget {
  ProfileBody({Key? key}) : super(key: key);

  @override
  _ProfileBodyState createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  void uploadImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    Reference ref =
        FirebaseStorage.instance.ref().child("${user?.email}profilepic.jpg");

    await ref.putFile(File(image!.path));

    ref.getDownloadURL().then((value) async {
      print(value);
      setState(() {
        profilePicLink = value;
      });
      final user = await FirebaseAuth.instance.currentUser!;
      user.updatePhotoURL(profilePicLink);
    });
  }

  updatePassword() async {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    User? currentUser = firebaseAuth.currentUser;
    try {
      await currentUser?.updatePassword(_updatedPassword.text);
    } catch (err) {
      // An error has occurred.
    }
  }

  @override
  final user = FirebaseAuth.instance.currentUser;
  late String? email = user?.email;
  String profilePicLink = " ";
  TextEditingController _updatedPassword = TextEditingController();

  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 215,
          width: 215,
          child: Stack(
            fit: StackFit.expand,
            children: [
              CircleAvatar(
                foregroundImage: NetworkImage(profilePicLink),
              ),
              Positioned(
                right: -10,
                bottom: 0,
                child: GestureDetector(
                  onTap: () {
                    uploadImage();
                  },
                  child: SizedBox(
                    height: 30,
                    width: 46,
                    child: CircleAvatar(
                      backgroundColor: Colors.grey[200],
                      radius: 100,
                      child: Image.asset("assets/Icons/camera.png"),
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        Center(
          child: Column(
            children: [
              Text(
                '${user!.email}',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                child: Text('Edit Account Info'),
                onPressed: () {},
              ),
              ElevatedButton(
                child: Text('Add Child Profiles'),
                onPressed: () {
                  // TODO: Add child profile
                },
              ),
            ],
          ),
        ),
        TextFormField(
          decoration: InputDecoration(
            labelText: 'Username',
            icon: Icon(Icons.person),
          ),
          initialValue: email,
        ),
        TextFormField(
          controller: _updatedPassword,
          decoration: InputDecoration(
            labelText: 'New Password',
            icon: Icon(Icons.lock),
          ),
          obscureText: true,
        ),
        TextFormField(
          decoration: InputDecoration(
            labelText: 'Confirm Password',
            icon: Icon(Icons.lock),
          ),
          obscureText: true,
        ),
        ElevatedButton(
          child: Text('Update User Details'),
          onPressed: () {
            updatePassword();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                duration: Duration(seconds: 3),
                content: Text('User Updated'),
              ),
            );
          },
        ),
      ],
    );
  }
}

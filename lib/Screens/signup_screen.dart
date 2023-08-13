import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../Screens/welcome_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpState();
}

class _SignUpState extends State<SignUpScreen> {
  //Getting Firebase
  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: _initializeFirebase(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return SignUpScreen();
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    ));
  }
}

class SignUpForm extends StatelessWidget {
  const SignUpForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Email", style: TextStyle(color: Colors.black)),
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 16),
            child: TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                  //hintText: "Email",
                  prefixIcon: Icon(
                Icons.mail,
              )),
            ),
          ),
          Text("Password", style: TextStyle(color: Colors.black)),
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 10),
            child: TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                //hintText: "Password",
                prefixIcon: Icon(
                  Icons.lock,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 24),
            child: ElevatedButton.icon(
              onPressed: () async {
                User? user = await signupUsingEmailPassword(
                    email: _emailController.text,
                    password: _passwordController.text,
                    context: context);

                if (user != null) {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => WelcomeScreen()),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF4A4040),
                minimumSize: Size(double.infinity, 56),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                ),
              ),
              icon: const Icon(CupertinoIcons.arrow_right),
              label: const Text("Sign Up"),
            ),
          )
        ],
      ),
    );
  }

  Future<User?> signupUsingEmailPassword(
      {required String email,
      required String password,
      required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;

      //Add the user to the Firebase Store
      FirebaseFirestore.instance
          .collection('Users')
          .doc(userCredential.user?.uid)
          .set({'email': userCredential.user!.email, 'password': password});
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-found") {
        print("User Found With This Email");
      }
    }

    return user;
  }
}

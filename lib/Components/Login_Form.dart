import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Screens/login_screen.dart';
import '../Screens/welcome_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
          return LoginScreen();
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    ));
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({
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
                User? user = await loginUsingEmailPassword(
                    email: _emailController.text,
                    password: _passwordController.text,
                    context: context);
                print(user);

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
              label: const Text("Login"),
            ),
          )
        ],
      ),
    );
  }

  static Future<User?> loginUsingEmailPassword(
      {required String email,
      required String password,
      required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        print("No User Found With That Email");
      }
    }

    return user;
  }
}

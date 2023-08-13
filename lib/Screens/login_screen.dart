import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

//Screen Imports
import 'package:practise1/Screens/signup_screen.dart';

import '../Components/Login_Form.dart';

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

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF253955),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Center(child: Image.asset('assets/logo/Group 36.png')),
              ],
            ),
            const SizedBox(height: 44.0),

            const Padding(
              padding: EdgeInsets.only(left: 45),
              child: Text(
                "Login To App",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 44.0,
                    fontFamily: "Mont",
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 15.0),

            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Center(
                    child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Image.asset(
                    'assets/images/actors.png',
                    width: 1200.0,
                  ),
                )),
              ],
            ),
            const SizedBox(height: 40.0),
            //? Login In Pop Up
            Container(
              width: double.infinity,
              child: RawMaterialButton(
                fillColor: const Color(0xFF4A4040),
                elevation: 0.0,
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0)),
                onPressed: () {
                  showGeneralDialog(
                    barrierDismissible: true,
                    barrierLabel: "Login In",
                    context: context,
                    pageBuilder: (context, _, __) => Center(
                      child: Container(
                        height: 620,
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        padding:
                            EdgeInsets.symmetric(vertical: 32, horizontal: 24),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.90),
                          borderRadius: BorderRadius.all(Radius.circular(40)),
                        ),
                        child: Scaffold(
                          backgroundColor: Colors.transparent,
                          body: Column(
                            children: [
                              Text(
                                "Login In",
                                style: TextStyle(
                                  fontSize: 34,
                                  fontFamily: "Poppins",
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 16),
                                child: Text(
                                  "Access To 1000 plus items on sale. Sometimes on sales so good you cant skip out",
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const LoginForm(),
                              GestureDetector(
                                onTap: () {},
                                child: Text("Forgot your password?",
                                    style: TextStyle(color: Colors.blue)),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: const [
                                  Expanded(child: Divider()),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16),
                                    child: Text(
                                      "OR",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                  Expanded(child: Divider()),
                                ],
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 25),
                                child: Text(
                                  "Login Via Google Or Apple",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  IconButton(
                                    padding: EdgeInsets.zero,
                                    onPressed: () {},
                                    icon: Image.asset(
                                      'assets/Icons/GoogleIcon.png',
                                      height: 64,
                                      width: 64,
                                    ),
                                  ),
                                  IconButton(
                                    padding: EdgeInsets.zero,
                                    onPressed: () {},
                                    icon: Image.asset(
                                      'assets/Icons/apple-icon.png',
                                      height: 64,
                                      width: 64,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
                child: const Text(
                  "Login",
                  style: TextStyle(color: Colors.white, fontSize: 18.0),
                ),
              ),
            ),
            const SizedBox(height: 12.0),

            //? Sign Up Screen
            Container(
              width: double.infinity,
              child: RawMaterialButton(
                fillColor: const Color(0xFF4A4040),
                elevation: 0.0,
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0)),
                onPressed: () {
                  showGeneralDialog(
                    barrierDismissible: true,
                    barrierLabel: "Sign Up",
                    context: context,
                    pageBuilder: (context, _, __) => Center(
                      child: Container(
                        height: 620,
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        padding:
                            EdgeInsets.symmetric(vertical: 32, horizontal: 24),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.90),
                          borderRadius: BorderRadius.all(Radius.circular(40)),
                        ),
                        child: Scaffold(
                          backgroundColor: Colors.transparent,
                          body: Column(
                            children: [
                              Text(
                                "Sign Up",
                                style: TextStyle(
                                  fontSize: 34,
                                  fontFamily: "Poppins",
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 16),
                                child: Text(
                                  "Access To 1000 plus items on sale. Sometimes on sales so good you cant skip out",
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const SignUpForm(),
                              Text("Forgot your password?",
                                  style: TextStyle(color: Colors.blue)),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: const [
                                  Expanded(child: Divider()),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16),
                                    child: Text(
                                      "OR",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                  Expanded(child: Divider()),
                                ],
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 25),
                                child: Text(
                                  "Sign Up Using Google Or Apple",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  IconButton(
                                    padding: EdgeInsets.zero,
                                    onPressed: () {},
                                    icon: Image.asset(
                                      'assets/Icons/GoogleIcon.png',
                                      height: 64,
                                      width: 64,
                                    ),
                                  ),
                                  IconButton(
                                    padding: EdgeInsets.zero,
                                    onPressed: () {},
                                    icon: Image.asset(
                                      'assets/Icons/apple-icon.png',
                                      height: 64,
                                      width: 64,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
                child: const Text(
                  "Sign Up",
                  style: TextStyle(color: Colors.white, fontSize: 18.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class GoogleSignIn extends StatefulWidget {
  const GoogleSignIn({Key? key}) : super(key: key);

  @override
  State<GoogleSignIn> createState() => _GoogleSignInState();
}

class _GoogleSignInState extends State<GoogleSignIn> {
  final GoogleSignIn googleSignIn = const GoogleSignIn();
  String? name, imageUrl, userEmail, uid;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Center(
          child: InkWell(
            onTap: () {
              signInWithGoogle();
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(10)),
              child: const Text('Sign In with Google'),
            ),
          ),
        ),
      ),
    );
  }

  Future<User?> signInWithGoogle() async {
    // Initialize Firebase
    User? user;
    FirebaseAuth auth = FirebaseAuth.instance;
    // The `GoogleAuthProvider` can only be
    // used while running on the web
    GoogleAuthProvider authProvider = GoogleAuthProvider();
    authProvider.addScope("https://mail.google.com/");

    try {
      final UserCredential userCredential =
          await auth.signInWithPopup(authProvider);
      user = userCredential.user;
    } catch (e) {
      print(e);
    }

    if (user != null) {
      uid = user.uid;
      name = user.displayName;
      userEmail = user.email;
      imageUrl = user.photoURL;
    }
    return user;
  }
}

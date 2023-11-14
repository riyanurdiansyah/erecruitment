import 'package:erecruitment/src/models/user_m.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class UserRepository {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  static User? get currentUser => FirebaseAuth.instance.currentUser;

  static bool? _isLoggedIn = false;

  static UserM? userLoggedin;

  static String? isLoggedIn() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      _isLoggedIn = user?.uid != null;
    });
    if (_firebaseAuth.currentUser == null) {
      _isLoggedIn = false;
    } else {
      _isLoggedIn = true;
    }
    if (_isLoggedIn == true) {
      return null;
    } else {
      return "/signin";
    }
  }

  static isSetUsername(UserM user) {
    userLoggedin = user;
  }
}

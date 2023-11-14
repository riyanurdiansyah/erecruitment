import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:erecruitment/src/models/user_m.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<User?> signUp(Map<String, dynamic> body);

  Future<User?> signIn(Map<String, dynamic> body);

  Future<UserM?> getUser(String username);

  Future signOut();
}

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<User?> signUp(Map<String, dynamic> body) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: body["email"],
        password: body["password"],
      );
      return userCredential.user;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<User?> signIn(Map<String, dynamic> body) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: body["email"],
        password: body["password"],
      );
      return userCredential.user;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Future<UserM?> getUser(String username) async {
    List<UserM> users = [];
    try {
      final response = await FirebaseFirestore.instance
          .collection("user")
          .where("username", isEqualTo: username)
          .get();
      if (response.docs.isEmpty) {
        return null;
      } else {
        for (var data in response.docs) {
          users.add(UserM.fromJson(data.data()));
        }

        final isHaveUser = users.where((e) => e.username == username).toList();

        if (isHaveUser.isNotEmpty) {
          print("response 2");

          return isHaveUser.first;
        } else {
          print("response 3");

          return null;
        }
      }
    } catch (e) {
      return null;
    }
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '/BaseModule/Authentication/SignUpScreen.dart';
import 'forget_password_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'HomeScreen.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;


  Future<void> createUserWithEmailAndPassword(String email, String pass, BuildContext context) async {
    try {
      print('started');
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: pass,
      );
      print('ended');
      print(credential);

      // Navigate to the new screen if the user is successfully created
      if (credential.user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Homescreen()), // Replace with your target screen
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print('error Firebase.....${e}');
    }
  }





  Future<void> signInWithEmailAndPassword(String email, String password, BuildContext context) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print('Success login');

      if (credential.user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Homescreen()), // Replace with your target screen
        );
      }

    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Incorrect password provided.');
      } else if (e.code == 'invalid-email') {
        print('The email address is not valid.');
      } else {
        print('Error: ${e.message}');
      }
    } catch (e) {
      print(e);
    }
  }

}

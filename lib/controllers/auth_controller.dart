import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:employee_attendance_tracker/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Sign up with email and password
  Future<UserModel?> signUpWithEmailPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = userCredential.user;

      if (user != null) {
        final userDoc = await _firestore.collection('users').doc(user.uid).get();

        // Check if the user already exists in Firestore
        if (!userDoc.exists) {
          // If not, add user data (email and uid) to Firestore
          await _firestore.collection('users').doc(user.uid).set({
            'email': user.email,
            'uid': user.uid,
          });
        }

        return UserModel.fromFirebase(user);
      }
    } catch (e) {
      print("Error: $e");
      return null;
    }
    return null;
  }

  // Sign In with email and password
  Future<UserModel?> signInWithEmailPassword(String email, String password) async {
    try {
      if (kIsWeb) {
        // Use web-specific method for sign-in
        UserCredential userCredential = await _auth.getRedirectResult();
        return UserModel.fromFirebase(userCredential.user);
      } else {
        // Use mobile-compatible method for sign-in
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        return UserModel.fromFirebase(userCredential.user);
      }
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }
}

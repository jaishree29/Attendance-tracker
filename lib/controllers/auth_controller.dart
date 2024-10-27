import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:employee_attendance_tracker/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Sign In with email and password
  Future<UserModel?> signInWithEmailPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        DocumentSnapshot userDoc = await _firestore
            .collection('users')
            .doc(userCredential.user!.uid)
            .get();
        if (userDoc.exists) {
          UserModel user = UserModel.fromFirestore(userDoc);
          return user;
        }
      }
    } catch (e) {
      print("Sign-in error: $e");
      return null;
    }
    return null;
  }

}

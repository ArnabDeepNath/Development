import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  Future<void> registerUser({
    required String email,
    required String password,
    required String contact,
    required String firstName,
    required String secondName,
    // Add other user details as needed
  }) async {
    try {
      // Create a new user in Firebase Authentication
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Store additional user details in Firestore
      String userId = userCredential.user!.uid;
      await usersCollection.doc(userId).set({
        'contact': contact,
        'email': email,
        'id': userId,
        'first_name': firstName,
        'second_name': secondName,
        // Add other user details here
      });

      // User registration successful
    } catch (e) {
      print('Error registering user: $e');
      throw e;
    }
  }

  Future<User?> loginUser(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      // Handle login errors, e.g., show an error message.
      print('Error during login: $e');
      return null; // Return null in case of an error
    }
  }

  Future<User?> getUserByUID(String uid) async {
    try {
      User? user = await _auth.authStateChanges().firstWhere((user) {
        return user != null && user.uid == uid;
      });

      return user;
    } catch (e) {
      // Handle errors, e.g., show an error message
      print('Error fetching user by UID: $e');
      return null;
    }
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebaseAuth;
import 'package:flutter/material.dart';
import 'package:mvc_app/controller/dataController.dart';
import 'package:mvc_app/model/userModel.dart' as userModel;
import 'package:mvc_app/model/userModel.dart';
import 'package:mvc_app/view/InvoicePage_Users.dart';
import 'package:mvc_app/view/UserPanel.dart';
import 'package:mvc_app/view/adminPanel.dart';

class FirebaseAuthService {
  final firebaseAuth.FirebaseAuth _firebaseAuth =
      firebaseAuth.FirebaseAuth.instance;
  FirebaseFirestoreService authService = FirebaseFirestoreService();

  Future<firebaseAuth.UserCredential> registerUser(
    String email,
    String password,
    String crmid,
    String phone,
    String name,
    String uid,
    String address,
    String role,
  ) async {
    firebaseAuth.UserCredential userCredential =
        await _firebaseAuth.createUserWithEmailAndPassword(
      email: crmid + '@mithilamotors.com',
      password: password,
    );
    FirebaseFirestoreService firebaseFirestoreService =
        FirebaseFirestoreService();
    await firebaseFirestoreService.addUserData(
      userModel.User(
        crmId: crmid + '@mithilamotors.com',
        phone: phone,
        name: name,
        email: email,
        address: address,
        uid: _firebaseAuth.currentUser!.uid,
        role: 'User',
      ),
    );
    return userCredential;
  }

  Future<User> getCurrentUser() async {
    firebaseAuth.User firebaseUser = _firebaseAuth.currentUser!;
    DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(firebaseUser.uid)
        .get();
    Map<String, dynamic> userData = userSnapshot.data() as Map<String, dynamic>;
    String username = userData['Name'] ?? '';
    User user = User(
        uid: firebaseUser.uid,
        name: username,
        address: '',
        email: '',
        phone: '',
        crmId: '',
        role: '');
    return user;
  }

  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }

  Future<Object> signIn(
      BuildContext context, String email, String password) async {
    try {
      final firebaseAuth.UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential != null) {
        final DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .get();
        final String userRole = userSnapshot.get('role');
        print(userRole);
        if (userRole == 'User') {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => MainPage(),
            ),
          );
        } else if (userRole == 'Admin') {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => adminPanel(),
            ),
          );
        }
      }
      return userCredential;
    } on firebaseAuth.FirebaseAuthException catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text(e.message as String),
            actions: [
              MaterialButton(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return CircularProgressIndicator.adaptive();
    }
  }
}

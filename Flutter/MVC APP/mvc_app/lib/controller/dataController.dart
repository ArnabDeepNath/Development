import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mvc_app/model/userModel.dart' as ua;

class FirebaseFirestoreService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _db =
      FirebaseFirestore.instance.collection('users');

  Future<void> addUserData(ua.User user) async {
    return await _db.doc(user.uid).set({
      'crmId': user.crmId,
      'Name': user.name,
      'Phone': user.phone,
      'email': user.email,
      'address': user.address,
      'uid': user.uid,
      'role': user.role,
    });
  }

  Future<User?> getCurrentUser() async {
    return await _auth.currentUser;
  }

  Future<String> getCurrentUserName() async {
    User? user = await getCurrentUser();
    DocumentSnapshot snapshot = await _db.doc(user?.uid).get();

    if (snapshot.data is Map) {
      return snapshot.data.toString();
    } else {
      return '';
    }
  }

  Future<List> fetchUsers() async {
    final snapshot = await FirebaseFirestore.instance.collection('users').get();

    final List users = snapshot.docs.map((doc) {
      final Map<String, dynamic> data = doc.data();
      return ua.User.fromMap(data, doc.id);
    }).toList();

    return users;
  }

  Future<void> deleteUser(String userId) async {
    try {
      await _db.doc(userId).delete();
    } catch (e) {
      print('Error deleting user: $e');
      rethrow;
    }
  }
}

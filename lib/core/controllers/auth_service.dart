// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:firebase_auth/firebase_auth.dart';

// Project imports:
import 'package:resturant_app/shared/network/sevices/firestore_user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

Future deleteUser(String email, String password) async {
    try {
      User user = _auth.currentUser!;
      AuthCredential credentials =
          EmailAuthProvider.credential(email: email, password: password);
      debugPrint(user.toString());
      UserCredential result = await user.reauthenticateWithCredential(credentials);
      await FireStoreUser.deleteStaffData(result.user!.uid); // called from database class
      await result.user!.delete();
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}

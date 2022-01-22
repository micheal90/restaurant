// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';

// Project imports:
import 'package:resturant_app/models/role_model.dart';
import 'package:resturant_app/models/user_model.dart';
import 'package:resturant_app/shared/local/constants.dart';

class FireStoreUser {
  static final CollectionReference rolesCollectionReference =
      FirebaseFirestore.instance.collection('roles');
  static final CollectionReference userCollectionReference =
      FirebaseFirestore.instance.collection('users');
  static final CollectionReference staffCollectionReference =
      FirebaseFirestore.instance.collection('staff');
  static final CollectionReference adminCollectionReference =
      FirebaseFirestore.instance.collection('admin');

//rolse
////////////////////////////////////////////////////////////////

  static Future addUserRoleToFireStore(RoleModel roleModel) async {
    //print(userModel.email);
    await rolesCollectionReference.doc(roleModel.userId).set(roleModel.toMap());
  }

  static Future getUserRoleFromFireStore(String uId) async {
    return await rolesCollectionReference.doc(uId).get();
  }

  static Future deleteUserRoleFromFireStore(String uId) async {
    return await rolesCollectionReference.doc(uId).delete();
  }
//user data
////////////////////////////////////////////////////////////////////////////////////

  static Future addUserDataToFireStore(UserModel userModel, ROLE role) async {
    //print(userModel.email);
    if (role == ROLE.USER) {
      await userCollectionReference
          .doc(userModel.userId)
          .set(userModel.toMap());
    } else if (role == ROLE.STAFF) {
      await staffCollectionReference
          .doc(userModel.userId)
          .set(userModel.toMap());
    } else if (role == ROLE.ADMIN) {
      await adminCollectionReference
          .doc(userModel.userId)
          .set(userModel.toMap());
    }
  }

  static Future getUserDataFromFireStore(String uId, ROLE role) async {
    if (role == ROLE.USER) {
      return await userCollectionReference.doc(uId).get();
    } else if (role == ROLE.STAFF) {
      return await staffCollectionReference.doc(uId).get();
    } else if (role == ROLE.ADMIN){
      return await adminCollectionReference.doc(uId).get();
    }
  }

  static Future getStaffData() async {
    var data = await staffCollectionReference.get();
    return data.docs;
  }
  // static Stream<List<UserModel>> getStreamStaffData() {
  //   return staffCollectionReference.snapshots().map(
  //       (snap) => snap.docs.map((doc) => UserModel.fromSnapshot(doc)).toList());
  // }

  static Future updateStaffData(UserModel userModel) async {
    await staffCollectionReference
        .doc(userModel.userId)
        .update(userModel.toMap());
  }

  static Future deleteStaffData(String id) async {
    await staffCollectionReference.doc(id).delete();
  }
  // static Future addStaffToFireStore(UserModel userModel) async {
  //   //print(userModel.email);
  //   await userCollectionReference.doc(userModel.userId).set(userModel.toMap());
  // }

  // static Future<DocumentSnapshot> getCurrentStaffFromFireStore(
  //     String uId) async {
  //   return await userCollectionReference.doc(uId).get();
  // }
}

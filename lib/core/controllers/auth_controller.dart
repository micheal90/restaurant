// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

// Project imports:
import 'package:resturant_app/models/role_model.dart';
import 'package:resturant_app/models/user_model.dart';
import 'package:resturant_app/shared/local/constants.dart';
import 'package:resturant_app/shared/network/sevices/cash_helper.dart';
import 'package:resturant_app/shared/network/sevices/firestore_user.dart';
import 'package:resturant_app/shared/network/sevices/messaging.dart';
import 'package:resturant_app/views/control_veiw.dart';

class AuthController extends GetxController {
  final Rxn<UserModel?> _userModel = Rxn();
  Rxn<UserModel?> get userModel => _userModel;

  final Rxn<ROLE> _userRole = Rxn();
  Rxn<ROLE> get userRole => _userRole;
  List<Map<String, String>> staffData = []; //store staff id and staff name

  final Rxn<User> _user = Rxn<User>();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final Rx<bool> _isLoading = false.obs;
  Rx<bool> get isLoading => _isLoading;
  Rx<String?>? get user => _user.value?.email.obs;
  final List<UserModel> _staffs = []; //list of all staff
  List<UserModel> get staffs => _staffs;

  @override
  void onInit() async {
    super.onInit();

    _user.bindStream(_firebaseAuth.authStateChanges());
    if (_firebaseAuth.currentUser != null) {
      await getLocalUserData();
    }
  }

  signUp(
      {required String name,
      required String email,
      required String password,
      required bool isUser}) async {
    try {
      _isLoading.value = true;
      await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        if (isUser) {
          await setUserRole(value.user!.uid, ROLE.USER);
          _userModel.value = UserModel(
              userId: value.user!.uid,
              name: name,
              email: email,
              password: password,
              role: ROLE.USER.name);
          await saveUserData(_userModel.value!, ROLE.USER);
          await setUserDataLocal(_userModel.value!);
          Get.offAll(ControlView());
        } else {
          await setUserRole(value.user!.uid, ROLE.STAFF);
          _userModel.value = UserModel(
              userId: value.user!.uid,
              name: name,
              email: email,
              password: password,
              role: ROLE.STAFF.name);
          await saveUserData(_userModel.value!, ROLE.STAFF);
        }
      });
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error Registration Account", e.message.toString(),
          snackPosition: SnackPosition.BOTTOM);
    }
    _isLoading.value = false;
    await getStaffData();
    // update();
  }

  Future signIn(String email, String password) async {
    _isLoading.value = true;
    try {
      await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        await getUserRole(value.user!.uid);
        if (_userRole.value == ROLE.ADMIN) {
          await getCurrentUserData(value.user!.uid, ROLE.ADMIN);
        } else if (_userRole.value == ROLE.STAFF) {
          await getCurrentUserData(value.user!.uid, ROLE.STAFF);
        } else if (_userRole.value == ROLE.USER) {
          await getCurrentUserData(value.user!.uid, ROLE.USER);
        }
      });
      await getStaffData();

      Get.offAll(ControlView());
      debugPrint('has Login');
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error LogIn Account", e.message.toString(),
          snackPosition: SnackPosition.BOTTOM);
    }
    _isLoading.value = false;
  }

  Future saveUserData(UserModel userModel, ROLE role) async {
    await FireStoreUser.addUserDataToFireStore(userModel, role);
  }

  setUserDataLocal(UserModel userModel) async {
    debugPrint(userModel.email);
    await CashHelper.putData(key: 'userData', value: userModel);
  }

  Future getLocalUserData() async {
    _userModel.value = CashHelper.getUserData(key: 'userData');
    if (_userModel.value != null) {
      await getUserRole(_userModel.value!.userId);
      await getStaffData();
    }
  }

  Future getUserRole(String uId) async {
    await FireStoreUser.getUserRoleFromFireStore(uId).then((value) {
      RoleModel roleModel = RoleModel.fromMap(value.data());
      debugPrint(roleModel.role);
      if (roleModel.role == ROLE.USER.name) {
        _userRole.value = ROLE.USER;
      } else if (roleModel.role == ROLE.STAFF.name) {
        _userRole.value = ROLE.STAFF;
      } else {
        _userRole.value = ROLE.ADMIN;
      }
    });

  }

  Future setUserRole(String uId, ROLE role) async {
    await FireStoreUser.addUserRoleToFireStore(
            RoleModel(userId: uId, role: role.name))
        .then((value) => userRole.value = role);
  }

  Future getCurrentUserData(String uId, ROLE role) async {
    await FireStoreUser.getUserDataFromFireStore(uId, role).then((value) async {
      _userModel.value = UserModel.fromMap(value.data());
      //save user data local function
      await setUserDataLocal(_userModel.value!);
    });
    // update();
  }

  Future getStaffData() async {
    _staffs.clear();
    var data = await FireStoreUser.getStaffData();
    if (data != null) {
      data.forEach((element) {
        _staffs.add(UserModel.fromMap(element.data()));
      });
    }
    _staffs.forEach((element) {
      staffData.add({'id': element.userId, 'name': element.name});
    });
    update();
  }

  Future updateStaffData(
      {required String name,
      required String email,
      required String password,
      required bool isUser}) async {
    try {
      _isLoading.value = true;
      UserModel _tempStaff;
      await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        _tempStaff = UserModel(
            userId: value.user!.uid,
            name: name,
            email: email,
            password: password,
            role: ROLE.STAFF.name);

        await FireStoreUser.updateStaffData(_tempStaff);
      });
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error update Account", e.message.toString(),
          snackPosition: SnackPosition.BOTTOM);
    }
    _isLoading.value = false;
    // update();
  }

  Future deleteStaff(String id) async {
    _isLoading.value = true;
    await getStaffData();
    try {
      UserModel _tempStaff =
          _staffs.firstWhere((element) => element.userId == id);
      await _firebaseAuth
          .signInWithEmailAndPassword(
              email: _tempStaff.email, password: _tempStaff.password)
          .then((value) async {
        await FireStoreUser.deleteStaffData(_tempStaff.userId);
        await FireStoreUser.deleteUserRoleFromFireStore(_tempStaff.userId);
      }).then((value) async => await _firebaseAuth.currentUser!.delete());
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error delete Account", e.message.toString(),
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      UserModel? _backupUser = CashHelper.getUserData(key: 'userData');
      await _firebaseAuth
          .signInWithEmailAndPassword(
              email: _backupUser!.email, password: _backupUser.password)
          .then((value) async {
        await getCurrentUserData(_backupUser.userId, ROLE.ADMIN);
        await getStaffData();
      });
    }
    _isLoading.value = false;
    // update();
  }

  void signOut() {
    _firebaseAuth.signOut();
    CashHelper.clearKey(key: 'userData').then((value) => debugPrint('Signout'));
    _userModel.value = null;
    _userRole.value = null;
    // update();
  }

  @override
  void onReady() {
    Messaging.requestingNotificationPermission();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    AwesomeNotifications().actionSink.close();
    AwesomeNotifications().createdSink.close();
  }
}

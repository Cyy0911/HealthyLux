import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'app_user.dart';

class FirebaseService {
  Future<bool> editUser(
      String name, String email, int age, String imgUrl, double result) async {
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser != null) {
        CollectionReference users =
            FirebaseFirestore.instance.collection('Users');

        QuerySnapshot _querySnapShot =
            await users.where("userEmail", isEqualTo: email).get();

        QueryDocumentSnapshot _queryDocSnap = _querySnapShot.docs.first;

        DocumentReference _ref = _queryDocSnap.reference;

        _ref.update({
          "userName": name,
          "userEmail": email,
          "age": age,
          "imageUrl": imgUrl,
          "result": result
        });
      }
    } catch (e) {
      return Future.value(false);
    }
    return Future.value(true);
  }

  Future<bool> updateBmi(String email, double result) async {
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser != null) {
        CollectionReference users =
            FirebaseFirestore.instance.collection('Users');

        QuerySnapshot _querySnapShot =
            await users.where("userEmail", isEqualTo: email).get();

        QueryDocumentSnapshot _queryDocSnap = _querySnapShot.docs.first;

        DocumentReference _ref = _queryDocSnap.reference;

        _ref.update({"result": result});
      }
    } catch (e) {
      return Future.value(false);
    }
    return Future.value(true);
  }

  Future<AppUser> getUserInfoByEmail(String userEmail) async {
    AppUser _appUser = AppUser();

    try {
      if (userEmail.isNotEmpty) {
        CollectionReference users =
            FirebaseFirestore.instance.collection('Users');

        QuerySnapshot _querySnapShot =
            await users.where("userEmail", isEqualTo: userEmail.trim()).get();

        QueryDocumentSnapshot _queryDocSnap = _querySnapShot.docs.first;

        Object? _map = _queryDocSnap.data();

        _appUser = AppUser.fromJson(_map);
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }

    return Future.value(_appUser);
  }
}

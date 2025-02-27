import 'package:datas/model/users.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseController extends GetxController {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  //DocumentReference current_users = FirebaseFirestore.instance.collection('users').doc('current_user');
  var userslist = [].obs;
  var userData = {}.obs;
  var isLoading = true.obs;
  Future<void> UsersSaved(String username, String password, String email,
      String phone, String address) async {
    try {
      final user = Users(
              username: username,
              password: password,
              email: email,
              phone: phone,
              address: address)
          .toJson();
      await users.add(user);
      Get.snackbar('Success', 'Data added successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to add data');
    }
  }

  void FetchData() {
    users.snapshots().listen((e) {
      userslist.value = e.docs.map((doc) => doc.data() as Map).toList();
    });
  }

  Future<bool> CheckMail(String email) async {
    final u = await users.where('email', isEqualTo: email).get();

    return (u.docs.isNotEmpty) ? true : false;
  }

  
  Future<void> fetchUserData(String email) async {
    final current_user = await users.where('email', isEqualTo: email).get();
    userData.value = current_user.docs.first.data() as Map;
    if (userData.value.isNotEmpty) {
      Get.snackbar("Data stored", "It was succesful");
    } else {
      Get.snackbar("Not Saved", "It was not succesful");
    }
  }
}

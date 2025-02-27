import 'package:datas/util/Helper/DatabaseHelper.dart';
import 'package:datas/view/Auth/OTP_verification.dart';
import 'package:datas/view/Screen/HomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../../model/users.dart';

class AuthController extends GetxController {
  final Databasehelper dbHelper = Databasehelper();
  final FirebaseAuth auth = FirebaseAuth.instance;

  // Reactive state variables
  var isLoggedIn = false.obs;
  var toogle = false.obs;
  var phone = ''.obs;
  var verificationId = ''.obs;
  var isLoading = false.obs;

  void togglePasswordVisibility() {
    toogle.value = !toogle.value;
  }

  Future<void> register(String username, String password, String email, String phone, String address) async {
    final user = Users(
      username: username,
      password: password,
      email: email,
      phone: phone,
      address: address,
    );

    try {
      print(phone);
      var check = await sendOTP(phone);
      print(check);
      if(check){
        await dbHelper.insertUser(user);
      Get.snackbar('Success', 'Registration successful!');
      Get.to(() => OtpVerification());
      } 
      else{
        print("Failed");
      }
    } catch (e) {
      Get.snackbar('Error', 'Registration failed: $e');
    }
  }

  Future<void> login(String email, String password) async {
    final user = await dbHelper.getUser(email, password);
    if (user != null) {
      isLoggedIn.value = true;
      Get.to(HomePage(),transition: Transition.fadeIn); 
    } else {
      Get.snackbar('Error', 'Invalid username or password!');
    }
  }

  Future<bool> sendOTP(String phoneNumber) async {
    isLoading.value = true;

    try {
      await auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          Get.snackbar('Error', 'Verification failed: ${e.message}');
        },
        codeSent: (String verificationId, int? resendToken) {
          this.verificationId.value = verificationId;
          Get.snackbar('Success', 'OTP sent successfully');
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          this.verificationId.value = verificationId;
        },
        timeout: const Duration(seconds: 60),
      );

      return true;
    } catch (e) {
      Get.snackbar('Error', 'Failed to send OTP: $e');
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> verifyOTP(String otp) async {
    isLoading.value = true;
print("Verification val: ${verificationId.value}\n\n\n");
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId.value,
        smsCode: otp,
      );

      final userCredential = await auth.signInWithCredential(credential);

      if (userCredential.user != null) {
        isLoggedIn.value = true;
        Get.snackbar('Success', 'Phone number verified successfully');
        Get.offAll(() => HomePage());
        return true;
      } else {
        Get.snackbar('Error', 'Verification failed. Please try again.');
        return false;
      }
    } catch (e) {
      Get.snackbar('Error', 'Invalid OTP: $e');
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signInWithCredential(PhoneAuthCredential credential) async {
    try {
      final userCredential = await auth.signInWithCredential(credential);

      if (userCredential.user != null) {
        isLoggedIn.value = true;
        Get.snackbar('Success', 'Phone number verified successfully');
        Get.offAll(() => HomePage());
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to sign in with credentials: $e');
    }
  }
}

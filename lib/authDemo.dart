import 'package:datas/view/Screen/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

final phoneNoController = TextEditingController();

final FirebaseAuth auth = FirebaseAuth.instance;
final TextEditingController _codeController = TextEditingController();

bool isVerifying = false;
bool isOTPSent = false;

class PhoneAuthScreen extends StatefulWidget {
  const PhoneAuthScreen({super.key});

  @override
  _PhoneAuthScreenState createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  String? verificationId;

  @override
  void initState() {
    super.initState();
    phoneNoController.text = "01918037814"; // Replace with dynamic input in production
    _sendVerificationCode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Phone Authentication'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30, bottom: 30),
                child: Center(
                  child: Opacity(
                    opacity: 0.5,
                    child: Image.asset("assets/phone otp.png", height: 250, width: 200),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 25.0),
                child: Center(
                  child: Text("Enter Verification Code", style: TextStyle(fontSize: 25)),
                ),
              ),
              Center(
                child: Text("We've sent a code to your number", style: TextStyle(fontSize: 18)),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text("at ${phoneNoController.text}", style: TextStyle(fontSize: 16)),
              ),
              const SizedBox(height: 20),
              if (isOTPSent) ...[
                TextField(
                  controller: _codeController,
                  decoration: InputDecoration(
                    labelText: 'Enter Code',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 50),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: _signInWithPhoneNumber,
                    child: isVerifying
                        ? CircularProgressIndicator(
                            strokeWidth: 2,
                          )
                        : Text('Verify Code', style: TextStyle(color: Colors.white)),
                  ),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }

  void _sendVerificationCode() async {
    String phoneNumber = phoneNoController.text.trim();
    phoneNumber = "+88$phoneNumber";

    try {
      await auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await auth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          Fluttertoast.showToast(
            msg: 'Verification failed: ${e.message ?? 'Unknown error'}',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
          );
        },
        codeSent: (String verificationId, int? resendToken) {
          setState(() {
            this.verificationId = verificationId;
            isOTPSent = true;
          });
          Fluttertoast.showToast(
            msg: 'Code sent to $phoneNumber',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          setState(() {
            this.verificationId = verificationId;
          });
          Fluttertoast.showToast(
            msg: 'Code auto-retrieval timeout.',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
          );
        },
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Failed to send verification code: $e',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
    }
  }

  void _signInWithPhoneNumber() async {
    if (verificationId == null) {
      Fluttertoast.showToast(
        msg: 'Please request a verification code first.',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
      return;
    }

    String smsCode = _codeController.text.trim();

    if (smsCode.isEmpty) {
      Fluttertoast.showToast(
        msg: 'Please enter the verification code.',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
      return;
    }

    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId!,
      smsCode: smsCode,
    );

    setState(() {
      isVerifying = true;
    });

    try {
      await auth.signInWithCredential(credential);
      setState(() {
        isVerifying = false;
      });
      Fluttertoast.showToast(
        msg: 'Phone number verified successfully!',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
        (Route<dynamic> route) => false,
      );
    } catch (e) {
      setState(() {
        isVerifying = false;
      });
      Fluttertoast.showToast(
        msg: 'Failed to sign in: $e',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
    }
  }
}

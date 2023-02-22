import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthentifService{
  AuthentifService._();
  static AuthentifService? _instance;

  static AuthentifService? get instance {
    if (_instance == null) {
      _instance = AuthentifService._();
    }
    return _instance;
  }

  FirebaseAuth _auth = FirebaseAuth.instance;


  Future<void> verifyPhoneSendOtp(String phone,
      {required void Function(PhoneAuthCredential)? completed,
        required void Function(FirebaseAuthException)? failed,
        required void Function(String, int?)? codeSent,
        required void Function(String)? codeAutoRetrievalTimeout}) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phone,
      verificationCompleted: completed!,
      verificationFailed: failed!,
      codeSent: (String verificationID , int?resendToken){

      },
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout!,
    );
  }

  Future<String?> verifyAndLogin(String verificationId, String smsCode, String phone) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: smsCode);
    final authCredential = await _auth.signInWithCredential(credential);

    if (authCredential.user != null) {
      final uid = authCredential.user!.uid;
      final userSanp = await FirebaseFirestore.instance.collection('users').doc(
          uid).get();
      if (!userSanp.exists) {
        await FirebaseFirestore.instance.collection('users').doc(uid).set({
          'uid': uid,
          'phone': phone,
          'createdAt': DateTime.now(),
          'isVerified': false,
        });
      }
      return uid;
    }
    else {
      return null;
    }

  }


}
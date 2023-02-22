import 'dart:async';

import 'package:control_car/model/user.dart';
import 'package:control_car/repositories/car_repository.dart';
import 'package:control_car/repositories/user_repository.dart';
import 'package:control_car/model/car.dart';
import 'package:control_car/repositories/user_repository.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../services/authentification.dart';

enum PhoneAuthState { initial, success, loading, codeSent, error }

class AuthState extends ChangeNotifier {
  final authService = AuthentifService.instance;
  final userRepo = UserRepository.instance;

  PhoneAuthState _phoneAuthState = PhoneAuthState.initial;

  String verificationId = '';

  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController licensePlateController = TextEditingController();
  TextEditingController vehicleTypeController = TextEditingController();
  TextEditingController vehicleMarqueController = TextEditingController();
  TextEditingController vehicleMatriculeController = TextEditingController();
  TextEditingController vehicleidController = TextEditingController();
  TextEditingController vehicleUnikodeController = TextEditingController();
  Roles role = Roles.driver;

  PageController? controller;
  int pageIndex = 0;
  String uid = '';

  int timeOut = 30;

  bool get isRoleDriver => role == Roles.driver;
  bool get isRoleAdmin => role == Roles.admin;

  AuthState(int page, String uid) {
    this.uid = uid;
    controller = PageController(initialPage: page);
    pageIndex = page;
    notifyListeners();
    siginCurrentUser();
  }

  PhoneAuthState get phoneAuthState => _phoneAuthState;

  set changeRoleState(int value) {
    role = Roles.values[value];
    notifyListeners();
  }

  set phoneAuthStateChange(PhoneAuthState phoneAuthState) {
    _phoneAuthState = phoneAuthState;
    notifyListeners();
  }

  void animateToNextPage(int page) {
    controller!.animateToPage(page,
        duration: Duration(milliseconds: 400), curve: Curves.easeIn);
    pageIndex = page;
    notifyListeners();
  }

  void onPageChanged(int value) {
    pageIndex = value;
    notifyListeners();
  }

  Future<void> CarRegistration() async {
    try {
      final car = Car(
        Matricule: vehicleMatriculeController.text,
        Marque: vehicleMarqueController.text,
        uid: uid,
        Type: vehicleTypeController.text,
        Unikode: int.parse(vehicleUnikodeController.text),
      );
      //await CarRepository()_addToCar(car);
    } on FirebaseException catch (e) {
      print(e.message);
      phoneAuthStateChange = PhoneAuthState.error;
    }
  }

  Future<void> signUp() async {
    phoneAuthStateChange = PhoneAuthState.loading;

    try {
      final user = User(
        uid: uid,
        isActive: true,
        firstname: firstNameController.text,
        lastname: lastNameController.text,
        email: emailController.text,
        createdAt: DateTime.now(),
        isVerified: true,
        licensePlate: licensePlateController.text,
        phone: "228${phoneController.text}",
        role: role,
      );

      await userRepo.setUpAccount(user);

      phoneAuthStateChange = PhoneAuthState.success;
    } on FirebaseException catch (e) {
      print(e.message);
      phoneAuthStateChange = PhoneAuthState.error;
    }
  }

  Future<void> phoneNumberVerification(String phone) async {
    await AuthentifService.instance!.verifyPhoneSendOtp(phone,
        completed: (credential) async {
      if (credential.smsCode != null && credential.verificationId != null) {
        verificationId = credential.verificationId ?? '';
        notifyListeners();
        await verifyAndLogin(credential.verificationId!, credential.smsCode!,
            phoneController.text);
      }
    }, failed: (error) {
      phoneAuthStateChange = PhoneAuthState.error;
    }, codeSent: (String id, int? token) {
      verificationId = id;
      notifyListeners();

      phoneAuthStateChange = PhoneAuthState.codeSent;
      codeSentEvent();
      print('code sent $id');
    }, codeAutoRetrievalTimeout: (id) {
      verificationId = id;
      notifyListeners();

      phoneAuthStateChange = PhoneAuthState.codeSent;
      animateToNextPage(1);
      print('timeout $id');
    });
    animateToNextPage(1);
    notifyListeners();
  }

  Future<void> verifyAndLogin(
      String verificationId, String smsCode, String phone) async {
    phoneAuthStateChange = PhoneAuthState.loading;

    final uid =
        await authService?.verifyAndLogin(verificationId, smsCode, phone);
    await userRepo.getUser(uid);
    this.uid = uid ?? '';
    animateToNextPage(2);
    notifyListeners();
    phoneAuthStateChange = PhoneAuthState.success;
    print('completed');
  }

  Future<void> siginCurrentUser() async {
    await userRepo.signInCurrentUser();
  }

  Future<void> codeSentEvent() async {
    animateToNextPage(1);
    _startCountDown();
  }

  void _startCountDown() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (timer.tick > 30) {
        timer.cancel();
      } else {
        --timeOut;
      }
      notifyListeners();
    });
  }
}

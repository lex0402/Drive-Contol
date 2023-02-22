//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:control_car/repositories/user_repository.dart';
import 'package:control_car/pages/home/Acceuil.dart';
import 'package:control_car/pages/home/Menu.dart';
import 'package:control_car/ui/theme.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';

void main() async {
  await Settings.init(cacheProvider: SharePreferenceCache());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      name: "car_control",
      options: FirebaseOptions(
          apiKey: 'AIzaSyBDruhvsjpwwBIg1PXu3wg6r7iHZPBHfNw',
          appId: '1:101633365815:android:722af18a9f0a009134acb2',
          messagingSenderId: '<senderId>',
          projectId: 'drive-control-c6419'
  ));
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    UserRepository.instance.signInCurrentUser();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Drive control',
      theme: CityTheme.theme,
      home: HomePage(),
    );
  }
}

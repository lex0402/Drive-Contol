
import 'dart:html';

import 'package:control_car/pages/authentication/widget/IconWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';

class AccountPage extends StatelessWidget{
  static const KeyLanguage = 'Key-language' ;
  static const KeyLocation = 'Key-location' ;
  static const KeyPassword = 'Key-password' ;
  @override
  Widget build(BuildContext context) => SimpleSettingsTile(
      title: 'Paramètres de compte',
  subtitle: 'Confidentialité  Sécurité , Langue',
  leading : IconWidget(icon: Icons.person_rounded, color : Colors.green),
  child : SettingsScreen(
    title: 'Account Settings',
    children: <Widget>[
      buildLanguage(),
      buildLocation(),
      buildPassword(),
      buildPrivacy(context),
      buildSecurity(context),
      buildAccountInfo(context),
    ],
  ));

  Widget buildPrivacy(BuildContext context) => SimpleSettingsTile(
      title: 'Confidentialité',
      subtitle: '',
      leading: IconWidget(icon: Icons.lock, color : Colors.blue),
     // onTap: () => showDialog(context : context , builder : (BuildContext context) {
  );


  Widget buildAccountInfo(BuildContext context) => SimpleSettingsTile(
      title: 'Infos du compte',
      subtitle: '',
      leading : IconWidget(icon : Icons.text_snippet , color : Colors.red),
      //onTap: () => SnackBar(content: content)
  )
      ;
  Widget buildSecurity(BuildContext context ) => SimpleSettingsTile(
      title: 'Sécurité',
      subtitle: '',
      leading : IconWidget(icon:  Icons.security, color : Colors.greenAccent));

  Widget buildLanguage() => DropDownSettingsTile(
    settingKey:  KeyLanguage,
    title : 'language',
    selected: 1,
    values:  <int, String>{
      1: 'English',
      2: 'Spanish',
      3: 'Chinese',
      4: 'Hindi',
    },
      onChange : (language) {/* NOOP */},);



  Widget  buildLocation() => TextInputSettingsTile(
    title: 'Location',
    settingKey: KeyLocation,
    initialValue : 'Togo',
    onChange: (location) {/*NOOP*/},
  );

  Widget buildPassword() => TextInputSettingsTile(
      title: 'Mot de Passe',
      settingKey: KeyPassword,
      obscureText : true,
      validator: (password) => password != null && password.length >= 6
      ? null
      : 'Entrez  6 caractères',);

}


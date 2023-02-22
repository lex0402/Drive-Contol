import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:control_car/pages/Settings/ItemCard.dart';

import '../../ui/theme.dart';
import 'ItemCard.dart';

class SettingsPage extends StatelessWidget {

  Widget _arrow() {
    return Icon(
      Icons.arrow_forward_ios,
      size: 20.0,
      color: CityTheme.cityblue,
    );
  }

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    return Scaffold(
      appBar: AppBar(
        backgroundColor : Colors.white ,
        title: Text(
          'Settings',
          style: TextStyle(
              fontWeight: FontWeight.bold,
            color : CityTheme.cityblue,
          ),
        ),
      ),
      body: Container(
        color: (brightness == Brightness.light) ? Color(0xFFF7F7F7) : Color(0xFF000000),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Container(
                color: (brightness == Brightness.light) ? Color(0xFFF7F7F7) : Color(0xFF000000),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 16),
                      child: Text(
                        'Paramètres de l'+ 'application',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF999999)),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ItemCard(
                      title: 'Langue',
                      color: (brightness == Brightness.light) ? Colors.white : Theme.of(context).scaffoldBackgroundColor,
                      rightWidget: _arrow(),
                      callback: () {
                        print('Tap Settings Item 01');
                      }, textColor: Colors.black54,
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 16),
                      child: Text(
                        'Parametres de compte',
                        style: TextStyle(
                            fontFamily: 'NotoSansJP',
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF999999)),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ItemCard(
                      title: 'Modifier un compte',
                      color: (brightness == Brightness.light) ? Colors.white : Theme.of(context).scaffoldBackgroundColor,
                      rightWidget: _arrow(),
                      callback: () {
                        print('Tap Settings Item 02');
                      }, textColor: Colors.black54,
                    ),
                    /*ItemCard(
                      title: 'Se déconnecter',
                      color: (brightness == Brightness.light) ? Colors.white : Theme.of(context).scaffoldBackgroundColor,
                      rightWidget: _arrow(),
                      callback: () {
                        print('Tap Settings Item 03');
                      }, textColor: Colors.black54,
                    ),
                    ItemCard(
                      title: 'Confidentialité ',
                      color: (brightness == Brightness.light) ? Colors.white : Theme.of(context).scaffoldBackgroundColor,
                      rightWidget: _arrow(),
                      callback: () {
                        print('Tap Settings Item 04');
                      },textColor: Colors.black54,
                    ),
                    ItemCard(
                      title: 'Settings Item 05',
                      color: (brightness == Brightness.light) ? Colors.white : Theme.of(context).scaffoldBackgroundColor,
                      rightWidget: null,
                      callback: () {
                        print('Tap Settings Item 05');
                      }, textColor: Colors.black54,
                    ),
                    ItemCard(
                      title: 'Settings Item 06',
                      color: (brightness == Brightness.light) ? Colors.white : Theme.of(context).scaffoldBackgroundColor,
                      rightWidget: null,
                      callback: () {
                        print('Tap Settings Item 06');
                      }, textColor: Colors.black54,
                    ),
                    ItemCard(
                      title: 'Settings Item 07',
                      color: (brightness == Brightness.light) ? Colors.white : Theme.of(context).scaffoldBackgroundColor,
                      rightWidget: null,
                      callback: () {
                        print('Tap Settings Item 07');
                      }, textColor: Colors.black54,
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    ItemCard(
                      title: 'Settings Item 08',
                      color: (brightness == Brightness.light) ? Colors.white : Theme.of(context).scaffoldBackgroundColor,
                      rightWidget: null,
                      callback: () {
                        print('Tap Settings Item 08');
                      },textColor: Colors.black54,
                    ),*/
                    ItemCard(
                      title: 'Se déconnecter',
                      color: (brightness == Brightness.light) ? Colors.white  : Theme.of(context).scaffoldBackgroundColor,
                      callback: () {
                        FirebaseAuth.instance.currentUser?.delete();
                      },
                      textColor: Colors.red, rightWidget: null,
                    ),
                    ItemCard(
                      title: 'ZHETROF PRODUCT',
                      color: (brightness == Brightness.light) ? Colors.white  : Theme.of(context).scaffoldBackgroundColor,
                      rightWidget: Center(
                        child: Text(' Version 1.0.0',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                            )
                        ),
                      ),
                      callback: () {}, textColor: Colors.black54,
                    ),
                    SizedBox(
                      height: 200,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
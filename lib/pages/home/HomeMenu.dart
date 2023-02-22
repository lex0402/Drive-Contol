import 'package:control_car/pages/CarDirectory/carView.dart';
import 'package:control_car/pages/home/Menu.dart';
import 'package:flutter/material.dart';

import '../../utils/images_assets.dart';
import '../Location/LocationPage.dart';
import '../Settings/SettingsPage.dart';

class HomeMenu extends StatefulWidget {

  @override
  State<HomeMenu > createState() => HomeMenuScreen() ;
}

class HomeMenuScreen extends State<HomeMenu >  {
  final PageController _pageController = PageController(initialPage: 0);
  int selected = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(ImagesAsset.Background),
              fit: BoxFit.cover)),
      child: GridView.count(
        primary: false,
        padding: const EdgeInsets.only(left: 50 , top: 200, right: 50 , bottom: 10),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 2,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.red,
            child:IconButton(
              icon: Icon(Icons.garage),
              iconSize: 90,
              color: Colors.white,
              tooltip: 'Garage',
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => MenuScreen()));
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.teal[100],
            child: IconButton(
              icon: Icon(Icons.settings),
              iconSize: 90,
              color: Colors.white,
              tooltip: 'Parametres',
              onPressed: () {
                Navigator.push(context,MaterialPageRoute(builder: (context) => SettingsPage()));
              },
            ),
          ),
          /*Container(
            padding: const EdgeInsets.all(8),
            color: Colors.red,
            child: IconButton(
              icon: Icon(Icons.fmd_good),
              iconSize: 90,
              color: Colors.white,
              tooltip: 'Increase volume by 5',
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => LocationPage()));
              },
            ),
          ),*/


        ],
      ),
    );

  }
}
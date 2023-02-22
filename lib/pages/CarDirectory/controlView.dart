import 'package:control_button/control_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:control_car/pages/CarDirectory/chatpage.dart';

import '../../ui/theme.dart';
import '../../ui/widgets/SidebarMenu.dart';
import '../../utils/images_assets.dart';
import 'Connexion.dart';

class Controlhome extends StatelessWidget{
  const Controlhome({Key ?  key}) : super(key : key);
  @override
    Widget build(BuildContext context) {
      return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor : Colors.white ,
              leading:  IconButton(
                icon: Icon(Icons.menu_rounded , color : CityTheme.cityblue),
                tooltip: 'Navigation menu',
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => NavBar()));

                },
              ),
              title: const Text('DRIVE  CONTROL ', style: TextStyle(color : CityTheme.cityblue, fontSize: 25.0 , fontFamily: 'Hind'   )),
              actions: const [
              ],
            ),
            body: Container(
            padding: const EdgeInsets.only(right: 9),
    decoration: BoxDecoration(
    image: DecorationImage(
    image: AssetImage(ImagesAsset.Background),
    fit: BoxFit.cover)),
    child:
            SelectBondedDevicePage(
              onCahtPage: (device1) {
                BluetoothDevice device = device1;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return ChatPage(server: device);
                    },
                  ),
                );
              },
            ),
          )),);
    }

}

//SelectBondeddevicePage({required Null Function(dynamic device1) onCahtPage}) {
//


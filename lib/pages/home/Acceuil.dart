import 'package:control_car/model/user.dart';
import 'package:control_car/pages/authentication/authentication_page.dart';
import 'package:control_car/ui/theme.dart';
import 'package:control_car/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:control_car/pages/home/Menu.dart';
import 'package:control_car/pages/home/HomeMenu.dart';

import '../../ui/widgets/SidebarMenu.dart';
import '../../utils/images_assets.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({required this.title, super.key});

  // Fields in a Widget subclass are always marked "final".

  final Widget title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56.0, // in logical pixels
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(color: Colors.lightGreenAccent[500]),
      // Row is a horizontal, linear layout.
      child: Row(
        children: [
          Image.asset(ImagesAsset.DcIcon),/*IconButton(
            icon: Icon(Icons.menu),
            tooltip: 'Navigation menu',
            onPressed: null, // null disables the button
          ),*/
          // Expanded expands its child
          // to fill the available space.
          Expanded(
            child: title,
          ),
          const IconButton(
            icon: Icon(Icons.search),
            tooltip: 'Search',
            onPressed: null,
          ),
        ],
      ),
    );
  }
}


class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor : Colors.white ,
        leading: // Image.asset(ImagesAsset.DcIcon),
        IconButton(
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

        //color: Colors.grey[200],
        child: ValueListenableBuilder<User?>(
          valueListenable: UserRepository.instance.userNotifier,
          builder: (context, value, child) {
            if (value != null) {
              return Builder(
                builder: (context) {
                  if (value.isVerified) {
                    return  HomeMenu();
                  } else {
                    return AuthPageWidget(page: 2, uid: value.uid);
                  }
                },
              );
            } else {
              return AuthPageWidget(page: 0);
            }
          },
        ),
      ),
    );
  }
}
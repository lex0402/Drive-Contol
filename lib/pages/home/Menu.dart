import 'package:flutter/material.dart';
import 'package:control_car/pages/authentication/widget/auth_button.dart';
import 'package:control_car/utils/icons_assets.dart';
import 'package:control_car/ui/theme.dart';
import 'package:control_car/pages/CarDirectory/carView.dart';
import 'package:control_car/pages/CarDirectory/controlView.dart';
class MenuScreen extends StatefulWidget {

  @override
  State<MenuScreen > createState() => MenuPage() ;
}

class MenuPage extends State<MenuScreen >  {
  final PageController _pageController = PageController(initialPage: 0);
  int selected = 0;



  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(

      //backgroundColor: Colo rs.white,
      body: PageView(
        onPageChanged : (index) {
          setState(() {
            selected = index;
          });
        },
        controller: _pageController,
        children:  <Widget>[
          ListCarView() ,
          Controlhome(),
        ],
      ),


      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selected,
        onTap: (index) {
          setState(() {
            selected = index;
          });
          _pageController.jumpToPage(selected);
        },

        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.garage_sharp, color: Colors.red, size : 40),
              label: 'Garage',),
          BottomNavigationBarItem(icon: Icon(Icons.gamepad_rounded, color: CityTheme.cityblue, size : 40),
            label: 'Conduire',),

        ]
          

      )
    );
  }
  
}

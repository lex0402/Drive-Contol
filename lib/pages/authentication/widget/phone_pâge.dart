import 'package:control_car/ui/widgets/textfields/phone_textfeild.dart';
import 'package:control_car/pages/authentication/authentication_state.dart';
import 'package:control_car/utils/images_assets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:control_car/ui/theme.dart';
import 'package:control_car/utils/images_assets.dart';

class PhonePage extends StatelessWidget {
  const PhonePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<AuthState>(context);
    appBar: AppBar(
      backgroundColor : Colors.white ,

      title: const Text('Drive'+"'" +' s control', style: TextStyle(color : CityTheme.cityblue, fontSize: 25.0 , fontFamily: 'Hind'   )),
      actions: const [
        IconButton(
          icon: Icon(Icons.search),
          tooltip: 'Search',
          onPressed: null,
        ),
      ],
    );
    return Container(
      //color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                decoration:
                BoxDecoration(image: DecorationImage(
                    image: AssetImage(ImagesAsset.connect), fit: BoxFit.cover)),
              ),
            ),
            Container(

              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  PhoneTextField(numnberController: state.phoneController),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
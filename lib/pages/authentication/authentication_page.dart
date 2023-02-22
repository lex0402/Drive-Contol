import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:control_car/pages/authentication/widget/otp_page.dart';
import 'package:control_car/pages/authentication/widget/phone_pâge.dart';
import 'package:control_car/pages/authentication/widget/set_up_account.dart';
import 'package:control_car/pages/authentication/authentication_state.dart';
import 'package:control_car/pages/authentication/widget/auth_button.dart';
import 'package:control_car/utils/images_assets.dart';

class AuthPage extends StatefulWidget {
  final int page;
  final String? uid;
  const AuthPage({
    Key? key,
    this.page = 0,
    this.uid,
  }) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    final state = Provider.of<AuthState>(context);
    final screenSize = MediaQuery.of(context).size;
    return Builder(builder: (context) {
      return Stack(
        children: [
          Container(
            decoration :BoxDecoration(image : DecorationImage(
                image: AssetImage(ImagesAsset.Background), fit: BoxFit.cover)),

            height: screenSize.height,
            width: screenSize.width,
            //color: Colors.white,
            child: PageView(
              controller: state.controller,
              onPageChanged: state.onPageChanged,
              physics: NeverScrollableScrollPhysics(),
              children: const [
                PhonePage(),
                OtpPage(),
                SetUpAccount(),
              ],
            ),
          ),
          const AuthButton(),
        ],
      );
    });
  }
}

class AuthPageWidget extends StatelessWidget {
  final int page;
  final String? uid;

  const AuthPageWidget({
    Key? key,
    required this.page,
    this.uid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = AuthState(page, uid ?? '');
    return ChangeNotifierProvider(
      create: (_) => state,
      child: ChangeNotifierProvider.value(
        value: state,
        child: AuthPage(page: page, uid: uid),
      ),
    );
  }
}
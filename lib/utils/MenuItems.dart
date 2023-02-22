import 'package:control_car/utils/MenuItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:control_car/pages/CarDirectory/carView.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:telephony/telephony.dart';
final Uri number1 = Uri.parse('+22893372335');
final Uri _url = Uri.parse('+22893482537');
const String text1 = 'localisation ';
final Telephony telephony = Telephony.instance;

class MenuItems {

  static final List<MenuItemr> itemfirst = [
    itemtext1,
    //itemtext2,
  ];
  static final itemtext1 = MenuItemr(text: text1, IconButton: IconButton(onPressed:() async {telephony.sendSms(to : '+22879644116', message: '777');} , icon: Icon(Icons.fmd_good_outlined , color: Colors.red,)), onPressed: () async {telephony.sendSms(to : '+22879644116', message: '777');});
  //static final itemtext2 = MenuItemr(text: 'Modifer',  IconButton: IconButton(onPressed: ()async {await FlutterPhoneDirectCaller.callNumber(number2);}, icon: Icon(Icons.edit , color: Colors.blue, )), onPressed: () =>  null);

}

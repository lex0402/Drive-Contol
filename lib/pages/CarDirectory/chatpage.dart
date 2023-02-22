import 'dart:convert';
import 'dart:typed_data';
import 'package:control_pad/models/pad_button_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:control_button/control_button.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:control_pad/control_pad.dart';
import '../../ui/theme.dart';
import '../../utils/images_assets.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ChatPage extends StatefulWidget{
  final BluetoothDevice server ;

  const ChatPage({ required this.server});

  @override
  _ChatPage  createState() => new _ChatPage();

}

class _Message {
  int whom ;
  String text ;

  _Message(this.whom , this.text);
}

class _ChatPage extends State<ChatPage> {
  static final clientId = 0;

  BluetoothConnection? connection ;
  late int _deviceState;
  List <_Message> messages = <_Message>[];
  String _messageBuffer = '';
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final TextEditingController textEditingController = new TextEditingController();

  final ScrollController listScrollController = new ScrollController();

  bool isConnecting = true;

  bool get isConnected => connection != null && connection!.isConnected;

  bool isDisconnecting = false;





  @override
  void initState() {
    super.initState();
    _deviceState = 0;
    BluetoothConnection.toAddress(widget.server.address).then((_connection){
      print('Connected to the device');
      connection = _connection;

      setState(() {
        isConnecting = false;
        isDisconnecting = false;
      });

      connection?.input?.listen(_onDataReceived).onDone(() {
        if (isDisconnecting) {
          print('Disconnecting locally !');
        } else {
          print('Disconnected remotely !');
        }

        if (this.mounted) {
          setState(() {});
        }
      });
      }).catchError((error) {
        print('Cannot connect , exception occured');
        print(error);
      });
    }

    @override
    Widget build(BuildContext context) {
      final List<Row> list = messages.map((_message) {
        return Row(
          children: <Widget>[
            Container(
              child: Text(
                      (text) {
                    return text == '/shrug' ? '\\_(``/)_/-1' : text;
                  }(_message.text.trim()),
                  style: TextStyle(color: Colors.white)),
              padding:  EdgeInsets.all(12.0),
              margin: EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
              width: 222.0,
              decoration: BoxDecoration(
                  color:
                  _message.whom == clientId ? Colors.greenAccent : Colors.cyan,
                  borderRadius: BorderRadius.circular(7.0)),
            ),
          ],
          mainAxisAlignment: _message.whom == clientId
              ?MainAxisAlignment.end :
          MainAxisAlignment.start,
        );


      }).toList();

      return Scaffold(
        appBar: AppBar(
            backgroundColor : CityTheme.cityblue,
            title: (isConnecting
                ? Text('connexion à la voiture ' +   'BENZ')
                : isConnected
                ? Text('CAD de : ' +'Benz' )
                : Text('CAD de : ' + 'Benz'))),
          body: Container(
          padding: const EdgeInsets.only(right: 9),
      decoration: BoxDecoration(
      image: DecorationImage(
      image: AssetImage(ImagesAsset.Background),
      fit: BoxFit.cover)),
      child:SafeArea(
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 100,),
             /* ControlButton(
                sectionOffset: FixedAngles.Zero,
                externalDiameter: 300,
                internalDiameter: 120,
                dividerColor: Colors.limeAccent,
                elevation: 2,
                externalColor: CityTheme.cityblue,
                internalColor: Colors.green[300],
                mainAction: () => _sendMessage('W'),
               sections: [
                      () => _sendMessage('b'),
                      () => _sendMessage('a'),
                      () => _sendMessage('d'),
                      () => _sendMessage('b'),
                      () => _sendMessage('i'),
                      () => _sendMessage('b'),

                ],
              ),*/
              //JoystickView(),
              PadButtonsView(
                 buttons: const [PadButtonItem(index: 0, buttonText: "Right"), PadButtonItem(index: 1, buttonText: "down", pressedColor: Colors.red), PadButtonItem(index: 2, buttonText: "Left", pressedColor: Colors.green),  PadButtonItem(index: 3, buttonText: "Up", pressedColor: Colors.yellow),],
                  padButtonPressedCallback : ( index , Gestures){
                    if(index == 1){
                      _sendMessage('i');
                    }
                    if (index == 3) {
                      _sendMessage('a');
                    }

                    if (index == 0){
                      _sendMessage('b');
                      _sendMessage('a');
                    }

                    if (index == 2) {
                      _sendMessage('d');
                    }
                    /*if (index == 0) {
                      _sendMessage('b');
                    }*/
                  }
              ),
             /* Flexible(child: ListView(
                  padding: const EdgeInsets.all(12.0),
                  controller : listScrollController,
                  children : list),
              ),*/
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
              Container(
                padding: const EdgeInsets.all(12),
                child: ElevatedButton(onPressed:() { _sendMessage('w') ; dispose();}, child: const Text('OFF') , style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red), ),),
              ),
              Container(
                padding: const EdgeInsets.all(12),
                child: ElevatedButton(onPressed:() { _sendMessage('W') ;}, child: const Text('ON') , style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green), ),),
              ),

              /*Row(
                children: <Widget>[
                  Flexible(
                    child: Container(
                      margin: const EdgeInsets.only(left: 16.0),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(ImagesAsset.Background),
                              fit: BoxFit.cover)),
                  child: ElevatedButton(onPressed:() { _sendMessage('W') ; }, child: const Text('ON') , style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green), ),),
                      /*child: TextField(
                        style: const TextStyle(fontSize: 15.0),
                        controller: textEditingController,
                        decoration: InputDecoration.collapsed(hintText: isConnecting ?
                        'en train de se connecter...' : isConnected ? 'Entrez votre messsage'
                            :'Chat got disconnected',
                          hintStyle: const TextStyle(color: Colors.grey),),
                        enabled: isConnected,
                      ),*/
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(8.0),
                    child:  ElevatedButton(onPressed:() { _sendMessage('w') ; dispose();}, child: const Text('OFF') , style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red), ),),
                    /*child: IconButton(
                      icon : const Icon (Icons.send),
                      onPressed: isConnected ?() =>_sendMessage(textEditingController.text) : null,),*/
                  ),
                ], )
            ],
          ),
        ),),);*/],),

      ]),),),);}


  @override
    void dispose(){
    //  Avoid memory leak ('setState' after dispose ) and disconnect
    if (isConnected ){
      isDisconnecting = true;
      connection?.dispose();
      Fluttertoast.showToast(
          msg: "Système déconnecté !",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Colors.black54,
          fontSize: 16.0
      );
     // connection = null;
    }

    super.dispose();
  }

     double _value = 90.0;




   void _onDataReceived(Uint8List data) {
      int backspacesCounter = 0;
      data.forEach((byte) {
        if (byte == 8 || byte == 127) {
          backspacesCounter++;
        }
      });
      Uint8List buffer = Uint8List(data.length - backspacesCounter);
      int bufferIndex = buffer.length;

      // Apply backspace control character
      backspacesCounter = 0;
      for (int i = data.length - 1; i >= 0; i--) {
        if (data[i] == 8 || data[i] == 127) {
          backspacesCounter--;
        } else {
          buffer[--bufferIndex] = data[i];
        }
      }

      //Create message if there is new line character
      String dataString = String.fromCharCode(bufferIndex);
      int index = buffer.indexOf(13);

      if (~index != 0) {
        setState(() {
          messages.add(_Message(1,
            backspacesCounter > 0 ? _messageBuffer.substring(
                0, _messageBuffer.length - backspacesCounter) : dataString.substring(0, index),),);
          _messageBuffer = dataString.substring(index);
        });
      } else {
        _messageBuffer = (backspacesCounter > 0) ? _messageBuffer.substring(
            0, _messageBuffer.length - backspacesCounter)
            : _messageBuffer.substring(
            0, _messageBuffer.length - backspacesCounter);_messageBuffer
      +
      dataString;
    }

    }
  void _sendMessage(String text) async {
    text = text.trim();
    textEditingController.clear();

    if(text.length>0){
      try {
        connection?.output.add(Uint8List.fromList((utf8.encode(text + "\r\n"))));
        await connection?.output.allSent ;
        setState(()  {
          messages.add(_Message(clientId , text));
         // _deviceState = -1;

        });
        Future.delayed(Duration(milliseconds: 333)).then((_) {
          listScrollController.animateTo(
              listScrollController.position.maxScrollExtent ,
              duration : Duration(milliseconds: 333),
              curve : Curves.easeOut);
              //connection?.dispose();
        });
      } catch(e){
        //Ignore error , but notify state
        setState(() {});
      }


      Future show(
          String message, {
            Duration duration: const Duration(seconds: 3),
          }) async {
        await new Future.delayed(new Duration(milliseconds: 100));
        _scaffoldKey.currentState?.showSnackBar(
          new SnackBar(
            content: new Text(
              message,
            ),
            duration: duration,
          ),
        );
      }




    }


    }

}



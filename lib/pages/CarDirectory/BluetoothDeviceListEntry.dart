import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

import '../../ui/theme.dart';

class BluetoothDeviceListEntry extends StatelessWidget {
  GestureTapCallback? onTap;
  final BluetoothDevice device;

  BluetoothDeviceListEntry({this.onTap, required this.device});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(Icons.devices),
      title: Text(device.name ?? "Unknown device"),
      subtitle: Text(device.address.toString()),
      trailing: FlatButton(
        child: const Text('Connect' , style: TextStyle(color : Colors.white)),
        onPressed: onTap,
        color: CityTheme.cityblue,
      ),
    );
  }
}





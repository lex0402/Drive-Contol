import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:control_car/utils/constants.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class LocationPage extends StatefulWidget{
  const LocationPage({Key? key}) : super(key :key );

  @override
  State<LocationPage> createState() => LocationPageState() ;

}

class LocationPageState extends State<LocationPage> {

  final Completer<GoogleMapController> _controller = Completer();

  static const LatLng sourceLocation = LatLng(37.335000926, -122.0327221888);
  static const LatLng destination = LatLng(37.334 , -122.06600055);

  List<LatLng> polyLineCoordinates = [];



  void getPolyPoints() async {
   PolylinePoints polylinePoints = PolylinePoints();

   PolylineResult result  = await polylinePoints.getRouteBetweenCoordinates(
     google_api_key,
     PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
     PointLatLng(destination.latitude , destination.longitude),
   );

   if (result.points.isNotEmpty) {
     result.points.forEach( (PointLatLng point ) => polyLineCoordinates.add(LatLng(point.latitude, point.longitude)),);
   };
  }
  //setState(() {});
  @override
  void initState(){
    getPolyPoints();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
            target: sourceLocation ,
            zoom : 14.5),
      polylines: {
          Polyline(polylineId: PolylineId("route"),
          points: polyLineCoordinates,
          color : primaryColor,
          width: 6,)
      },
      markers: {
          const Marker(
            markerId: MarkerId("source"),
            position:  sourceLocation

          ),
        const Marker(
            markerId: MarkerId("destination"),
            position:  destination

        )
      },
      ),
    );
  }

}
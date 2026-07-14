import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RestaurantGoogleMap extends StatefulWidget {
  const RestaurantGoogleMap({super.key});

  @override
  State<RestaurantGoogleMap> createState() => _RestaurantGoogleMapState();
}

class _RestaurantGoogleMapState extends State<RestaurantGoogleMap> {

  late GoogleMapController mapController;
  Set<Marker> markers = {};
  final ref = FirebaseDatabase.instance.ref("Restaurant-Location");                                   

  Future<void> fethMarkers()async{
    ref.onValue.listen((event){
      Map<dynamic,dynamic>? values = event.snapshot.value as Map<dynamic,dynamic>?;
      values!.forEach((key, value) {
        double? lat = values['lat'] as double?;
        double? lng = values['lng'] as double?;
        if(lat != null && lng !=null){
          Marker marker = Marker(
          markerId: MarkerId(key),
          position: LatLng(lat, lng),
          );
          setState(() {
           markers.add(marker);
          });
        } 
      });
    });
  }
  // ignore: prefer_typing_uninitialized_variables
  var lat,lng;
  Future<void> getUserLocation() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    lat = sharedPreferences.getDouble('lat');
    lng = sharedPreferences.getDouble('lng');
    setState(() {
      
    });
  }
  @override
  void initState() {
    getUserLocation();
    fethMarkers();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      onMapCreated: (GoogleMapController controller) {
        mapController = controller;
      },
      initialCameraPosition: CameraPosition(
        target: (lat==null || lng ==null) ? const LatLng(23.8042375, 90.3525979):LatLng(lat, lng),
        zoom: 15,
      ),
      markers:{
        Marker(
          markerId: const MarkerId('User Location'),
          position: (lat==null || lng ==null) ? const LatLng(23.8042375, 90.3525979):LatLng(lat, lng),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose),
        ),
        const Marker(
          markerId: MarkerId('Restaurant 1'),
          position: LatLng(23.80254, 90.3507039),
        ),
        const Marker(
          markerId: MarkerId('Restaurant 2'),
          position: LatLng(23.8027351, 90.3527994),
        ),
        const Marker(
          markerId: MarkerId('Restaurant 3'),
          position: LatLng(23.8034415, 90.3522394),
        ),
        const Marker(
          markerId: MarkerId('Restaurant 4'),
          position: LatLng(23.8037471, 90.356309),
        ),
      }
    );
  }
}
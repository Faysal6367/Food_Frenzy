import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyGoogleMap extends StatefulWidget {

  final double zoom;
  const MyGoogleMap({super.key, required this.zoom});

  @override
  State<MyGoogleMap> createState() => _MyGoogleMapState();
}

class _MyGoogleMapState extends State<MyGoogleMap> {

  late double latitude=0.0;
  late double longitude=0.0;

  Future<void> fetchLocation()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    latitude = sharedPreferences.getDouble('lat')!;
    longitude = sharedPreferences.getDouble('lng')!;
    setState(() {
      
    });
  }
 @override
  void initState() {
    fetchLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (latitude == 0.0 && longitude==0)? Container(
      color: Colors.transparent,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    ) : GoogleMap(
      initialCameraPosition: CameraPosition(
        target: LatLng(latitude,longitude),
        zoom: widget.zoom,
      ),
      markers: {
         Marker(
          markerId: const MarkerId('User Location'),
          position: LatLng(latitude,longitude),
        ),
      },
    );
  }
}
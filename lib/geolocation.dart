import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/retry.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  String myPosition = '';
  Future<Position>? position;
  @override
  void initState() {
    super.initState();

    getPosition().then((Position myPos) {
      myPosition =
          'Latitude: ${myPos.latitude.toString()} - Longitude: ${myPos.longitude.toString()}';
      setState(() {
        myPosition = myPosition;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Location Screen')),
        body: Center(
          child: FutureBuilder(
            future: position,
            builder: (BuildContext context, AsyncSnapshot<Position> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return const Text('Something terrible happened!');
                }
                return Text(snapshot.data.toString());
              } else {
                return const Text('');
              }
            },
          ),
        ));
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(title: const Text('Current Location Yuma Rakha')),
  //     body: Center(
  //       child: FutureBuilder<Position>(
  //         future: getPosition(), // Pastikan Future dijalankan di sini.
  //         builder: (BuildContext context, AsyncSnapshot<Position> snapshot) { // AsyncSnapshot digunakan.
  //           if (snapshot.connectionState == ConnectionState.waiting) {
  //             return const CircularProgressIndicator();
  //           } else if (snapshot.connectionState == ConnectionState.done) {
  //             if (snapshot.hasError) {
  //               return const Text('Something terrible happened');
  //             }
  //             if (snapshot.hasData) {
  //               return Text(
  //                 'Latitude: ${snapshot.data!.latitude}, Longitude: ${snapshot.data!.longitude}',
  //               );
  //             } else {
  //               return const Text('No data available');
  //             }
  //           } else {
  //             return const Text(' ');
  //           }
  //         },
  //       ),
  //     ),
  //   );
  // }

  Future<Position> getPosition() async {
    await Geolocator.isLocationServiceEnabled();
    await Future.delayed(const Duration(seconds: 3));
    Position position = await Geolocator.getCurrentPosition();
    return position;
  }
}

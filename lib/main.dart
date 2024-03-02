import 'dart:io';

import 'package:flutter/material.dart';
import 'package:travel_app_client/path.dart';
import 'package:travel_app_client/route.dart';
import 'package:travel_app_client/search.dart';
import 'package:travel_app_client/trains.dart';

import 'flights.dart';


class DevHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

void main() {

  HttpOverrides.global = DevHttpOverrides();


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Travel App',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlueAccent),
        useMaterial3: true,
      ),
      // home: const Flights(),
      // home: RoutePage(),
      // home: FlightInfoScreen(),
      home: const Flights(),
      // home: FlightCoordinates(),
      // home: TrainCoordinates(),
      // home: GetDistance(),
      // home: GetTrains(),
      // home: PathOutput(),
      // home: const Search(),
      // home: PathOutput(),
    );
  }
}



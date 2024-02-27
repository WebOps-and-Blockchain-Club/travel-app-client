import 'dart:convert';
// import 'dart:html';

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
// import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;


// class DevHttpOverrides extends HttpOverrides {
//   @override
//   HttpClient createHttpClient(SecurityContext? context) {
//     return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
//   }
// }
// void main() {
//   // HttpOverrides.global = new MyHttpOverrides();
//
//   HttpOverrides.global = DevHttpOverrides();
//
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Search Coordinates'),
//           centerTitle: true,
//         ),
//         body: const Page(),
//       ),
//     );
//   }
// }

class RoutePage extends StatefulWidget {
  const RoutePage({super.key});

  @override
  State<RoutePage> createState() => _RoutePageState();
}

class _RoutePageState extends State<RoutePage> {

  final TextEditingController _placeController1 = TextEditingController();
  final TextEditingController _placeController2 = TextEditingController();
  String startCoordinates = '';
  String endCoordinates = '';
  var route;

  void getCoordinates(String place, String point) async {
    try {
      final response = await http.get(
        Uri.parse('https://nominatim.openstreetmap.org/search?format=json&q=${Uri.encodeComponent(place)}'),
        headers: {
          'User-Agent': 'ID of your APP/service/website/etc. v0.1',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data.length > 0) {
          final result = data[0];
          setState(() {
            if (point == "start_coordinates"){
              startCoordinates = '${result['lat']}, ${result['lon']}';
            }
            else{
              endCoordinates = '${result['lat']}, ${result['lon']}';
            }
          });
        } else {
          throw Exception('No coordinates found for $place');
        }
      } else {
        throw Exception('Failed to load coordinates');
      }
    } catch (e) {
      setState(() {
        if (point == "start_coordinates"){
          startCoordinates = 'Error: $e';
        }
        else{
          endCoordinates = 'Error: $e';
        }
      });
    }
  }

  void getRoute() async {

    // HttpOverrides.global = new myhttpoverrides();

    var queryParameters = {
      'profile': 'car',
      'point': startCoordinates,
      'point_hint': endCoordinates,
      'snap_prevention': 'string',
      'curbside': 'any',
      'locale': 'en',
      'elevation': 'false',
      // 'details': 'string',
      'optimize': 'false',
      'instructions': 'true',
      'calc_points': 'true',
      'debug': 'false',
      'points_encoded': 'false',
      'ch.disable': 'true',
      'heading': '0',
      'heading_penalty': '120',
      'pass_through': 'false',
      'algorithm': 'round_trip',
      'round_trip.distance': '10000',
      'round_trip.seed': '0',
      'alternative_route.max_paths': '2',
      'alternative_route.max_weight_factor': '1.4',
      'alternative_route.max_share_factor': '0.6',
      'key': '0073ec20-da85-4236-a616-afc96ca1f037'
    };

    var uri = Uri.https(
        'graphhopper.com', '/api/1/route', queryParameters
    );

    var response = await http.get(uri);

    if (response.statusCode == HttpStatus.ok) {

      var data = json.decode(response.body);

      setState(() {
        route = data["paths"][0]["points"]["coordinates"];
      });
      // var data = response.body;

      print(data["paths"][0]["points"]["coordinates"]);
      print(data["paths"][0]);
      // return data;
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("GetRoute"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextField(
                  controller: _placeController1,
                  decoration: const InputDecoration(labelText: 'Enter start location'),
                ),
                ElevatedButton(
                  onPressed: () {
                    getCoordinates(_placeController1.text,"start_coordinates");
                    // getCoordinates(_placeController2.text);
                  },
                  child: const Text('Get Coordinates'),
                ),
                Text('Coordinates: $startCoordinates'),


                TextField(
                  controller: _placeController2,
                  decoration: const InputDecoration(labelText: 'Enter end location'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // getCoordinates(_placeController1.text);
                    getCoordinates(_placeController2.text, "end_coordinates");
                  },
                  child: const Text('Get Coordinates'),
                ),
                const SizedBox(height: 20),
                Text('Coordinates: $endCoordinates'),
                const SizedBox(height: 30),
                Center(
                  child: ElevatedButton(
                    onPressed: () { getRoute(); },
                    child: const Text(
                        "Get route Coordinates"
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Text("Route Coordinates: $route")
              ],
            ),
          ),
        ],
      ),
    );
  }
}











class FlightCoordinates extends StatefulWidget {
  const FlightCoordinates({super.key});

  @override
  _FlightCoordinatesState createState() => _FlightCoordinatesState();
}

class _FlightCoordinatesState extends State<FlightCoordinates> {
  final TextEditingController airportController = TextEditingController();
  // final TextEditingController _destinationController = TextEditingController();
  Map _flightInfo = {"lat": 0, "lng": 0};

  Future<void> _getFlightData() async {
    final String airport = airportController.text;
    // final String destination = _destinationController.text;
    const String apiKey = '0509bbc2-21b1-4fd9-8d18-393015d21bf7'; // Replace with your AviationStack API key

    if (airport.isEmpty || apiKey == 'YOUR_AVSTACK_API_KEY') {
      // Show an error message if origin, destination, or API key is not provided
      setState(() {
        _flightInfo = {};
      });
      return;
    }

    final String apiUrl =
        'https://airlabs.co/api/v9/airports?iata_code=$airport&api_key=$apiKey';

    try {
      final http.Response response = await http.get(Uri.parse(apiUrl));

      final data = json.decode(response.body);

      print(data["response"][0]["lat"]);

      if (response.statusCode == 200) {
        // Parse the response and update the UI
        final dynamic data = json.decode(response.body);
        setState(() {
          _flightInfo["lat"] = data["response"][0]["lat"];
          _flightInfo["lng"] = data["response"][0]["lng"];
        });
      } else {
        // Show an error message if the API request fails
        setState(() {
          _flightInfo = {};
        });
      }
    } catch (e) {
      // Handle any exceptions that may occur
      setState(() {
        _flightInfo = {};
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flight Info App'),
      ),
      body: ListView(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: airportController,
            decoration: InputDecoration(labelText: 'Airport'),
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: _getFlightData,
            child: Text('Get Flight Data'),
          ),
          SizedBox(height: 16.0),
          Text(
              "lat: ${_flightInfo["lat"]}, lng: ${_flightInfo["lng"]}"
          ),
        ],
      ),
    );
  }
}






class TrainCoordinates extends StatefulWidget {
  const TrainCoordinates({super.key});

  @override
  _TrainCoordinatesState createState() => _TrainCoordinatesState();
}

class _TrainCoordinatesState extends State<TrainCoordinates> {
  final TextEditingController trainController = TextEditingController();
  // final TextEditingController _destinationController = TextEditingController();
  Map _trainInfo = {"lat": 0, "lng": 0};

  Future<void> _getTrainData() async {
    final String train = trainController.text;
    // final String destination = _destinationController.text;
    const String apiKey = '0509bbc2-21b1-4fd9-8d18-393015d21bf7'; // Replace with your AviationStack API key

    if (train.isEmpty || apiKey == 'YOUR_AVSTACK_API_KEY') {
      // Show an error message if origin, destination, or API key is not provided
      setState(() {
        _trainInfo = {};
      });
      return;
    }

    final String apiUrl =
        'https://api.railwayapi.site/api/v1/stations/$train';
    // 'https://api.openrailwaymap.org/v2/facility?name=$train&limit=1';

    try {
      final http.Response response = await http.get(Uri.parse(apiUrl));

      final data = json.decode(response.body);

      // final data = response.body;

      print(data);

      if (response.statusCode == 200) {
        // Parse the response and update the UI
        final dynamic data = json.decode(response.body);
        setState(() {
          _trainInfo["lat"] = data["response"][0]["Station"][0]["Latitude"];
          _trainInfo["lng"] = data["response"][0]["Station"][0]["Longitude"];
        });
      } else {
        // Show an error message if the API request fails
        setState(() {
          _trainInfo = {};
        });
      }
    } catch (e) {
      // Handle any exceptions that may occur
      setState(() {
        _trainInfo = {};
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flight Info App'),
      ),
      body: ListView(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: trainController,
            decoration: InputDecoration(labelText: 'Train'),
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: _getTrainData,
            // onPressed: _getTrainData,
            child: Text('Get Train Data'),
          ),
          SizedBox(height: 16.0),
          Text(
              "lat: ${_trainInfo["lat"]}, lng: ${_trainInfo["lng"]}"
          ),
        ],
      ),
    );
  }
}











class Flight {
  final String flightNumber;
  final double latitude;
  final double longitude;

  Flight({required this.flightNumber, required this.latitude, required this.longitude});

  factory Flight.fromJson(Map<String, dynamic> json) {
    return Flight(
      flightNumber: json['flight']['iata'],
      latitude: json['geography']['latitude'],
      longitude: json['geography']['longitude'],
    );
  }
}

class FlightSearchResult {
  final List<Flight> flights;

  FlightSearchResult({required this.flights});

  factory FlightSearchResult.fromJson(Map<String, dynamic> json) {
    final List<dynamic> data = json['data'];
    return FlightSearchResult(
      flights: data.map((flight) => Flight.fromJson(flight)).toList(),
    );
  }
}
































class GetDistance extends StatefulWidget {
  const GetDistance({super.key});

  @override
  State<GetDistance> createState() => _GetDistanceState();
}

class _GetDistanceState extends State<GetDistance> {

  final TextEditingController _placeController1 = TextEditingController();
  final TextEditingController _placeController2 = TextEditingController();
  String startCoordinates = '';
  String endCoordinates = '';
  var distance;

  void getDistance(String start, String end) async {
    try {
      final response = await http.get(
        Uri.parse('https://router.project-osrm.org/route/v1/driving/$start;$end?steps=true'),
        headers: {
          'User-Agent': 'ID of your APP/service/website/etc. v0.1',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        print(data["routes"][0]["distance"]);

        setState(() {
          distance=data["routes"][0]["distance"];
        });

      //   if (data.length > 0) {
      //     final result = data[0];
      //     setState(() {
      //       if (point == "start_coordinates"){
      //         startCoordinates = '${result['lat']}, ${result['lon']}';
      //       }
      //       else{
      //         endCoordinates = '${result['lat']}, ${result['lon']}';
      //       }
      //     });
      //   } else {
      //     throw Exception('No coordinates found for $place');
      //   }
      // } else {
      //   throw Exception('Failed to load coordinates');
      // }
    }
    } catch (e) {
      setState(() {
        // if (point == "start_coordinates"){
        //   startCoordinates = 'Error: $e';
        // }
        // else{
        //   endCoordinates = 'Error: $e';
        // }
      });
    }
  }

  // void getRoute() async {
  //
  //   // HttpOverrides.global = new myhttpoverrides();
  //
  //   // var queryParameters = {
  //   //   'profile': 'car',
  //   //   'point': startCoordinates,
  //   //   'point_hint': endCoordinates,
  //   //   'snap_prevention': 'string',
  //   //   'curbside': 'any',
  //   //   'locale': 'en',
  //   //   'elevation': 'false',
  //   //   // 'details': 'string',
  //   //   'optimize': 'false',
  //   //   'instructions': 'true',
  //   //   'calc_points': 'true',
  //   //   'debug': 'false',
  //   //   'points_encoded': 'false',
  //   //   'ch.disable': 'true',
  //   //   'heading': '0',
  //   //   'heading_penalty': '120',
  //   //   'pass_through': 'false',
  //   //   'algorithm': 'round_trip',
  //   //   'round_trip.distance': '10000',
  //   //   'round_trip.seed': '0',
  //   //   'alternative_route.max_paths': '2',
  //   //   'alternative_route.max_weight_factor': '1.4',
  //   //   'alternative_route.max_share_factor': '0.6',
  //   //   'key': '0073ec20-da85-4236-a616-afc96ca1f037'
  //   // };
  //
  //   var uri = Uri.https(
  //       'graphhopper.com', '/api/1/route', queryParameters
  //   );
  //
  //   var response = await http.get(uri);
  //
  //   if (response.statusCode == HttpStatus.ok) {
  //
  //     var data = json.decode(response.body);
  //
  //     setState(() {
  //       route = data["paths"][0]["points"]["coordinates"];
  //     });
  //     // var data = response.body;
  //
  //     print(data["paths"][0]["points"]["coordinates"]);
  //     print(data["paths"][0]);
  //     // return data;
  //   } else {
  //     print('Request failed with status: ${response.statusCode}.');
  //   }
  //
  //
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("GetRoute"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextField(
                  controller: _placeController1,
                  decoration: const InputDecoration(labelText: 'Enter start location'),
                ),
                // ElevatedButton(
                //   onPressed: () {
                //     getDistance(_placeController1.text,"start_coordinates");
                //     // getCoordinates(_placeController2.text);
                //   },
                //   child: const Text('Get Coordinates'),
                // ),
                // Text('Coordinates: $startCoordinates'),


                TextField(
                  controller: _placeController2,
                  decoration: const InputDecoration(labelText: 'Enter end location'),
                ),
                // const SizedBox(height: 20),
                // ElevatedButton(
                //   onPressed: () {
                //     // getCoordinates(_placeController1.text);
                //     getDistance(_placeController1.text, _placeController2.text);
                //   },
                //   child: const Text('Get Coordinates'),
                // ),
                // const SizedBox(height: 20),
                // Text('Coordinates: $endCoordinates'),
                // const SizedBox(height: 30),
                Center(
                  child: ElevatedButton(
                    onPressed: () { getDistance(_placeController1.text, _placeController2.text); },
                    child: const Text(
                        "Get Distance"
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Text("Distance: $distance m")
              ],
            ),
          ),
        ],
      ),
    );
  }
}

















Future<void> scrapeCoordinates() async {
  final response = await http.get(Uri.parse('https://www.latlong.net/convert-address-to-lat-long.html'));


  print(response.body);
  if (response.statusCode == 200) {
    // Check if the response content type is HTML
    if (response.headers['content-type']?.contains('text/html') ?? false) {
      // Parse the HTML content
      final document = parse(response.body);

      // Use the ID and class to locate the specific element
      final coordinatesElement = document.querySelector('#latlngspan.coordinatetxt');

      // Check if the element is found before extracting data
      if (coordinatesElement != null) {
        final coordinatesText = coordinatesElement.text;

        // Extract and print the coordinates
        final regex = RegExp(r'\((-?\d+\.\d+), (-?\d+\.\d+)\)');
        final match = regex.firstMatch(coordinatesText);
        final latitude = match?.group(1);
        final longitude = match?.group(2);
        print('Latitude: $latitude, Longitude: $longitude');
        if (match != null) {
          final latitude = match.group(1);
          final longitude = match.group(2);

          print('Latitude: $latitude, Longitude: $longitude');
        }
      } else {
        print('Coordinates element not found on the page.');
      }
    } else {
      print('Response is not HTML. Expected HTML content.');
    }
  } else {
    print('Failed to load website: ${response.statusCode}');
  }
}
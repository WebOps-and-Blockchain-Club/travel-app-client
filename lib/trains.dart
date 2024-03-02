import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:travel_app_client/search.dart';

import 'flights.dart';

// // List graph = [];
//
// import 'dart:convert';
// import 'package:http/http.dart' as http;



class GetTrains extends StatefulWidget {
  const GetTrains({super.key});

  @override
  State<GetTrains> createState() => _GetTrainsState();
}

class _GetTrainsState extends State<GetTrains> {

  final TextEditingController start = TextEditingController();
  final TextEditingController end = TextEditingController();


  Future<void> getTrains(start, end, date) async {
    final Uri url = Uri.parse('https://indian-railway-api.cyclic.app/trains/gettrainon?from=$start&to=$end&date=31-01-2024');

    // final Map<String, String> headers = {
    //   'X-RapidAPI-Key': 'cd988d1ba3msh80e5cc1cdf2241ep16817ajsn5d06bd5f5e06',
    //   'X-RapidAPI-Host': 'irctc1.p.rapidapi.com',
    // };
    //
    // final Map<String, String> params = {
    //   'fromStationCode': start,
    //   'toStationCode': end,
    //   'dateOfJourney': date,
    // };

    try {
      final response = await http.get(
        Uri.parse('http://indian-railway-api.cyclic.app/trains/gettrainon?from=$start&to=$end&date=31-01-2024'),
        headers: <String, String>{
          "Access-Control-Allow-Origin": "*",
          'Content-Type': 'application/json; charset=UTF-8',
        }

        ,);

      // final data = json.decode(response.body);
      //
      // print(data["data"][0]["train_base"]);
      // trains = data["data"];
      // setState(() {
      //   trains = data["data"];
      // });

      if (response.statusCode == 200) {
        // Handle the successful response from the backend
        print('Response from backend: ${response.body}');

        final data = json.decode(response.body);

        print(data["data"][0]["train_base"]);


        // setState(() {
        //   flightData = data["best_flights"];
        // });

        for (int i = 0; i < data["data"].length; i++){

          String distance = await getDistance(data["data"][i]["train_base"]["from_stn_code"], data["data"][i]["train_base"]["to_stn_code"]);
          // double distance = await getDistance(
          //     await getStationCoordinates2(
          //       data["data"][i]["train_base"]["from_stn_code"]
          //     ),
          //     await getStationCoordinates2(
          //         data["data"][i]["train_base"]["to_stn_code"]
          //     )
          // );

          // String distance = await getDistance(
          //     await getAirportCoordinates(
          //         data["other_flights"][i]["flights"][0]["departure_airport"]["id"]
          //     ),
          //     await getAirportCoordinates(
          //         data["other_flights"][i]["flights"][0]["arrival_airport"]["id"]
          //     )
          // );

          graph.add(
              {


                "train_no" : data["data"][i]["train_base"]["train_no"],
                "train_name":data["data"][i]["train_base"]["train_name"],
                "source_stn_code":data["data"][i]["train_base"]["source_stn_code"],
                "dstn_stn_code":data["data"][i]["train_base"]["dstn_stn_code"],
                "from_stn_code":data["data"][i]["train_base"]["from_stn_code"],
                "to_stn_code":data["data"][i]["train_base"]["to_stn_code"],
                "from_time":data["data"][i]["train_base"]["from_time"],
                "to_time":data["data"][i]["train_base"]["to_time"],
                "travel_time":data["data"][i]["train_base"]["travel_time"],
                "distance": distance,
                "mode": "railway"


                // 'fromId': data["other_flights"][i]["flights"][0]["departure_airport"]["id"],
                // 'toId': data["other_flights"][i]["flights"][0]["arrival_airport"]["id"],
                // 'departDate': extractDate(data["other_flights"][i]["flights"][0]["departure_airport"]["time"]),
                // 'arrivalDate':extractDate(data["other_flights"][i]["flights"][0]["arrival_airport"]["time"]),
                // 'returnDate': dateInput.text,
                // 'iata': data["other_flights"][i]["flights"][0]["flight_number"],
                // 'timeofdeparture':extractTime(data["other_flights"][i]["flights"][0]["departure_airport"]["time"]),
                // 'timeofarrival':extractTime(data["other_flights"][i]["flights"][0]["arrival_airport"]["time"]),
                // 'distance':distance,
                // 'price': data["other_flights"][i]["price"]


              }
          );
        }



        print("graph $graph");


        sendGraph(graph);

        // print("dep ${data["best_flights"][0]["flights"][0]["departure_airport"]["id"]}");
        // print("depDate ${data["best_flights"][0]["flights"][0]["departure_airport"]["time"]}");
        // print("depDate_extracted ${extractDate(data["best_flights"][0]["flights"][0]["departure_airport"]["time"])}");
        // print("depTime_extracted ${extractTime("${data["best_flights"][0]["flights"][0]["departure_airport"]["time"]}")}");
        //
        // print("flight_Number ${data["best_flights"][0]["flights"][0]["flight_number"]}");
        //
        //
        // print("arr ${data["best_flights"][0]["flights"][0]["arrival_airport"]["id"]}");
        // print("arrDate ${data["best_flights"][0]["flights"][0]["arrival_airport"]["time"]}");
        // print("arrDate_extracted ${extractDate("${data["best_flights"][0]["flights"][0]["arrival_airport"]["time"]}")}");
        // print("arrTime_extracted ${extractTime("${data["best_flights"][0]["flights"][0]["arrival_airport"]["time"]}")}");
        //
        //
        //
        // print("dep2 ${data["other_flights"][0]["flights"][0]["departure_airport"]["id"]}");
        // print("arr2 ${data["other_flights"][0]["flights"][0]["arrival_airport"]["id"]}");
        // print("printing ${data["best_flights"][0]}");
      } else {
        // Handle errors
        print('Error: ${response.statusCode}');
      }



      // getFare(start,end, data["data"][0]["train_base"]["train_no"]);


      // print(response.body);
      // print(data);




    } catch (error) {
      print(error);
    }
  }








  Future<String> getDistance(start, end) async {
    final apiKey = "ffa7bbd869cbd84e84c77d80b8d322fc9caaf5fbabb10eb171e9e256fa6b71a9";
    final engine = "google_maps_directions";
    final hl = "en";
    final q = "Coffee";
    final gl = "in";
    final startAddr = "$start railway  station";
    final endAddr = "$end railway station";
    final travelMode = "6";
    final distanceUnit = "0";

    // final url = Uri.parse("https://serpapi.com/search.json?api_key=$apiKey&engine=$engine&hl=$hl&q=$q&gl=$gl&start_addr=$startAddr&end_addr=$endAddr&travel_mode=$travelMode&distance_unit=$distanceUnit");


    try {
      final response = await http.get(
          Uri.parse("https://serpapi.com/search.json?api_key=$apiKey&engine=$engine&hl=$hl&q=$q&gl=$gl&start_addr=$startAddr&end_addr=$endAddr&travel_mode=$travelMode&distance_unit=$distanceUnit"));

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData.length > 0) {
          // final lat = double.parse(responseData[0]['lat']);
          // final lon = double.parse(responseData[0]['lon']);
          print("ehre");
          print(responseData["directions"][0]["distance"]);
          return "${responseData["directions"][0]["distance"]}";
        } else {
          throw Exception('Station not found');
        }
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (error) {
      throw Exception('Error fetching station coordinates: $error');
    }

    // http.get(url).then((response) {
    //   if (response.statusCode == 200) {
    //     // var json = jsonDecode(response.body);
    //     final data = json.decode(response.body);
    //     print("distance data : $data");
    //     return "";
    //   } else {
    //     print('Request failed with status: ${response.statusCode}.');
    //     return "2";
    //   }
    // }).catchError((error) {
    //   print('Request failed with error: $error.');
    //   return "3";
    // });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Get Trains"),
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
                  controller: start,
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
                  controller: end,
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
                    onPressed: () { getTrains(start.text, end.text, '2024-01-31'); },
                    child: const Text(
                        "Search Trains"
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                // Text("${trains[0]["train_base"]["train_no"]}")
                // Text("Distance: $distance m")
              ],
            ),
          ),
        ],
      ),
    );
  }
}


// import 'dart:convert';
// import 'package:http/http.dart' as http;

// Replace 'your-api-key' with your actual OpenRouteService API key
const apiKey = '5b3ce3597851110001cf6248b9d3188fefa440ea82a92fbdc0e2ec33';


Future<Map<String, double>> getStationCoordinates(String stationCode) async {
  try {
    final response = await http.get(
        Uri.parse(
            'https://nominatim.openstreetmap.org/search?format=json&limit=1&namedetails=1&q=railway=${stationCode}'));

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      if (responseData.length > 0) {
        final lat = double.parse(responseData[0]['lat']);
        final lon = double.parse(responseData[0]['lon']);
        print("ehre");
        print(responseData[0]);
        return {'lat': lat, 'lon': lon};
      } else {
        throw Exception('Station not found');
      }
    } else {
      throw Exception('Failed to fetch data');
    }
  } catch (error) {
    throw Exception('Error fetching station coordinates: $error');
  }
}

Future<Map<String, double>> getStationCoordinates2(String areaName) async {



  final overpassUrl = "http://overpass-api.de/api/interpreter";

  // Define your query to find railway stations
  final query = """
[out:json];
area[name="$areaName"]->.a;
node(area.a)[railway=station];
out center;
""";

  // Send the request to Overpass API
  // final response = await http.get(Uri.parse(overpassUrl + "?data=$query"));

  try{
    final response = await http.get(Uri.parse(overpassUrl + "?data=$query"));
    if (response.statusCode == 200) {
      // Parse the JSON response
      final data = jsonDecode(response.body);

      print("coordinates wala data :$data");
      // Extract coordinates of railway stations
      final List<Map<String, double>> railwayStations = [];
      return {};
      // for (final element in data['elements']) {
      //   if (element['center'] != null &&
      //       element['center']['lat'] != null &&
      //       element['center']['lon'] != null) {
      //     final lat = double.parse(element['center']['lat'].toString());
      //     final lon = double.parse(element['center']['lon'].toString());
      //
      //     return {'lat': lat, 'lon': lon};
      //     // railwayStations.add({'lat': lat, 'lon': lon});
      //   }else{
      //     throw Exception('Failed to fetch data');
      //   }
      // }

    } else {
      throw Exception('Failed to fetch data');
    }
  }
  catch(error){
    throw Exception('Error fetching station coordinates: $error');
  }

}

// Future<double> getDistance(Map<String, double> start, Map<String, double> end) async {
//   try {
//     final response = await http.post(
//         Uri.parse(
//             'https://api.openrouteservice.org/v2/directions/driving-car'),
//       body: '{ "coordinates":[ [${start["lat"]}, ${start["lon"]}] , [${end["lat"]}, ${end["lon"]}]] }',
//         headers: {
//           'Accept': 'application/json, application/geo+json, application/gpx+xml, img/png; charset=utf-8',
//           'Authorization': '5b3ce3597851110001cf6248b9d3188fefa440ea82a92fbdc0e2ec33',
//           'Content-Type': 'application/json; charset=utf-8'
//         }
//     );
//
//     if (response.statusCode == 200) {
//       final responseData = json.decode(response.body);
//       final distanceInMeters = responseData['features'][0]['properties']['summary']['distance'];
//       final distanceInKilometers = distanceInMeters / 1000;
//
//       return distanceInKilometers;
//     } else {
//       throw Exception('Failed to fetch data');
//     }
//   } catch (error) {
//     print('Error calculating distance: $error');
//     throw error;
//   }
// }

// Example usage:
// void main() async {
//   final stationA = [-73.985656, 40.748433]; // Example coordinates of station A
//   final stationB = [-73.993805, 40.737423]; // Example coordinates of station B
//
//   try {
//     final distance = await getDistance(stationA, stationB);
//     print('Distance between the two stations: $distance kilometers');
//   } catch (error) {
//     // Handle error
//   }
// }


List trains = [];



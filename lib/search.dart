import 'dart:convert';
// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
// import 'package:travel_app_client/path.dart';
// import 'package:travel_app_client/trains.dart';

// import 'flights.dart';
List<List> path = [[ "place1", "place2", "air",36005, 15000], ["place2", "place3", "air",36005, 15000], ["place3", "place4","rail",36005,15000]];

List graph = [];

String start_airport = "";
String end_airport = "";
String start_railway = "";
String end_railway = "";

String dropdownValue = 'cost';

final TextEditingController start = TextEditingController();
final TextEditingController end = TextEditingController();

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {









  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Route"),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(
                        onPressed: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1950),
                              //DateTime.now() - not to allow to choose before today.
                              lastDate: DateTime(2100));

                          if (pickedDate != null) {
                            print(pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                            String formattedDate =
                            DateFormat('yyyy-MM-dd').format(pickedDate);
                            print(formattedDate); //formatted date output using intl package =>  2021-03-16
                            setState(() {
                              dateInput.text = formattedDate; //set output date to TextField value.
                            });
                          } else {}
                        },

                        // showDialog(
                        //   context: context,
                        //   builder: (dialogContext) {
                        //     return StatefulBuilder(builder: (stfContext, stfSetState) {
                        //       return AlertDialog(
                        //         title: const Center(
                        //           child: Text(
                        //             "Choose Date",
                        //           ),
                        //         ),
                        //         content: Column(
                        //           children: [
                        //             Expanded(
                        //               child: Container(
                        //                 height: 0.4*queryData.size.height,
                        //                 width: 0.9*queryData.size.width,
                        //                 decoration: BoxDecoration(
                        //                   borderRadius: BorderRadius.circular(18),
                        //                   color: Colors.white,
                        //                 ),
                        //                 child: Center(
                        //                   child: Padding(
                        //                     padding: const EdgeInsets.all(8.0),
                        //                     child: TableCalendar(
                        //                         focusedDay: today,
                        //                         rowHeight: 43,
                        //                         firstDay: DateTime(today.year - 1,today.month, today.day),
                        //                         lastDay: DateTime(today.year + 1,today.month, today.day),
                        //                       availableGestures: AvailableGestures.all,
                        //                       headerStyle: const HeaderStyle(
                        //                         formatButtonVisible: false,
                        //                         titleCentered: true
                        //                       ),
                        //                       selectedDayPredicate: (day) => isSameDay(day, today),
                        //                       onDaySelected: (DateTime day, DateTime focusedDay){
                        //                           stfSetState(() {
                        //                             today = day;
                        //                           });
                        //                       },
                        //                     ),
                        //                   )
                        //                 ),
                        //               ),
                        //             ),
                        //           ],
                        //         ),
                        //       );
                        //     });
                        //   },
                        // );
                        icon: const Icon(
                          Icons.calendar_today_rounded,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Padding(
                        //   padding: const EdgeInsets.only(left: 10),
                        //   child: Text(
                        //     dropdownValue,
                        //     style: const TextStyle(
                        //       fontFamily: "Poppins-Regular",
                        //       fontSize: 22,
                        //     ),
                        //   ),
                        // ),
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: DropdownButton<String>(
                            underline: Container(height: 0.0,),
                            borderRadius: BorderRadius.circular(18),
                            value: dropdownValue,
                            iconSize: 30,
                            onChanged: (String? newValue){
                              setState(() {
                                dropdownValue = newValue!;
                                print(dropdownValue);
                                // filterEvents();
                              });
                              // filterEvents();
                            },
                            icon: const Icon(Icons.filter_alt_rounded),
                            items: const[
                              // DropdownMenuItem<String>(value: 'All',child: Text("All")),
                              DropdownMenuItem<String>(value: 'cost',child: Text("cost")),
                              DropdownMenuItem<String>(value: 'distance',child: Text("distance")),
                              DropdownMenuItem<String>(value: 'time',child: Text("time")),
                              // DropdownMenuItem<String>(value: 'Exhibitions',child: Text("Exhibitions")),
                              // DropdownMenuItem<String>(value: 'Summit',child: Text("Summit")),
                              // DropdownMenuItem<String>(value: 'Highlights',child: Text("Highlights")),
                            ],
                            style: const TextStyle(
                              fontFamily: "Poppins-Regular",
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
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
                    onPressed: () async {
                      start_airport = await getAirportCode(start.text);
                      end_airport = await getAirportCode(end.text);
                      start_railway = await getStationCode(start.text);
                      end_railway = await getStationCode(end.text);
                      // setState(() async {
                      //   start_airport = await getAirportCode(start.text);
                      //   end_airport = await getAirportCode(end.text);
                      //   start_railway = await getStationCode(start.text);
                      //   end_railway = await getStationCode(end.text);
                      //
                      // });
                      await getTrains(start_railway, end_railway, dateInput.text);
                      searchFlights(start_airport, end_airport, dateInput.text, dateInput.text);

                    },
                    child: const Text(
                        "Search Route"
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                // Text("${trains[0]["train_base"]["train_no"]}")
                // Text("Distance: $distance m")
              ],
            ),
          ),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // children: data.keys.map((e) => WaypointLine(text: e[0], icon: (e[0] == start.text || e[0] == end.text) ? Icons.flag : Icons.change_circle, transport: e[2] == "air" ? Icons.airplanemode_active_rounded : (e[2] == "train" ? Icons.train : Icons.directions_walk))).toList(),
                  children: path.map((e) => WaypointLine(text: e[0], icon: (e[0] == "place1" ) ? Icons.flag : Icons.change_circle, transport: e[2] == "air" ? Icons.airplanemode_active_rounded : (e[2] == "rail" ? Icons.train : Icons.directions_walk), distance: e[3],price: e[4],)).toList(),
                  // children: [
                  //   WaypointLine(
                  //     text: 'Start',
                  //     icon: Icons.flag,
                  //     transport: Icons.flight,
                  //   ),
                  //   WaypointLine(
                  //     text: 'Waypoint 1',
                  //     icon: Icons.change_circle,
                  //     transport: Icons.bus_alert,
                  //   ),
                  //   WaypointLine(
                  //     text: 'Waypoint 2',
                  //     icon: Icons.change_circle,
                  //     transport: Icons.train,
                  //   ),
                  //   WaypointLine(
                  //     text: 'Waypoint 3',
                  //     icon: Icons.change_circle,
                  //     transport: Icons.directions_walk,
                  //   ),
                  //   Padding(
                  //     padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.start,
                  //       children: [
                  //         Container(
                  //           height: 30,
                  //           width: 30,
                  //           decoration: BoxDecoration(
                  //             shape: BoxShape.circle,
                  //             color: Colors.blue, // Color of the circle icon
                  //           ),
                  //           child: Icon(Icons.flag, size: 24, color: Colors.white),
                  //         ),
                  //         SizedBox(width: 10),
                  //         Text(
                  //           "End",
                  //           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ],
                ),
                // WaypointLine(text: path[path.length - 1][1], icon: Icons.flag, transport: path[path.length - 1][1])
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    children: [
                      Container(
                        height: 30,
                        width: 30,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue, // Color of the circle icon
                        ),
                        child: Icon(Icons.flag, size: 24, color: Colors.white),
                      ),
                      SizedBox(width: 10),
                      Text(
                        path[path.length - 1][1],
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
              ],
            ),
          ),

        ],
      ),
    );
  }
}


class WaypointLine extends StatefulWidget {
  final String text;
  final IconData icon;
  final IconData transport;
  double price;
  double distance;

  WaypointLine({super.key, required this.text, required this.icon, required this.transport, this.price = 0, this.distance = 100});

  @override
  State<WaypointLine> createState() => _WaypointLineState();
}

class _WaypointLineState extends State<WaypointLine> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 30,
                width: 30,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue, // Color of the circle icon
                ),
                child: Icon(widget.icon, size: 24, color: Colors.white),
              ),
              const SizedBox(width: 10),
              Text(
                widget.text,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                width: 14,
              ),
              Container(
                width: 02,
                height: 50,
                color: Colors.blue,
              ),
              const SizedBox(width: 20),
              Icon(widget.transport),
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 8, 8, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(
                        "₹${widget.price}",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(
                        "${widget.distance} metres",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),

                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}



String extractDate(time) {
  String dateTimeString = time;
  DateTime dateTime = DateTime.parse(dateTimeString);

  // Splitting date and time
  List<String> dateTimeParts = dateTimeString.split(' ');

  // Extracting date
  String dateString = dateTimeParts[0];

  // Extracting time
  String timeString = dateTimeParts[1];

  // String dateString = '$year-$month-$day';
  //
  // // Convert time to string
  // String timeString = '$hour:$minute';


  return dateString;

  // print('Date: $year-$month-$day');
  // print('Time: $hour:$minute');
}

String extractTime(time) {
  String dateTimeString = time;
  DateTime dateTime = DateTime.parse(dateTimeString);

  // Splitting date and time
  List<String> dateTimeParts = dateTimeString.split(' ');

  // Extracting date
  String dateString = dateTimeParts[0];

  // Extracting time
  String timeString = dateTimeParts[1];


  return timeString;

  // print('Date: $year-$month-$day');
  // print('Time: $hour:$minute');
}




Future<void> getTrains(start, end, date) async {
  // final Uri url = Uri.parse('https://indian-railway-api.cyclic.app/trains/gettrainon?from=$start&to=$end&date=31-01-2024');

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
      Uri.parse('http://indian-railway-api.cyclic.app/trains/gettrainon?from=$start_railway&to=$end_railway&date=${dateInput.text}'),
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
      print('GOT TRAINS: ${response.body}');


      final data = json.decode(response.body);

      // print(data["data"][0]["train_base"]);


      // setState(() {
      //   flightData = data["best_flights"];
      // });

      for (int i = 0; i < data["data"].length; i++){

        double distance = await getDistance(data["data"][i]["train_base"]["from_stn_code"], data["data"][i]["train_base"]["to_stn_code"]);
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

        // String city_departure = await getCityNameOfRailwayStation(data["data"][i]["train_base"]["from_stn_code"]);
        // String city_arrival = await getCityNameOfRailwayStation(data["data"][i]["train_base"]["to_stn_code"]);
        String city_departure = await getStationInfo(data["data"][i]["train_base"]["from_stn_code"]);
        String city_arrival = await getStationInfo(data["data"][i]["train_base"]["to_stn_code"]);

        double price = await getFare(data["data"][i]["train_base"]["from_stn_code"],data["data"][i]["train_base"]["to_stn_code"], data["data"][i]["train_base"]["train_no"]);

        graph.add(
            [


              // "train_no" : data["data"][i]["train_base"]["train_no"],
              // "train_name":data["data"][i]["train_base"]["train_name"],
              // "source_stn_code":data["data"][i]["train_base"]["source_stn_code"],
              // "dstn_stn_code":data["data"][i]["train_base"]["dstn_stn_code"],
              // "from_stn_code":data["data"][i]["train_base"]["from_stn_code"],
              // "to_stn_code":data["data"][i]["train_base"]["to_stn_code"],

              // "from_stn_name":data["data"][i]["train_base"]["from_stn_name"],
              // "to_stn_name":data["data"][i]["train_base"]["to_stn_name"],

              // "from_stn_name":city_departure,
              // "to_stn_name":city_arrival,

              city_departure,
              city_arrival,
              "rail",
              data["data"][i]["train_base"]["train_name"],
              data["data"][i]["train_base"]["from_time"],
              data["data"][i]["train_base"]["from_time"],
              data["data"][i]["train_base"]["to_time"],
              distance,
              price

              // "from_time":data["data"][i]["train_base"]["from_time"],
              // "to_time":data["data"][i]["train_base"]["to_time"],
              // // "travel_time":data["data"][i]["train_base"]["travel_time"],
              // "distance": distance,

              // "mode": "railway"


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


            ]
        );
      }



      print("graph $graph");


      // sendGraph(graph);

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
    print("error: $error");
  }
}

Future<void> searchFlights(dep, arr, out_date, return_date) async {
  String apiUrl = 'http://localhost:3000/search_flights';


  Map<String, dynamic> requestData = {
    'departure_id': '$start_airport',
    'arrival_id': '$end_airport',
    'outbound_date': '$out_date',
    'return_date': '$return_date',
  };

  try {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Access-Control-Allow-Origin': '*'
      },
      body: jsonEncode(requestData),
    );

    if (response.statusCode == 200) {
      // Handle the successful response from the backend
      print('Response from google api: ${response.body}');

      final data = json.decode(response.body);


      // setState(() {
      //   flightData = data["best_flights"];
      // });

      for (int i = 0; i < data["best_flights"].length; i++){

        print("hereeee1");
        // print("iata codes: ${data["other_flights"][i]["flights"][0]["departure_airport"]["id"]}");
        double distance = await getAirportDistance(
            // await getAirportCoordinates(
            //     data["best_flights"][i]["flights"][0]["departure_airport"]["id"]
            // ),
            // await getAirportCoordinates(
            //     data["best_flights"][i]["flights"][0]["arrival_airport"]["id"]
            // )
            await getMAACoordinates(
                data["best_flights"][i]["flights"][0]["departure_airport"]["id"]
            ),
            await getMAACoordinates(
                data["best_flights"][i]["flights"][0]["arrival_airport"]["id"]
            )
        );

        print("hereeee2");
        String city_departure = await getAirportCity(data["best_flights"][i]["flights"][0]["departure_airport"]["id"]);
        String city_arrival = await getAirportCity(data["best_flights"][i]["flights"][0]["arrival_airport"]["id"]);

        graph.add(
            [

              // 'fromId': data["best_flights"][i]["flights"][0]["departure_airport"]["id"],
              // 'toId': data["best_flights"][i]["flights"][0]["arrival_airport"]["id"],

              // 'fromName': data["best_flights"][i]["flights"][0]["departure_airport"]["name"],
              // 'toName': data["best_flights"][i]["flights"][0]["arrival_airport"]["name"],
              // 'fromName': city_departure,
              // 'toName': city_arrival,

              city_departure,
              city_arrival,
              "air",
              data["best_flights"][i]["flights"][0]["flight_number"],
              extractTime(data["best_flights"][i]["flights"][0]["departure_airport"]["time"]),
              extractTime(data["best_flights"][i]["flights"][0]["arrival_airport"]["time"]),
              extractTime(data["best_flights"][i]["flights"][0]["arrival_airport"]["time"]),
              distance,
              data["best_flights"][i]["price"]

              // 'departDate': extractDate(data["best_flights"][i]["flights"][0]["departure_airport"]["time"]),
              // 'arrivalDate':extractDate(data["best_flights"][i]["flights"][0]["arrival_airport"]["time"]),
              // 'returnDate': dateInput.text,
              // 'iata': data["best_flights"][i]["flights"][0]["flight_number"],
              // 'timeofdeparture':extractTime(data["best_flights"][i]["flights"][0]["departure_airport"]["time"]),
              // 'timeofarrival':extractTime(data["best_flights"][i]["flights"][0]["arrival_airport"]["time"]),
              // 'distance': distance,

              // 'price': data["best_flights"][i]["price"],
              // "mode": "airway"

            ]
        );
      };

      for (int i = 0; i < data["other_flights"].length; i++){

        // print(data["other_flights"][i]["flights"][0]["departure_airport"]["id"]);
        double distance = await getAirportDistance(
            // await getAirportCoordinates(
            //     data["other_flights"][i]["flights"][0]["departure_airport"]["id"]
            // ),
            // await getAirportCoordinates(
            //     data["other_flights"][i]["flights"][0]["arrival_airport"]["id"]
            // )
            await getMAACoordinates(
                data["other_flights"][i]["flights"][0]["departure_airport"]["id"]
            ),
            await getMAACoordinates(
                data["other_flights"][i]["flights"][0]["arrival_airport"]["id"]
            )
        );

        String city_departure = await getAirportCity(data["other_flights"][i]["flights"][0]["departure_airport"]["id"]);
        String city_arrival = await getAirportCity(data["other_flights"][i]["flights"][0]["arrival_airport"]["id"]);

        graph.add(
            [

              // 'fromId': data["other_flights"][i]["flights"][0]["departure_airport"]["id"],
              // 'toId': data["other_flights"][i]["flights"][0]["arrival_airport"]["id"],

              // 'fromName': data["other_flights"][i]["flights"][0]["departure_airport"]["name"],
              // 'toName': data["other_flights"][i]["flights"][0]["arrival_airport"]["name"],
              // 'fromName': city_departure,
              // 'toName': city_arrival,

              city_departure,
              city_arrival,
              "air",
              data["other_flights"][i]["flights"][0]["flight_number"],
              extractTime(data["other_flights"][i]["flights"][0]["departure_airport"]["time"]),
              extractTime(data["other_flights"][i]["flights"][0]["departure_airport"]["time"]),
              extractTime(data["other_flights"][i]["flights"][0]["arrival_airport"]["time"]),
              distance,
              data["other_flights"][i]["price"]
              // 'departDate': extractDate(data["other_flights"][i]["flights"][0]["departure_airport"]["time"]),
              // 'arrivalDate':extractDate(data["other_flights"][i]["flights"][0]["arrival_airport"]["time"]),
              // 'returnDate': dateInput.text,
              // 'iata': data["other_flights"][i]["flights"][0]["flight_number"],
              // 'timeofdeparture': extractTime(data["other_flights"][i]["flights"][0]["departure_airport"]["time"]),
              // 'timeofarrival': extractTime(data["other_flights"][i]["flights"][0]["arrival_airport"]["time"]),
              // 'distance': distance,
              // 'price': data["other_flights"][i]["price"],
              // "mode": "airway"


            ]
        );
      };



      print("graph $graph");


      // String graph2 = json.encode(graph);
      // print(graph2);

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
  } catch (e) {
    print('Error sending POST request: $e');
  }
}

TextEditingController dateInput = TextEditingController();

Future<double> getDistance(start, end) async {
  final apiKey = "e03ce064fe991e8754bd996dbf7c8d5d3e0b8ab93cb1217e10d6a05549f428fe";
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
        // print("ehre");
        print(responseData["directions"][0]["distance"]);
        return responseData["directions"][0]["distance"];
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

Future<String> getAirportCoordinates(airport) async {
  // final String airport = airportController.text;
  // final String destination = _destinationController.text;
  const String apiKey = '0509bbc2-21b1-4fd9-8d18-393015d21bf7'; // Replace with your AviationStack API key

  // if (airport.isEmpty || apiKey == 'YOUR_AVSTACK_API_KEY') {
  //   // Show an error message if origin, destination, or API key is not provided
  //   // setState(() {
  //   //   _flightInfo = {};
  //   // });
  //   return;
  // }

  final String apiUrl =
      'https://airlabs.co/api/v9/airports?iata_code=$airport&api_key=$apiKey';

  final http.Response response = await http.get(Uri.parse(apiUrl));

  final data = json.decode(response.body);

  // print(data["response"][0]["lat"]);

  if (response.statusCode == 200) {
    // Parse the response and update the UI
    final dynamic data = json.decode(response.body);

    // print("coordinates data: ${data["response"]}");
    print("hereeee3");
    return "${data["response"][0]["lat"]},${data["response"][0]["lng"]}";

    // setState(() {
    //   _flightInfo["lat"] = data["response"][0]["lat"];
    //   _flightInfo["lng"] = data["response"][0]["lng"];
    // });
  } else {
    // Show an error message if the API request fails
    // setState(() {
    //   _flightInfo = {};
    // });
    return '';
  }







}


Future<double> getAirportDistance(String start, String end) async {

  final response = await http.get(
    Uri.parse('https://router.project-osrm.org/route/v1/driving/$start;$end?steps=true'),
    headers: {
      'User-Agent': 'ID of your APP/service/website/etc. v0.1',
    },
  );

  if (response.statusCode == 200) {
    final data = json.decode(response.body);

    // print(data["routes"][0]["distance"]);


    return data["routes"][0]["distance"];


    // setState(() {
    //   distance=data["routes"][0]["distance"];
    // });

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
  else{
    return 1;
  }

  // try {
  //   final response = await http.get(
  //     Uri.parse('https://router.project-osrm.org/route/v1/driving/$start;$end?steps=true'),
  //     headers: {
  //       'User-Agent': 'ID of your APP/service/website/etc. v0.1',
  //     },
  //   );
  //
  //   if (response.statusCode == 200) {
  //     final data = json.decode(response.body);
  //
  //     print(data["routes"][0]["distance"]);
  //
  //
  //     return data["routes"][0]["distance"];
  //
  //
  //     // setState(() {
  //     //   distance=data["routes"][0]["distance"];
  //     // });
  //
  //     //   if (data.length > 0) {
  //     //     final result = data[0];
  //     //     setState(() {
  //     //       if (point == "start_coordinates"){
  //     //         startCoordinates = '${result['lat']}, ${result['lon']}';
  //     //       }
  //     //       else{
  //     //         endCoordinates = '${result['lat']}, ${result['lon']}';
  //     //       }
  //     //     });
  //     //   } else {
  //     //     throw Exception('No coordinates found for $place');
  //     //   }
  //     // } else {
  //     //   throw Exception('Failed to load coordinates');
  //     // }
  //   }
  //   else{
  //     return '';
  //   }
  // } catch (e) {
  //   // setState(() {
  //   //   // if (point == "start_coordinates"){
  //   //   //   startCoordinates = 'Error: $e';
  //   //   // }
  //   //   // else{
  //   //   //   endCoordinates = 'Error: $e';
  //   //   // }
  //   // });
  //   return '';
  // };


}



Future<String> getAirportCode(String airport) async {
  final url = Uri.https('serpapi.com', '/search', {
    'api_key': 'e03ce064fe991e8754bd996dbf7c8d5d3e0b8ab93cb1217e10d6a05549f428fe',
    'engine': 'google',
    'q': 'main airport in $airport code',
    'location': 'Austin, Texas, United States',
    'google_domain': 'google.com',
    'gl': 'us',
    'hl': 'en',
  });

  final response = await http.get(url);

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    print(data["answer_box"]["answer"]);

    if (data["answer_box"]["answer"].contains("IATA:")) {
      // Extract "DEL" by splitting the inputString by ": " and taking the last element
      return data["answer_box"]["answer"].split(": ")[1];
    }else{
      return data["answer_box"]["answer"];
    }


    // Return the JSON response as a string
  } else {
    throw Exception('Failed to load data 1');
  }
}

Future<String> getStationCode(String station) async {
  final apiKey = "e03ce064fe991e8754bd996dbf7c8d5d3e0b8ab93cb1217e10d6a05549f428fe";
  final url = Uri.parse("https://serpapi.com/search.json?engine=google&q=main%20railway%20station%20in%20${station}%20code&location=Austin,%20Texas,%20United%20States&google_domain=google.com&gl=us&hl=en&api_key=$apiKey");

  final response = await http.get(url);

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    print(data["answer_box"]["answer"]);
    return data["answer_box"]["answer"];
  } else {
    throw Exception('Failed to load station code');
  }
}

Future<void> sendGraph(graph) async {
  String url = 'http://localhost:3000/getroute';



  Map<String, dynamic> requestBody = {
    'start': start.text,
    'destination': end.text,
    'currTime': DateTime.now().hour < 10? "0${DateTime.now().hour}:${DateTime.now().minute}" : "${DateTime.now().hour}:${DateTime.now().minute}",
    'graph': graph,
    'filter':dropdownValue
  };

  try {
    final response = await http.post(
      Uri.parse(url),
      body: jsonEncode(requestBody),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Access-Control-Allow-Origin': '*'
      },
    );

    if (response.statusCode == 200) {
      print('POST request successful');
      print('Response: ${response.body}');
    }
    else {
      print('POST request failed with status: ${response.statusCode}');
      print('Response: ${response.body}');
    }
  } catch (e) {
    print('Error sending POST request 2: $e');
  }
}




Future<String> getAirportCity(code) async {
  final apiKey = "e03ce064fe991e8754bd996dbf7c8d5d3e0b8ab93cb1217e10d6a05549f428fe";
  final endpoint = "https://serpapi.com/search";
  final queryParams = {
    "api_key": apiKey,
    "engine": "google",
    "q": "in which city iata=$code airport is located",
    "location": "Austin, Texas, United States",
    "google_domain": "google.com",
    "gl": "us",
    "hl": "en"
  };

  final uri = Uri.parse(endpoint).replace(queryParameters: queryParams);

  try {
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(data["answer_box"]["snippet_highlighted_words"][0]);
      return data["answer_box"]["snippet_highlighted_words"][0];
    } else {
      throw Exception('Failed to load data 3');
    }
  } catch (e) {
    print("Error: $e");
    return "";
  }
}


Future<String> getStationInfo(String stationCode) async {
  var apiKey = "e03ce064fe991e8754bd996dbf7c8d5d3e0b8ab93cb1217e10d6a05549f428fe";
  var url = "https://serpapi.com/search.json?" +
      "engine=google&" +
      "q=city%20or%20district%20name%20of%20railway%20station%20code%20%3D%20$stationCode&" +
      "location=Austin%2C%20Texas%2C%20United%20States&" +
      "google_domain=google.com&" +
      "gl=us&" +
      "hl=en&" +
      "api_key=$apiKey";

  var response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    // print(data["answer_box"]["snippet_highlighted_words"][0]);
    if (data["answer_box"]["snippet_highlighted_words"] != null){
      return data["answer_box"]["snippet_highlighted_words"][0];
    }else{
      return "";
    }
    // return data["answer_box"]["snippet_highlighted_words"][0];// Return the JSON response as a string
  } else {
    throw Exception('Failed to load data 2');
  }
}


Future<String> getCityNameOfRailwayStation(String stationCode) async {
  final response = await http.get(Uri.parse(
      'https://serpapi.com/search.json?api_key=e03ce064fe991e8754bd996dbf7c8d5d3e0b8ab93cb1217e10d6a05549f428fe&engine=google&q=city+name+of+railway+station+code=$stationCode&location=Austin,Texas,United+States&google_domain=google.com&gl=us&hl=en'));

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    print(data["answer_box"]["snippet_highlighted_words"][0]);
    return data["answer_box"]["snippet_highlighted_words"][0];
  } else {
    throw Exception('Failed to load data 4');
  }
}


Future<double> getFare(String start,String end,String trainNo) async {
  final Uri url = Uri.parse('https://irctc1.p.rapidapi.com/api/v2/getFare');

  final Map<String, String> headers = {
    'X-RapidAPI-Key': '74843d94cdmsh58bcf8b4b5bd7cep166781jsn33eb96ff7b1d',
    'X-RapidAPI-Host': 'irctc1.p.rapidapi.com',
  };

  final Map<String, String> params = {
    'trainNo': trainNo,
    'fromStationCode': start,
    'toStationCode': end,
  };

  final response = await http.get(url.replace(queryParameters: params), headers: headers);

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    // print("price data: ${data["data"]["general"][0]["fare"]}");
    if (data["data"]["general"][0] != null){
      return data["data"]["general"][0]["fare"];
    }else{
      return 1;
    }


  } else {
    throw Exception('Failed to load data 5');
  }

  // try {
  //   final response = await http.get(url.replace(queryParameters: params), headers: headers);
  //
  //   final data = json.decode(response.body);
  //
  //
  //   print("price train data: ${data["data"]}");
  //
  //   return 1.0;
  //
  // } catch (error) {
  //   print(error);
  // }
}




Future<String> getMAACoordinates(airport) async {
  String api_key = "e03ce064fe991e8754bd996dbf7c8d5d3e0b8ab93cb1217e10d6a05549f428fe";
  String engine = "google";
  String q = "coordinates of $airport airport";
  String location = "Austin, Texas, United States";
  String google_domain = "google.com";
  String gl = "us";
  String hl = "en";

  String url = "https://serpapi.com/search.json?api_key=$api_key&engine=$engine&q=$q&location=$location&google_domain=$google_domain&gl=$gl&hl=$hl";

  http.Response response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    Map<String, dynamic> data = json.decode(response.body);
    // List<dynamic> organicResults = data['organic_results'];

    print("coordinates: ${data["answer_box"]["answer"]}");


    // String coordinates = "12.9811° N, 80.1596° E";

    RegExp regex = RegExp(r"(\d+\.\d+)\°\s([NS]),\s(\d+\.\d+)\°\s([EW])");
    RegExpMatch? match = regex.firstMatch(data["answer_box"]["answer"]);

    // print("match $match");

    if (match != null) {
      String? latitude = match.group(1);
      String? longitude = match.group(3);
        // String latDirection = match.group(2);
        // String longDirection = match.group(4);

      print("$latitude,$longitude");
      return "$latitude,$longitude";
    }else {
      print("Coordinates not found");
      return "";
    }








    // for (var result in organicResults) {
    //   if (result['title'] == "Coordinates of MAA Airport") {
    //     return result['snippet'];
    //   }
    // }

    // return data["answer_box"]["answer"];
  } else {
    return "Failed to fetch coordinates.";
  }
}



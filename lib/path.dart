import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:travel_app_client/search.dart';

// void main() {
//   runApp(Path());
// }

Map<String, dynamic> data = {};
// List<List> path = [];

class PathOutput extends StatelessWidget {
  const PathOutput({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Route Overview'),
          centerTitle: true,
        ),
        body: Page(),
      ),
    );
  }
}

class Page extends StatelessWidget {
  const Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
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
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}



Future<double> getDistance(start, end) async {



  final url = "";

  try {
    final response = await http.get(
        Uri.parse(url));

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      if (responseData.length > 0) {

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
}
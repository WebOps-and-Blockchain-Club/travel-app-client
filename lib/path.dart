import 'package:flutter/material.dart';

// void main() {
//   runApp(Path());
// }

class PathOutput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Route Overview'),
          centerTitle: true,
        ),
        body: Page(),
      ),
    );
  }
}

class Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          WaypointLine(
            text: 'Start',
            icon: Icons.flag,
            transport: Icons.flight,
          ),
          WaypointLine(
            text: 'Waypoint 1',
            icon: Icons.change_circle,
            transport: Icons.bus_alert,
          ),
          WaypointLine(
            text: 'Waypoint 2',
            icon: Icons.change_circle,
            transport: Icons.train,
          ),
          WaypointLine(
            text: 'Waypoint 3',
            icon: Icons.change_circle,
            transport: Icons.directions_walk,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue, // Color of the circle icon
                  ),
                  child: Icon(Icons.flag, size: 24, color: Colors.white),
                ),
                SizedBox(width: 10),
                Text(
                  "End",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class WaypointLine extends StatelessWidget {
  final String text;
  final IconData icon;
  final IconData transport;

  const WaypointLine(
      {required this.text, required this.icon, required this.transport});

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
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue, // Color of the circle icon
                    ),
                    child: Icon(icon, size: 24, color: Colors.white),
                  ),
                  SizedBox(width: 10),
                  Text(
                    text,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 14,
                  ),
                  Container(
                    width: 02,
                    height: 50,
                    color: Colors.blue,
                  ),
                  SizedBox(width: 20),
                  Icon(transport),
                ],
              )
            ],
            ),
        );
    }
}
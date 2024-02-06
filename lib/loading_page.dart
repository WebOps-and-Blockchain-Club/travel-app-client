import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage("image/img.png"),opacity:0.50)
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),

              child: Column(
                children: [
                  Text("The world is a book and those who do not travel read only one page.\n― St. Augustine",style: TextStyle(
                      fontSize: 50, fontWeight: FontWeight.bold,fontStyle: FontStyle.italic
                  ),),
                  AnimatedContainer(duration: Duration(seconds: 5),curve: Curves.bounceIn,child: Image(image: NetworkImage("https://image.freepik.com/free-vector/set-hand-drawn-travel-doodle_40453-831.jpg"),),)
                ],
              ),
            ),
          ),
        ),
      ), // You can use any loading widget here.
    );
  }
}

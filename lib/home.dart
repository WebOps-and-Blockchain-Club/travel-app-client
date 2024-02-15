import 'package:flutter/material.dart';
import 'package:travel_app_client/viewprofile.dart';
import 'profile.dart';
import 'airways.dart';
import 'loading_page.dart';
import 'package:localstorage/localstorage.dart';

final storage = LocalStorage('auth');
dynamic nameData = storage.getItem('name');
Set<String> name = nameData != null ? Set.from([nameData]) : {};

class MyAppHome extends StatefulWidget {
  @override
  State<MyAppHome> createState() => _MyAppHomeState();
}

class _MyAppHomeState extends State<MyAppHome> {
  bool isLoading = false;

  // Simulate a loading delay (you can replace this with your actual loading logic).
  Future<void> simulateLoading() async {
    setState(() {
      isLoading = true;
    });
    await Future.delayed(
        Duration(milliseconds: 100)); // Simulate a 2-second loading delay.
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Home',
        home: Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              items: [
                const BottomNavigationBarItem(
                    label: "", icon: Icon(Icons.home)),
                const BottomNavigationBarItem(
                    label: "", icon: Icon(Icons.search)),
                BottomNavigationBarItem(
                    label: "",
                    icon: IconButton(
                        onPressed: () {
                          print('pressed');
                          Navigator.pushNamed(context, '/profile');
                        },
                        icon: Icon(Icons.account_box_rounded)))
              ],
            ),
            appBar: AppBar(
              backgroundColor: Color.fromRGBO(142, 9, 219, 0.337),
              foregroundColor: Color.fromARGB(255, 255, 255, 255),
              title: const Text("Home"),
              leading:
                  IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  isLoading ? LoadingPage() : viewProfile()));
                    },
                    icon: const Icon(Icons.account_circle))
              ],
              elevation: 0,
            ),
            extendBodyBehindAppBar: false,
            body: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                // height: double.infinity,
                decoration: const BoxDecoration(
                    // image: DecorationImage(
                    //   image: AssetImage("assets/images/"),
                    //   fit: BoxFit.fill,
                    // ),
                    ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              "Hello $name,What are you looking for?",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          width: 300,
                          height: 40),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  color: Color.fromARGB(255, 199, 156, 228),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    "Travel Points\n 200",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                width: 150,
                                height: 75),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: Color.fromARGB(255, 199, 156, 228),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  "Cities Visited\n 5",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              width: 150,
                              height: 75,
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: GestureDetector(
                              onTap: () {
                                simulateLoading();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => isLoading
                                            ? LoadingPage()
                                            : SecondRoute()));
                              },
                              child: Container(
                                height: 150,
                                width: 150,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  shape: BoxShape.rectangle,
                                ),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Image(
                                        image: AssetImage(
                                            "assets/images/airways.jpg"),
                                        height: 75,
                                        width: 75,
                                      ),
                                    ),
                                    Text(
                                      "Airways",
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: GestureDetector(
                              onTap: () {},
                              child: Container(
                                width: 150,
                                height: 150,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  shape: BoxShape.rectangle,
                                ),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Image(
                                          image: AssetImage(
                                              "assets/images/railways.jpg"),
                                          height: 75,
                                          width: 75),
                                    ),
                                    Text(
                                      "Railways",
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: GestureDetector(
                              onTap: () {},
                              child: Container(
                                width: 150,
                                height: 150,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  shape: BoxShape.rectangle,
                                ),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Image(
                                        image: AssetImage(
                                            "assets/images/roadways.jpg"),
                                        height: 75,
                                        width: 75,
                                      ),
                                    ),
                                    Text(
                                      "Cars/Buses",
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: GestureDetector(
                              onTap: () {},
                              child: Container(
                                width: 150,
                                height: 150,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  shape: BoxShape.rectangle,
                                ),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Image(
                                          image: AssetImage(
                                              "assets/images/hotels.jpg"),
                                          height: 75,
                                          width: 75),
                                    ),
                                    Text(
                                      "Hotels",
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )));
  }
}

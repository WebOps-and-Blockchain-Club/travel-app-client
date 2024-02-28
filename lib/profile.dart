import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import 'package:travel_app_client/Screens/Login/components/login_form.dart';
import 'package:travel_app_client/Screens/Login/login_screen.dart';
import 'package:travel_app_client/viewprofile.dart';
import 'home.dart';

final storage = LocalStorage('auth');

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Profile Page',
      home: ProfilePage2(),
    );
  }
}

class ProfilePage2 extends StatelessWidget {
  DateTime? selectedDate;

  ProfilePage2({Key? key});

  TextEditingController nameController = TextEditingController();
  TextEditingController nationalityController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> saveProfileData() async {
    final url = Uri.parse("http://10.0.2.2:3000/register");
    print({
      nameController.text,
      nationalityController.text,
      passwordController.text,
      cityController.text
    });
    try {
      final response = await http.post(
        headers: {"Content-Type": "application/json"},
        url,
        body: json.encode({
          'name': nameController.text,
          'nationality': nationalityController.text,
          'city': cityController.text,
          'address': addressController.text,
          'state': stateController.text,
          'email': emailController.text,
          'phone_number': phoneNumberController.text,
          'dob': selectedDate?.toIso8601String(),
          'password': passwordController.text // Replace with an actual password
        }),
      );

      final response1 = await http.get(url);
      if (response.statusCode == 200) {
        // Data successfully sent to the backend
        // Handle success accordingly
        print("Data added successfully");
        final data = jsonDecode(response.body);
        await storage.setItem('token', data['token']);
      } else {
        // Handle errors if any
        print("Error: ${response.body}");
      }
    } catch (error) {
      // Handle general errors
      print("Error: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(142, 9, 219, 0.337),
          foregroundColor: Color.fromARGB(255, 255, 255, 255),
          title: const Text('Sign Up !!'),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: ""),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: ""),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_box_rounded),
              label: "",
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                shape: BoxShape.rectangle,
              ),
              padding: EdgeInsets.all(30),
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(142, 9, 219, 0.337),
                  borderRadius: BorderRadius.circular(10),
                  shape: BoxShape.rectangle,
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(padding: EdgeInsets.all(10)),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Padding(
                              padding: EdgeInsets.fromLTRB(100, 10, 50, 20)),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              color: Colors.white,
                              width: 200,
                              child: TextField(
                                controller: nameController,
                                decoration: InputDecoration(
                                    hintText: "NAME",
                                    contentPadding: EdgeInsets.all(1)),
                                clipBehavior: Clip.antiAlias,
                                style: TextStyle(backgroundColor: Colors.white),
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text("Date Of Birth"),
                          ),
                          // GestureDetector(
                          //   child: new Icon(Icons.calendar_today,size: 50),
                          //
                          //   onTap: (){DatePickerDialog(initialDate: new DateTime.now(), firstDate: new DateTime(1900), lastDate:new DateTime(2100),fieldHintText: "Date Of Birth", );},
                          //
                          // ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: IconButton(
                              onPressed: () async {
                                DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime.now(),
                                  fieldHintText: "Date Of Birth",
                                );
                                if (pickedDate != null &&
                                    pickedDate != selectedDate) {
                                  // Update the selectedDate variable if a date is picked
                                  selectedDate = pickedDate;
                                  // You can also update your UI with the selected date if needed
                                }
                              },
                              icon: Icon(Icons.calendar_today, size: 50),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Container(
                              padding: EdgeInsets.all(1),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white,
                              ),

                              width: 200,
                              //decoration: BoxDecoration(shape: BoxShape.rectangle,borderRadius:BorderRadius.circular(10.0),color: Colors.white),
                              child: TextField(
                                controller: nationalityController,
                                decoration: InputDecoration(
                                    hintText: "Nationality",
                                    contentPadding: EdgeInsets.all(1)),
                                clipBehavior: Clip.antiAlias,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Container(
                              padding: EdgeInsets.all(1),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white,
                              ),
                              width: 200,
                              child: TextField(
                                controller: cityController,
                                decoration: InputDecoration(
                                    hintText: "City",
                                    contentPadding: EdgeInsets.all(1),
                                    disabledBorder: InputBorder.none),
                                clipBehavior: Clip.antiAlias,
                                style: TextStyle(backgroundColor: Colors.white),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              padding: EdgeInsets.all(1),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white,
                              ),
                              width: 250,
                              child: TextField(
                                controller: addressController,
                                decoration: InputDecoration(
                                    hintText: "Address",
                                    contentPadding: EdgeInsets.all(1)),
                                clipBehavior: Clip.antiAlias,
                                style: TextStyle(backgroundColor: Colors.white),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white,
                              ),
                              width: 150,
                              child: TextField(
                                controller: stateController,
                                decoration: InputDecoration(
                                    hintText: "State",
                                    contentPadding: EdgeInsets.all(1)),
                                clipBehavior: Clip.antiAlias,
                                style: TextStyle(backgroundColor: Colors.white),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              padding: EdgeInsets.all(1),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white,
                              ),
                              width: 250,
                              child: TextField(
                                controller: emailController,
                                decoration: InputDecoration(
                                    hintText: "Email ID",
                                    contentPadding: EdgeInsets.all(1)),
                                clipBehavior: Clip.antiAlias,
                                style: TextStyle(backgroundColor: Colors.white),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Container(
                              padding: EdgeInsets.all(1),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white,
                              ),
                              width: 200,
                              child: TextField(
                                controller: passwordController,
                                obscureText: true,
                                decoration: InputDecoration(
                                    hintText: "Password",
                                    contentPadding: EdgeInsets.all(1),
                                    disabledBorder: InputBorder.none),
                                clipBehavior: Clip.antiAlias,
                                style: TextStyle(backgroundColor: Colors.white),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              padding: EdgeInsets.all(1),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white,
                              ),
                              width: 250,
                              child: TextField(
                                controller: phoneNumberController,
                                decoration: InputDecoration(
                                    hintText: "Phone Number",
                                    contentPadding: EdgeInsets.all(1)),
                                clipBehavior: Clip.antiAlias,
                                style: TextStyle(backgroundColor: Colors.white),
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              saveProfileData(); // Call function to send data to backend
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginScreen()),
                              );
                            },
                            child: Text("SAVE"),
                          ),
                        ],
                      ),
                    ]),
              ),
            ),
          ),
        ));
  }
}

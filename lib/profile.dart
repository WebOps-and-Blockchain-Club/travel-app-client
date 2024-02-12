import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'home.dart';

void main() => runApp(const Profile());

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
  // TextEditingController genderController = TextEditingController();
  TextEditingController nationalityController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> saveProfileData() async {
    final url = Uri.parse("http://10.0.2.2:3000/register");
    // final oneurl =Uri.parse("http://localhost:3000/register");
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
          'password': passwordController.text // Replace with an actual password
        }),
      );

      final response1 = await http.get(url);
      if (response.statusCode == 200) {
        // Data successfully sent to the backend
        // Handle success accordingly
        print("Data added successfully");
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
          backgroundColor: const Color.fromRGBO(0, 169, 224, 0.34),
          leading: BackButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyAppHome()),
              );
            },
          ),
          title: const Text('Profile'),
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
                  color: const Color.fromRGBO(0, 169, 224, 0.34),
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
                            child: Row(
                              children: [
                                Padding(padding: EdgeInsets.all(30)),
                                IconButton(
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              content: const Text(
                                                  "Do you want to change your profile..Else Enter Back"),
                                              actions: [
                                                TextButton(
                                                  child: const Text("Yes"),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ],
                                            );
                                          });
                                    },
                                    icon: const ImageIcon(NetworkImage(
                                        "https://clipground.com/images/profile-png-5.png")),
                                    iconSize: 60,
                                    splashColor: Colors.deepPurple),
                                // Add your profile image here
                                TextButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            content: const Text(
                                                "Do you want to save changes..Else Enter Back"),
                                            actions: [
                                              TextButton(
                                                child: const Text("Yes"),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          );
                                        });
                                  },
                                  child: const Text("          SAVE",
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w600,
                                        height: 0.08,
                                        letterSpacing: 2.97,
                                      )),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              color: Colors.white,
                              height: 50,
                              width: 200,
                              child: TextField(
                                controller: nameController,
                                decoration: InputDecoration(
                                    hintText: "NAME",
                                    contentPadding: EdgeInsets.all(1)),
                                clipBehavior: Clip.antiAlias,
                                style: TextStyle(
                                    backgroundColor: Colors.white, height: 3),
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
                              color: Colors.white,
                              height: 50,
                              width: 200,
                              //decoration: BoxDecoration(shape: BoxShape.rectangle,borderRadius:BorderRadius.circular(10.0),color: Colors.white),
                              child: TextField(
                                controller: nationalityController,
                                decoration: InputDecoration(
                                    hintText: "Nationality",
                                    contentPadding: EdgeInsets.all(1)),
                                clipBehavior: Clip.antiAlias,
                                style: TextStyle(height: 3),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Container(
                              padding: EdgeInsets.all(1),
                              color: Colors.white,
                              height: 50,
                              width: 200,
                              child: TextField(
                                controller: cityController,
                                decoration: InputDecoration(
                                    hintText: "City",
                                    contentPadding: EdgeInsets.all(1),
                                    disabledBorder: InputBorder.none),
                                clipBehavior: Clip.antiAlias,
                                style: TextStyle(
                                    backgroundColor: Colors.white, height: 3),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              padding: EdgeInsets.all(1),
                              color: Colors.white,
                              height: 50,
                              width: 250,
                              child: TextField(
                                controller: addressController,
                                decoration: InputDecoration(
                                    hintText: "Address",
                                    contentPadding: EdgeInsets.all(1)),
                                clipBehavior: Clip.antiAlias,
                                style: TextStyle(
                                    backgroundColor: Colors.white, height: 3),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              color: Colors.white,
                              height: 50,
                              width: 150,
                              child: TextField(
                                controller: stateController,
                                decoration: InputDecoration(
                                    hintText: "State",
                                    contentPadding: EdgeInsets.all(1)),
                                clipBehavior: Clip.antiAlias,
                                style: TextStyle(
                                    backgroundColor: Colors.white, height: 3),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              padding: EdgeInsets.all(1),
                              color: Colors.white,
                              height: 50,
                              width: 250,
                              child: TextField(
                                controller: emailController,
                                decoration: InputDecoration(
                                    hintText: "Email ID",
                                    contentPadding: EdgeInsets.all(1)),
                                clipBehavior: Clip.antiAlias,
                                style: TextStyle(
                                    backgroundColor: Colors.white, height: 3),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Container(
                              padding: EdgeInsets.all(1),
                              color: Colors.white,
                              height: 50,
                              width: 200,
                              child: TextField(
                                controller: passwordController,
                                decoration: InputDecoration(
                                    hintText: "Password",
                                    contentPadding: EdgeInsets.all(1),
                                    disabledBorder: InputBorder.none),
                                clipBehavior: Clip.antiAlias,
                                style: TextStyle(
                                    backgroundColor: Colors.white, height: 3),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              padding: EdgeInsets.all(1),
                              color: Colors.white,
                              height: 50,
                              width: 250,
                              child: TextField(
                                controller: phoneNumberController,
                                decoration: InputDecoration(
                                    hintText: "Phone Number",
                                    contentPadding: EdgeInsets.all(1)),
                                clipBehavior: Clip.antiAlias,
                                style: TextStyle(
                                    backgroundColor: Colors.white, height: 3),
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              saveProfileData(); // Call function to send data to backend
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



// import 'package:flutter/material.dart';
// import 'package:traveltrial/home.dart';
// import 'package:http/http.dart' as http;
//
// void main() => runApp(const Profile());
// class Profile extends StatelessWidget {
//   const Profile({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Profile Page',
//       home: ProfilePage2(),
//     );
//   }
// }
//
// class ProfilePage2 extends StatelessWidget {
//   DateTime? selectedDate;
//
//   ProfilePage2({Key? key});
//
//   TextEditingController nameController = TextEditingController();
//   TextEditingController genderController = TextEditingController();
//   TextEditingController nationalityController = TextEditingController();
//   TextEditingController cityController = TextEditingController();
//   TextEditingController addressController = TextEditingController();
//   TextEditingController stateController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//   TextEditingController phoneNumberController = TextEditingController();
//
//   Future<void> saveProfileData() async {
//     final url = Uri.parse("http://localhost:3000/addData"); // Replace with your backend API endpoint
//
//     final response = await http.post(
//       url,
//       body: {
//         'username': nameController.text,
//         'gender': genderController.text,
//         'nationality': nationalityController.text,
//         'city': cityController.text,
//         'address': addressController.text,
//         'state': stateController.text,
//         'email': emailController.text,
//         'phone': phoneNumberController.text,
//       },
//     );
//     @override
//     Widget build(BuildContext context) {
//       return Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           backgroundColor: const Color.fromRGBO(0, 169, 224, 0.34),
//           leading: BackButton(onPressed: () {
//             Navigator.push(
//                 context, MaterialPageRoute(builder: (context) => MyAppHome()));
//             ;
//           }),
//           title: const Text('Profile'),
//           // leading: Padding(
//           //   padding: const EdgeInsets.all(10.0),
//           //   child: ElevatedButton.icon(
//           //     onPressed: () {},
//           //     icon: const Icon(Icons.arrow_circle_left),
//           //     label: const Text("Back"),
//           //   ),
//           // ),
//         ),
//         bottomNavigationBar: BottomNavigationBar(
//           items: const [
//             BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: ""),
//             BottomNavigationBarItem(icon: Icon(Icons.search), label: ""),
//             BottomNavigationBarItem(
//                 icon: Icon(Icons.account_box_rounded), label: "")
//           ],
//         ),
//         body: SingleChildScrollView(
//           child: SafeArea(
//             child: Container(
//               decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(10),
//                   shape: BoxShape.rectangle),
//               padding: EdgeInsets.all(30),
//               child: Container(
//                 decoration: BoxDecoration(
//                     color: const Color.fromRGBO(0, 169, 224, 0.34),
//                     borderRadius: BorderRadius.circular(10),
//                     shape: BoxShape.rectangle),
//
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Padding(padding: EdgeInsets.all(10)),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         const Padding(padding: EdgeInsets.fromLTRB(100, 10, 50,
//                             20)),
//                         Padding(
//                           padding: const EdgeInsets.all(10.0),
//                           child: Row(
//                             children: [
//                               Padding(padding: EdgeInsets.all(30)),
//                               IconButton(onPressed: () {
//                                 showDialog(context: context,
//                                     builder: (BuildContext context) {
//                                       return AlertDialog(
//                                         content: const Text(
//                                             "Do you want to change your profile..Else Enter Back"),
//                                         actions: [
//                                           TextButton(
//                                             child: const Text("Yes"),
//                                             onPressed: () {
//                                               Navigator.of(context).pop();
//                                             },
//                                           ),
//                                         ],
//                                       );
//                                     });
//                               },
//                                   icon: const ImageIcon(NetworkImage(
//                                       "https://clipground.com/images/profile-png-5.png")),
//                                   iconSize: 60,
//                                   splashColor: Colors.deepPurple),
//                               // Add your profile image here
//                               TextButton(onPressed: () {
//                                 showDialog(context: context,
//                                     builder: (BuildContext context) {
//                                       return AlertDialog(
//                                         content: const Text(
//                                             "Do you want to save changes..Else Enter Back"),
//                                         actions: [
//                                           TextButton(
//                                             child: const Text("Yes"),
//                                             onPressed: () {
//                                               Navigator.of(context).pop();
//                                             },
//                                           ),
//                                         ],
//                                       );
//                                     });
//                               },
//                                 child: const Text(
//                                     "          SAVE", textAlign: TextAlign.end,
//                                     style: TextStyle(
//                                       color: Colors.white,
//                                       fontSize: 18,
//                                       fontFamily: 'Inter',
//                                       fontWeight: FontWeight.w600,
//                                       height: 0.08,
//                                       letterSpacing: 2.97,)),
//                               ),
//
//                             ],
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(10.0),
//                           child: Container(
//
//                             color: Colors.white,
//                             height: 50,
//                             width: 200,
//                             child: TextField(
//                               controller: nameController,
//                               decoration: InputDecoration(hintText: "NAME",
//                                   contentPadding: EdgeInsets.all(1)),
//                               clipBehavior: Clip.antiAlias,
//                               style: TextStyle(
//                                   backgroundColor: Colors.white, height: 3),
//                             ),
//                           ),
//                         ),
//                         const Padding(
//                           padding: EdgeInsets.all(10.0),
//                           child: Text("Date Of Birth"),
//                         ),
//                         // GestureDetector(
//                         //   child: new Icon(Icons.calendar_today,size: 50),
//                         //
//                         //   onTap: (){DatePickerDialog(initialDate: new DateTime.now(), firstDate: new DateTime(1900), lastDate:new DateTime(2100),fieldHintText: "Date Of Birth", );},
//                         //
//                         // ),
//                         Padding(
//                           padding: const EdgeInsets.all(10.0),
//                           child: IconButton(
//                             onPressed: () async {
//                               DateTime? pickedDate = await showDatePicker(
//                                 context: context,
//                                 initialDate: DateTime.now(),
//                                 firstDate: DateTime(1900),
//                                 lastDate: DateTime.now(),
//                                 fieldHintText: "Date Of Birth",
//                               );
//                               if (pickedDate != null &&
//                                   pickedDate != selectedDate) {
//                                 // Update the selectedDate variable if a date is picked
//                                 selectedDate = pickedDate;
//                                 // You can also update your UI with the selected date if needed
//                               }
//                             },
//                             icon: Icon(Icons.calendar_today, size: 50),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(10.0),
//                           child: Container(
//                             padding: EdgeInsets.all(1),
//                             color: Colors.white,
//                             height: 50,
//                             width: 200,
//                             child: TextField(
//                               controller: genderController,
//                               decoration: InputDecoration(hintText: "Gender",
//                                   contentPadding: EdgeInsets.all(1)),
//                               clipBehavior: Clip.antiAlias,
//                               style: TextStyle(
//                                   backgroundColor: Colors.white, height: 3),
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.all(10.0),
//                           child: Container(
//                             padding: EdgeInsets.all(1),
//                             color: Colors.white,
//                             height: 50,
//                             width: 200,
//                             //decoration: BoxDecoration(shape: BoxShape.rectangle,borderRadius:BorderRadius.circular(10.0),color: Colors.white),
//                             child: TextField(
//                               controller: nationalityController,
//                               decoration: InputDecoration(
//                                   hintText: "Nationality",
//                                   contentPadding: EdgeInsets.all(1)),
//                               clipBehavior: Clip.antiAlias,
//                               style: TextStyle(height: 3),
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.all(10.0),
//                           child: Container(
//                             padding: EdgeInsets.all(1),
//                             color: Colors.white,
//                             height: 50,
//                             width: 200,
//                             child: TextField(
//                               controller: cityController,
//                               decoration: InputDecoration(hintText: "City",
//                                   contentPadding: EdgeInsets.all(1),
//                                   disabledBorder: InputBorder.none),
//                               clipBehavior: Clip.antiAlias,
//                               style: TextStyle(
//                                   backgroundColor: Colors.white, height: 3),
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(10.0),
//                           child: Container(
//                             padding: EdgeInsets.all(1),
//                             color: Colors.white,
//                             height: 50,
//                             width: 250,
//                             child: TextField(
//                               controller: addressController,
//                               decoration: InputDecoration(hintText: "Address",
//                                   contentPadding: EdgeInsets.all(1)),
//                               clipBehavior: Clip.antiAlias,
//                               style: TextStyle(
//                                   backgroundColor: Colors.white, height: 3),
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Container(
//                             color: Colors.white,
//                             height: 50,
//                             width: 150,
//                             child: TextField(
//                               controller: stateController,
//                               decoration: InputDecoration(hintText: "State",
//                                   contentPadding: EdgeInsets.all(1)),
//                               clipBehavior: Clip.antiAlias,
//                               style: TextStyle(
//                                   backgroundColor: Colors.white, height: 3),
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(10.0),
//                           child: Container(
//                             padding: EdgeInsets.all(1),
//                             color: Colors.white,
//                             height: 50,
//                             width: 250,
//                             child: TextField(
//                               controller: emailController,
//                               decoration: InputDecoration(hintText: "Email ID",
//                                   contentPadding: EdgeInsets.all(1)),
//                               clipBehavior: Clip.antiAlias,
//                               style: TextStyle(
//                                   backgroundColor: Colors.white, height: 3),
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(10.0),
//                           child: Container(
//                             padding: EdgeInsets.all(1),
//                             color: Colors.white,
//                             height: 50,
//                             width: 250,
//                             child: TextField(
//                               controller: phoneNumberController,
//                               decoration: InputDecoration(
//                                   hintText: "Phone Number",
//                                   contentPadding: EdgeInsets.all(1)),
//                               clipBehavior: Clip.antiAlias,
//                               style: TextStyle(
//                                   backgroundColor: Colors.white, height: 3),
//                             ),
//
//
//                           ),
//                         ),
//                         ElevatedButton(
//                           onPressed: () {
//                             saveProfileData(); // Call function to send data to backend
//                           },
//                           child: Text("SAVE"),
//                         ),
//
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     throw UnimplementedError();
//   }}



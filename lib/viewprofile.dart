//viewprofile.dart                                                                                                                             import 'dart:convert';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import 'package:travel_app_client/home.dart';
import 'package:travel_app_client/profile.dart';
import 'package:travel_app_client/themes/viewprofiletheme.dart';

final storage = LocalStorage('auth');

void main() => runApp(const viewProfile());

class viewProfile extends StatelessWidget {
  const viewProfile({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "VIEW PROFILE",
      home: view_profile(),
    );
  }
}

class view_profile extends StatefulWidget {
  const view_profile({Key? key}) : super(key: key);

  @override
  State<view_profile> createState() => _view_profileState();
}

class _view_profileState extends State<view_profile> {
  String name = '';
  String email = '';
  String nationality = '';
  String state = '';
  String city = '';
  String address = '';
  String phoneNumber = '';
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    final url = Uri.parse('http://10.0.2.2:3000/viewprofile');
    print('hreeeee');
    try {
      final response = await http.get(url, headers: {
        "Content-Type": "application/json",
        HttpHeaders.authorizationHeader.toString():
            await storage.getItem('token')
      });
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print(data);
        setState(() {
          name = data['name'];
          email = data['email'];
          nationality = data['nationality'];
          state = data['state'];
          city = data['city'];
          address = data['address'];
          phoneNumber = data['phone_number'];
        });
      } else {
        // Handle errors if any
        print('Error: ${response.body}');
      }
    } catch (error) {
      // Handle general errors
      print('Error: $error');
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
                MaterialPageRoute(builder: (context) => Profile()),
              );
            },
          ),
          title: const Text('View Profile'),
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Padding(
                        padding: EdgeInsets.fromLTRB(100, 10, 50, 20)),
                    CustomTextFormField(label: "Name", entry: name),
                    CustomTextFormField(label: "email", entry: email),
                    CustomTextFormField(
                        label: "nationality", entry: nationality),
                    CustomTextFormField(label: "state", entry: state),
                    CustomTextFormField(label: "city", entry: city),
                    CustomTextFormField(label: "address", entry: address),
                    CustomTextFormField(
                        label: "phone number", entry: phoneNumber),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}

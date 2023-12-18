import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:travel_app_client/info.dart';
import 'package:travel_app_client/models/flights.dart';
import 'package:http/http.dart' as http;
import 'cards/flight-card.dart';

class Flights extends StatefulWidget {
  const Flights({Key? key}) : super(key: key);

  @override
  State<Flights> createState() => _FlightsState();
}

class _FlightsState extends State<Flights> {


  bool? isChecked = false;


  List flightsData = [];


  Map<String, List<Flight>> flights = {
    "Chennai" : [
      Flight(company: "Air India", price: "15,086", dep: "Chennai",arr: "Bengaluru",depTime:  DateTime(2023, 12, 31, 20, 50), arrTime:  DateTime(2023, 12, 31, 00, 30)),
      Flight(company: "Indigo", price: "17,086", dep: "Chennai",arr: "Delhi", depTime:  DateTime(2023, 12, 31, 09, 00), arrTime:  DateTime(2023, 12, 31, 12, 00)),
      Flight(company: "Vistara", price: "19,086",dep: "Chennai", arr: "Mumbai",depTime:  DateTime(2023, 12, 31, 18, 45), arrTime:  DateTime(2023, 12, 31, 15, 45)),
    ],
    "Bengaluru" : [
      Flight(company: "Air India", price: "15,086",dep: "Bengaluru", arr: "Chennai",depTime:  DateTime(2023, 12, 31, 20, 50), arrTime:  DateTime(2023, 12, 31, 00, 30)),
      Flight(company: "Indigo", price: "17,086", dep: "Bengaluru", arr: "Mumbai",depTime:  DateTime(2023, 12, 31, 09, 00), arrTime:  DateTime(2023, 12, 31, 12, 00)),
      Flight(company: "Vistara", price: "19,086", dep: "Bengaluru", arr: "Delhi",depTime:  DateTime(2023, 12, 31, 18, 45), arrTime:  DateTime(2023, 12, 31, 15, 45)),
    ],
    "Mumbai" : [
      Flight(company: "Air India", price: "15,086", dep: "Mumbai", arr: "Chennai",depTime:  DateTime(2023, 12, 31, 20, 50), arrTime:  DateTime(2023, 12, 31, 00, 30)),
      Flight(company: "Indigo", price: "17,086",dep: "Mumbai",  arr: "Delhi",depTime:  DateTime(2023, 12, 31, 09, 00), arrTime:  DateTime(2023, 12, 31, 12, 00)),
      Flight(company: "Vistara", price: "19,086", dep: "Mumbai", arr: "Bengaluru",depTime:  DateTime(2023, 12, 31, 18, 45), arrTime:  DateTime(2023, 12, 31, 15, 45)),
    ],
    "Delhi" : [
      Flight(company: "Air India", price: "15,086", dep: "Delhi", arr: "Bengaluru",depTime:  DateTime(2023, 12, 31, 20, 50), arrTime:  DateTime(2023, 12, 31, 00, 30)),
      Flight(company: "Indigo", price: "17,086", dep: "Delhi",arr: "Mumbai",depTime:  DateTime(2023, 12, 31, 09, 00), arrTime:  DateTime(2023, 12, 31, 12, 00)),
      Flight(company: "Vistara", price: "19,086", dep: "Delhi",arr: "Chennai",depTime:  DateTime(2023, 12, 31, 18, 45), arrTime:  DateTime(2023, 12, 31, 15, 45)),
    ],
  };

  TextEditingController from = TextEditingController();
  TextEditingController to = TextEditingController();
  TextEditingController people = TextEditingController();


  Map<String, dynamic> filters = {
    "Price": false,
    "Duration": false,
    "people" : 1,
    "class": "First Class",
    "airlines" : "",
  };

  List<String> classes = [
    'First Class',
    'Business Class',
    'Economy Class',
    'Premium Economy'
  ];

  late String dep = '';
  late String arr = '';
  String? depDate;
  String? arrDate;

  DateTime today = DateTime.now();


  TextEditingController dateInput = TextEditingController();

  @override
  void initState() {
    dateInput.text = "";
    // fetchBookingData(dep, arr, depDate, arrDate);
    super.initState();
  }




  @override
  Widget build(BuildContext context) {

    MediaQueryData queryData;
    queryData = MediaQuery.of(context);


    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // fetchData(dep, arr);

          // fetchFlightDestinations();

          // fetchFlightPrice(dep, arr);

          // fetchAccessToken();
          // fetchFlightDestinations();

          // fetchAirportData();

          fetchBookingData(dep, arr,dateInput.text,'');

          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => AwesomeDropdownExample()),
          // );
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => MyApp()),
          // );

        },

      ),
      backgroundColor: Colors.lightBlueAccent,
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        title: const Text(
          "Flights",
          style: TextStyle(
            fontFamily: "Poppins-Regular",
            fontWeight: FontWeight.w800,
            fontSize: 30,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 0.065*queryData.size.height,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(bottomRight: Radius.circular(18), bottomLeft: Radius.circular(18)),
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (dialogContext) {
                              return StatefulBuilder(builder: (stfContext, stfSetState) {
                                return AlertDialog(
                                  title: const Center(
                                    child: Text(
                                      "Booking Calendar",
                                    ),
                                  ),
                                  content: Container(
                                    height: 0.4*queryData.size.height,
                                    width: 0.8*queryData.size.width,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(18),
                                      color: Colors.white,
                                    ),
                                    child: const Center(
                                      child: Text(
                                        "This will be for showing user's booked flights along with the dates with low/high ticket prices"
                                      ),
                                    ),
                                  ),
                                );
                              });
                            },
                          );
                        },
                        icon: const Icon(Icons.calendar_today_rounded,)
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (dialogContext) {
                                  return StatefulBuilder(builder: (stfContext, stfSetState) {
                                    return AlertDialog(
                                      title: const Center(
                                        child: Text(
                                          "Filters",
                                        ),
                                      ),
                                      content: Container(
                                        height: 0.4*queryData.size.height,
                                        width: 0.8*queryData.size.width,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(18),
                                          color: Colors.white,
                                        ),
                                        child: ListView(
                                          children: [
                                            CheckboxListTile(
                                                value: filters["Price"],
                                                onChanged: (newValue) {
                                                  stfSetState(() {
                                                    filters["Price"] = newValue!;
                                                  });
                                                },
                                              title: const Text(
                                                "Price",
                                                style: TextStyle(
                                                  fontFamily: "Poppins-Regular",
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            CheckboxListTile(
                                              value: filters["Duration"],
                                              onChanged: (newValue) {
                                                stfSetState(() {
                                                  filters["Duration"] = newValue!;
                                                });
                                              },
                                              title: const Text(
                                                "Duration",
                                                style: TextStyle(
                                                  fontFamily: "Poppins-Regular",
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(left: 0.05*0.8*queryData.size.width, right: 0.05*0.08*queryData.size.height ),
                                              child: SizedBox(
                                                width: queryData.size.width*0.8,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    const Text(
                                                      "People",
                                                      style: TextStyle(
                                                        fontFamily: "Poppins-Regular",
                                                        fontSize: 22,
                                                        fontWeight: FontWeight.w600,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: queryData.size.height*0.4*0.15,
                                                        width: queryData.size.width*0.8*0.2,
                                                        child: TextField(
                                                          textAlign: TextAlign.center,
                                                          controller: people,
                                                          onChanged: (value) {
                                                            setState(() {
                                                              filters["people"] =
                                                                  people;
                                                            });
                                                          }
                                                        )
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(left: 0.05*0.8*queryData.size.width, right: 0.05*0.08*queryData.size.height ),
                                              child: Center(
                                                child: DropdownButtonFormField<String>(
                                                  value: filters["class"],
                                                  style: TextStyle(
                                                    fontFamily: "Poppins-Regular",
                                                    fontSize: 0.23*0.08*queryData.size.height,
                                                    color: Colors.black,
                                                  ),
                                                  decoration: const InputDecoration(
                                                    border: InputBorder.none,
                                                  ),
                                                  items: classes.map((String item) {
                                                    return DropdownMenuItem<String>(
                                                      value: item,
                                                      child: Text(item),
                                                    );
                                                  }).toList(),
                                                  onChanged: (String? newValue) {
                                                    setState(() {
                                                      filters["class"] = newValue;
                                                    });
                                                  },
                                                ),
                                              ),
                                            ),

                                          ]
                                        ),
                                      ),
                                    );
                                  });
                                },
                              );
                            },
                            icon: const Icon(Icons.filter_alt,)
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (dialogContext) {
                                return StatefulBuilder(builder: (stfContext, stfSetState) {
                                  return AlertDialog(
                                    title: const Center(
                                      child: Text(
                                        "Your Bookings",
                                      ),
                                    ),
                                    content: Container(
                                      height: 0.4*queryData.size.height,
                                      width: 0.8*queryData.size.width,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(18),
                                        color: Colors.white,
                                      ),
                                      // child: ListView(
                                      //     children: [
                                      //       CheckboxListTile(
                                      //         value: filters["Price"],
                                      //         onChanged: (newValue) {
                                      //           stfSetState(() {
                                      //             filters["Price"] = newValue!;
                                      //           });
                                      //         },
                                      //         title: Text(
                                      //           "Price",
                                      //           style: TextStyle(
                                      //             fontFamily: "Poppins-Regular",
                                      //             fontSize: 22,
                                      //             fontWeight: FontWeight.w600,
                                      //           ),
                                      //         ),
                                      //       ),
                                      //       CheckboxListTile(
                                      //         value: filters["Duration"],
                                      //         onChanged: (newValue) {
                                      //           stfSetState(() {
                                      //             filters["Duration"] = newValue!;
                                      //           });
                                      //         },
                                      //         title: Text(
                                      //           "Duration",
                                      //           style: TextStyle(
                                      //             fontFamily: "Poppins-Regular",
                                      //             fontSize: 22,
                                      //             fontWeight: FontWeight.w600,
                                      //           ),
                                      //         ),
                                      //       ),
                                      //       Padding(
                                      //         padding: EdgeInsets.only(left: 0.05*0.8*queryData.size.width, right: 0.05*0.08*queryData.size.height ),
                                      //         child: Container(
                                      //           width: queryData.size.width*0.8,
                                      //           child: Row(
                                      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      //             children: [
                                      //               Text(
                                      //                 "People",
                                      //                 style: TextStyle(
                                      //                   fontFamily: "Poppins-Regular",
                                      //                   fontSize: 22,
                                      //                   fontWeight: FontWeight.w600,
                                      //                 ),
                                      //               ),
                                      //               Container(
                                      //                   height: queryData.size.height*0.4*0.15,
                                      //                   width: queryData.size.width*0.8*0.2,
                                      //                   child: TextField(
                                      //                       textAlign: TextAlign.center,
                                      //                       controller: people,
                                      //                       onChanged: (value) {
                                      //                         setState(() {
                                      //                           filters["people"] =
                                      //                               people;
                                      //                         });
                                      //                       }
                                      //                   )
                                      //               )
                                      //             ],
                                      //           ),
                                      //         ),
                                      //       ),
                                      //       Padding(
                                      //         padding: EdgeInsets.only(left: 0.05*0.8*queryData.size.width, right: 0.05*0.08*queryData.size.height ),
                                      //         child: Center(
                                      //           child: DropdownButtonFormField<String>(
                                      //             hint: Text(
                                      //               filters["class"],
                                      //               style: TextStyle(
                                      //                 fontFamily: "Poppins-Regular",
                                      //                 fontSize: 22,
                                      //                 fontWeight: FontWeight.w600,
                                      //               ),
                                      //             ),
                                      //             style: TextStyle(
                                      //               fontFamily: "Poppins-Regular",
                                      //               fontSize: 0.23*0.08*queryData.size.height,
                                      //               color: Colors.black,
                                      //             ),
                                      //             decoration: const InputDecoration(
                                      //               border: InputBorder.none,
                                      //             ),
                                      //             items: classes.map((String item) {
                                      //               return DropdownMenuItem<String>(
                                      //                 value: item,
                                      //                 child: Text(item),
                                      //               );
                                      //             }).toList(),
                                      //             onChanged: (String? newValue) {
                                      //               setState(() {
                                      //                 filters["class"] = newValue;
                                      //               });
                                      //             },
                                      //           ),
                                      //         ),
                                      //       ),
                                      //
                                      //     ]
                                      // ),
                                    ),
                                  );
                                });
                              },
                            );
                          },
                            icon: const Icon(
                                Icons.airplane_ticket_rounded
                            ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Container(
              height: 0.1*queryData.size.height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            color: Colors.grey[300],
                          ),
                          height: 0.06*queryData.size.height,
                          width: 0.3*queryData.size.width,
                          child: Center(
                            child: TextField(
                              onChanged: (value) {
                                setState(() {
                                  dep = value.toUpperCase();
                                });
                              },
                              textAlign: TextAlign.center,
                              controller: from,
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                              ),
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.flight_takeoff_sharp,
                          size: 40,
                          color: Colors.blue,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            color: Colors.grey[300],
                          ),
                          height: 0.06*queryData.size.height,
                          width: 0.3*queryData.size.width,
                          child: Center(
                            child: TextField(
                              onChanged: (value) {
                                setState(() {
                                  arr = value.toUpperCase();
                                });
                              },
                              textAlign: TextAlign.center,
                              controller: to,
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                  Container(
                    height: 0.07*queryData.size.height,
                    width: 1,
                    color: Colors.grey,
                  ),
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
                  )
                ],
              ),
            ),
            const SizedBox(height: 8),
            Container(
              height: 0.09*queryData.size.height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.lightBlue[100],
                        ),
                        child: const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    "MON, OCT 30",
                                    style: TextStyle(
                                      fontFamily: "Poppins-Regular",
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                "₹ 4,808",
                                style: TextStyle(
                                  fontFamily: "Poppins-Regular",
                                  color: Colors.red
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.lightBlue[100],
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Expanded(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    "MON, OCT 29",
                                    style: TextStyle(
                                      fontFamily: "Poppins-Regular",
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                "₹ 4,768",
                                style: TextStyle(
                                    fontFamily: "Poppins-Regular",
                                    color: Colors.green[800],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.lightBlue[100],
                        ),
                        child: const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    "MON, OCT 31",
                                    style: TextStyle(
                                      fontFamily: "Poppins-Regular",
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                "₹ 5,768",
                                style: TextStyle(
                                    fontFamily: "Poppins-Regular",
                                    color: Colors.red
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            // Expanded(
            //   child: flights[from.text] != null ? ListView(
            //     children: flights[from.text]!.map((e) => FlightCard(queryData: queryData, company: e.company, dep: e.dep, arr: e.arr, depTime: e.depTime, price: e.price, arrTime: e.arrTime,)).toList(),
            //   ) : Container(),
            // ),

            // Expanded(
            //   child: ListView.builder(
            //     itemCount: flightsData.length,
            //     itemBuilder: (context, index) {
            //       final item = flightsData[index];
            //       return FlightCard(
            //         queryData: queryData,
            //         company: item["airline"]["name"],
            //         dep: item["departure"]["iata"],
            //         arr: item["arrival"]["iata"],
            //         depTime: item["departure"]["scheduled"],
            //         arrTime: item["arrival"]["scheduled"],
            //         price: "10000",
            //       );
            //     },
            //   ),
            // ),

            if(dep.isNotEmpty && arr.isNotEmpty && flightsData.isEmpty) ...[
              const Center(
                  child: CircularProgressIndicator()
              )
            ],

            Expanded(
              child: ListView.builder(
                itemCount: flightsData.length,
                itemBuilder: (context, index) {
                  final item = flightsData[index];
                  return FlightCard(
                      queryData: queryData,
                      company: item["segments"][0]["legs"][0]["carriersData"][0]["name"],
                      dep: item["segments"][0]["departureAirport"]["cityName"],
                      arr: item["segments"][0]["arrivalAirport"]["cityName"],
                      depTime: item["segments"][0]["departureTime"],
                      arrTime: item["segments"][0]["arrivalTime"],
                      price: '${item["priceBreakdown"]["total"]["units"]}',
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }



  Future<void> fetchBookingData(dep, arr, depDate, arrDate) async {
    final url = Uri.https('booking-com15.p.rapidapi.com', '/api/v1/flights/searchFlights', {
      'fromId': '$dep.AIRPORT',
      'toId': '$arr.AIRPORT',
      'departDate': '$depDate',
      'returnDate': '$arrDate',
      'currency_code': 'INR',
    });

    final headers = {
      'X-RapidAPI-Key': 'cd988d1ba3msh80e5cc1cdf2241ep16817ajsn5d06bd5f5e06',
      'X-RapidAPI-Host': 'booking-com15.p.rapidapi.com',
    };

    try {
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        // print('body: ${response.body}');
        // print(data["data"]["flightOffers"]);
        // print(data["data"]["flightOffers"][0]["segments"][0]);
        print(data["data"]["flightOffers"][0]["segments"][0]["departureAirport"]["cityName"]);
        print(data["data"]["flightOffers"][0]["segments"][0]["arrivalAirport"]["cityName"]);
        print(data["data"]["flightOffers"][0]["segments"][0]["departureTime"]);
        print(data["data"]["flightOffers"][0]["segments"][0]["arrivalTime"]);
        print(data["data"]["flightOffers"][0]["segments"][0]["legs"][0]["carriersData"][0]["name"]);
        print(data["data"]["flightOffers"][0]["priceBreakdown"]["total"]["units"]);
        // print(data["data"]["flightOffers"][0]["segments"][0]["legs"][0]);

        setState(() {
          flightsData = data["data"]["flightOffers"];
        });
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }






  Avaition apiService = Avaition('87afb06edeb00b82d2f48951a0570cd5');

// Inside a function, you can make a request
  Future<void> fetchData(dep,arr) async {
    final response = await apiService.fetchData(dep,arr);

    if (response.statusCode == 200) {
      print(response);

      final data = json.decode(response.body); // Assuming the response is JSON.
      print(data["data"][1]["flight_date"]);
      setState(() {
        flightsData = data["data"];
      });

      return data;
      // Data successfully fetched, handle the response
      // You may want to parse the response JSON.
    } else {
      // print(response);
      // Handle errors, e.g., network issues or API errors
    }

    // @override
    // void initState() {
    //   super.initState();
    //   for (int i = 1;i<84;i++){
    //     getInfo('people/$i/');
    //   }
    // }


  }

  // @override
  // void initState() {
  //   super.initState();
  //   fetchBookingData(dep, arr, depDate, arrDate);
  // }
}









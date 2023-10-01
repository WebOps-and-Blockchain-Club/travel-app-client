import 'package:flutter/material.dart';
import 'package:travel_app_client/models/flights.dart';

class Flights extends StatefulWidget {
  const Flights({Key? key}) : super(key: key);

  @override
  State<Flights> createState() => _FlightsState();
}

class _FlightsState extends State<Flights> {


  bool? isChecked = false;


  Map<String, List<Flight>> flights = {
    "Chennai" : [
      Flight(company: "Air India", price: "15,086", from: "Chennai",to: "Bengaluru",departure:  DateTime(2023, 12, 31, 20, 50), landing:  DateTime(2023, 12, 31, 00, 30)),
      Flight(company: "Indigo", price: "17,086", from: "Chennai",to: "Delhi", departure:  DateTime(2023, 12, 31, 09, 00), landing:  DateTime(2023, 12, 31, 12, 00)),
      Flight(company: "Vistara", price: "19,086",from: "Chennai", to: "Mumbai",departure:  DateTime(2023, 12, 31, 18, 45), landing:  DateTime(2023, 12, 31, 15, 45)),
    ],
    "Bengaluru" : [
      Flight(company: "Air India", price: "15,086",from: "Bengaluru", to: "Chennai",departure:  DateTime(2023, 12, 31, 20, 50), landing:  DateTime(2023, 12, 31, 00, 30)),
      Flight(company: "Indigo", price: "17,086", from: "Bengaluru", to: "Mumbai",departure:  DateTime(2023, 12, 31, 09, 00), landing:  DateTime(2023, 12, 31, 12, 00)),
      Flight(company: "Vistara", price: "19,086", from: "Bengaluru", to: "Delhi",departure:  DateTime(2023, 12, 31, 18, 45), landing:  DateTime(2023, 12, 31, 15, 45)),
    ],
    "Mumbai" : [
      Flight(company: "Air India", price: "15,086", from: "Mumbai", to: "Chennai",departure:  DateTime(2023, 12, 31, 20, 50), landing:  DateTime(2023, 12, 31, 00, 30)),
      Flight(company: "Indigo", price: "17,086",from: "Mumbai",  to: "Delhi",departure:  DateTime(2023, 12, 31, 09, 00), landing:  DateTime(2023, 12, 31, 12, 00)),
      Flight(company: "Vistara", price: "19,086", from: "Mumbai", to: "Bengaluru",departure:  DateTime(2023, 12, 31, 18, 45), landing:  DateTime(2023, 12, 31, 15, 45)),
    ],
    "Delhi" : [
      Flight(company: "Air India", price: "15,086", from: "Delhi", to: "Bengaluru",departure:  DateTime(2023, 12, 31, 20, 50), landing:  DateTime(2023, 12, 31, 00, 30)),
      Flight(company: "Indigo", price: "17,086", from: "Delhi",to: "Mumbai",departure:  DateTime(2023, 12, 31, 09, 00), landing:  DateTime(2023, 12, 31, 12, 00)),
      Flight(company: "Vistara", price: "19,086", from: "Delhi",to: "Chennai",departure:  DateTime(2023, 12, 31, 18, 45), landing:  DateTime(2023, 12, 31, 15, 45)),
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
  ];



  @override
  Widget build(BuildContext context) {

    MediaQueryData queryData;
    queryData = MediaQuery.of(context);


    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      appBar: AppBar(
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
                                    child: Center(
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
                                              title: Text(
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
                                              title: Text(
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
                                              child: Container(
                                                width: queryData.size.width*0.8,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(
                                                      "People",
                                                      style: TextStyle(
                                                        fontFamily: "Poppins-Regular",
                                                        fontSize: 22,
                                                        fontWeight: FontWeight.w600,
                                                      ),
                                                    ),
                                                    Container(
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
                            icon: Icon(
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
                              textAlign: TextAlign.center,
                              controller: from,
                              style: TextStyle(
                                fontSize: 20,
                              ),
                              decoration: InputDecoration(
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
                              textAlign: TextAlign.center,
                              controller: to,
                              style: TextStyle(
                                fontSize: 20,
                              ),
                              decoration: InputDecoration(
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
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (dialogContext) {
                            return StatefulBuilder(builder: (stfContext, stfSetState) {
                              return AlertDialog(
                                title: const Center(
                                  child: Text(
                                    "Choose Date",
                                  ),
                                ),
                                content: Container(
                                  height: 0.4*queryData.size.height,
                                  width: 0.8*queryData.size.width,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(18),
                                    color: Colors.white,
                                  ),
                                  child: Center(
                                    child: Text(
                                      "This will be for choosing date of flights"
                                    ),
                                  ),
                                ),
                              );
                            });
                          },
                        );
                      },
                      icon: Icon(
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
                  // Container(
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(18),
                  //     color: Colors.grey[300],
                  //   ),
                  //   height: 0.06*queryData.size.height,
                  //   width: 0.3*queryData.size.width,
                  //   child: Center(
                  //     child: TextField(
                  //       textAlign: TextAlign.center,
                  //       controller: from,
                  //       style: TextStyle(
                  //         fontSize: 20,
                  //       ),
                  //       decoration: InputDecoration(
                  //         border: InputBorder.none,
                  //         contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // Container(
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(18),
                  //     color: Colors.grey[300],
                  //   ),
                  //   height: 0.06*queryData.size.height,
                  //   width: 0.3*queryData.size.width,
                  //   child: Center(
                  //     child: TextField(
                  //       textAlign: TextAlign.center,
                  //       controller: to,
                  //       style: TextStyle(
                  //         fontSize: 20,
                  //       ),
                  //       decoration: InputDecoration(
                  //         border: InputBorder.none,
                  //         contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: (){
                          },
                          icon: Icon(
                            Icons.circle_rounded,
                            size: 12,
                            color: Colors.red,

                          ),
                      ),
                      // Container(
                      //   width: 09.0,
                      //   height: 09.0,
                      //   margin: const EdgeInsets.symmetric(horizontal: 4.0),
                      //   decoration: BoxDecoration(
                      //     shape: BoxShape.circle,
                      //     color: Colors.blue[900]
                      //   ),
                      // ),
                      Text(
                          from.text,
                      )
                    ],
                  ),
                  IconButton(
                    onPressed: (){

                    },
                    icon: Icon(
                      Icons.add_circle,
                      color: Colors.blueAccent,
                    ),
                  ),
                  IconButton(
                    onPressed: (){

                    },
                    icon: Icon(
                      Icons.add_circle,
                      color: Colors.blueAccent,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: (){

                        },
                        icon: Icon(
                          Icons.circle,
                          size: 12,
                          color: Colors.green,
                        ),
                      ),
                      Text(
                          to.text
                      )
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: flights[from.text] != null ? ListView(
                children: flights[from.text]!.map((e) => FlightCard(queryData: queryData, company: e.company, from: e.from, to: e.to, departure: e.departure, price: e.price, landing: e.landing,)).toList(),
              ) : Container(),
            )
          ],
        ),
      ),
    );
  }
}



// ignore: must_be_immutable
class FlightCard extends StatefulWidget {
  FlightCard({
    super.key,
    required this.queryData,
    required this.company,
    required this.from,
    required this.to,
    required this.departure,
    required this.landing,
    required this.price,
    

  });

  final MediaQueryData queryData;
  String? company;
  String? from;
  String? to;
  DateTime? departure;
  DateTime? landing;
  String? price;

  @override
  State<FlightCard> createState() => _FlightCardState();
}

class _FlightCardState extends State<FlightCard> {
  @override
  Widget build(BuildContext context) {


    String formatTime(DateTime dateTime) {
      int hour = dateTime.hour;
      int minute = dateTime.minute;
      String period = 'AM';

      if (hour >= 12) {
        period = 'PM';
        if (hour > 12) {
          hour -= 12;
        }
      }

      String hourString = hour.toString().padLeft(2, '0');
      String minuteString = minute.toString().padLeft(2, '0');

      return '$hourString:$minuteString $period';
    }
    String formatDate(DateTime dateTime) {
      int day = dateTime.day;
      int month = dateTime.month;
      int year = dateTime.year;
      int hour = dateTime.hour;
      String period = 'AM';

      if (hour >= 12) {
        period = 'PM';
        if (hour > 12) {
          hour -= 12;
        }
      }

      String hourString = hour.toString().padLeft(2, '0');
      String monthString = month.toString().padLeft(2, '0');
      String dayString = day.toString().padLeft(2, '0');
      String yearString = year.toString().padLeft(2, '0');

      return '$dayString-$monthString-$yearString';
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
      child: Material(
        elevation: 2.0,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            //color: Colors.black,
          ),
          height: widget.queryData.size.height*0.165,
          width: widget.queryData.size.width*0.9,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 8, 0, 0),
                    child: Center(
                      child: SizedBox(
                        //height: widget.queryData.size.height*0.25*0.6,
                        //color: Colors.black,
                        width: widget.queryData.size.width*0.45,
                        child: Text(
                          widget.company!,
                          style: TextStyle(
                            fontFamily: "Poppins-Regular",
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 8, 20, 0),
                    child: Text(
                      widget.price!,
                      style: TextStyle(
                        fontFamily: "Poppins-Regular",
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.green,
                      ),
                    ),
                  ),



                  // SizedBox(
                  //   width: widget.queryData.size.width*0.45,
                  //   height: widget.queryData.size.height*0.25,
                  //   child: ClipRRect(
                  //     borderRadius: const BorderRadius.only(topRight: Radius.circular(18), bottomRight: Radius.circular(18)),
                  //     child: Image.asset(
                  //       widget.spotlightCardImage!,
                  //       fit: BoxFit.fill,
                  //     ),
                  //   ),
                  // )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: SizedBox(
                      //height: widget.queryData.size.height*0.25*0.6,
                      //color: Colors.black,
                      width: widget.queryData.size.width*0.4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.from!,
                            style: TextStyle(
                              fontFamily: "Poppins-Regular",
                              fontSize: 20,
                              //fontWeight: FontWeight.w600,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            formatTime(widget.departure!),
                            style: TextStyle(
                              fontFamily: "Poppins-Regular",
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Text(
                      ":",
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                    child: SizedBox(
                      //height: widget.queryData.size.height*0.25*0.6,
                      //color: Colors.black,
                      width: widget.queryData.size.width*0.4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            widget.to!,
                            style: TextStyle(
                              fontFamily: "Poppins-Regular",
                              fontSize: 20,
                              //fontWeight: FontWeight.w600,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            formatTime(widget.landing!),
                            style: TextStyle(
                              fontFamily: "Poppins-Regular",
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Icon(
                          Icons.calendar_today_rounded,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          formatDate(widget.departure!),
                          style: const TextStyle(
                            fontFamily: "Poppins-Regular",
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF1E1F29),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
                    child: Center(
                      child: Container(
                        //height: widget.queryData.size.height*0.25*0.6,
                        //color: Colors.black,
                        //width: queryData.size.width*0.45,
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          border: Border.all(
                            color: Colors.blue,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(18)
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(2.0),
                          child: Text(
                            "Recommended",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Poppins-Regular",
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}






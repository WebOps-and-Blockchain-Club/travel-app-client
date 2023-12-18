import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// ignore: must_be_immutable
class FlightCard extends StatefulWidget {
  FlightCard({
    super.key,
    required this.queryData,
    required this.company,
    required this.dep,
    required this.arr,
    required this.depTime,
    required this.arrTime,
    required this.price,


  });

  final MediaQueryData queryData;
  String? company;
  String? dep;
  String? arr;
  String? depTime;
  String? arrTime;
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

    String time(String isoString) {
      // String isoString = isoString;

      // Parse the ISO 8601 string into a DateTime object
      DateTime dateTime = DateTime.parse(isoString);

      // Format the DateTime as a time string
      String time = DateFormat.Hm().format(dateTime);

      return time;

      print(time); // Output: "08:25"
    }

    String date(isoString) {
      // String isoString = "2023-10-24T08:25:00+00:00";

      // Parse the ISO 8601 string into a DateTime object
      DateTime dateTime = DateTime.parse(isoString);

      // Format the DateTime as a date string
      String date = DateFormat.yMd().format(dateTime);

      return date;

      print(date); // Output: "10/24/2023"
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
          height: widget.queryData.size.height*0.18,
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
                          style: const TextStyle(
                            fontFamily: "Poppins-Regular",
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 8, 20, 0),
                    child: Text(
                      '₹ ${widget.price!}',
                      style: const TextStyle(
                        fontFamily: "Poppins-Regular",
                        fontSize: 17,
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
                            widget.dep!,
                            style: const TextStyle(
                              fontFamily: "Poppins-Regular",
                              fontSize: 18,
                              //fontWeight: FontWeight.w600,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            time(widget.depTime!),
                            // formatTime(widget.depTime!),
                            style: const TextStyle(
                              fontFamily: "Poppins-Regular",
                              fontSize: 18,
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
                            widget.arr!,
                            style: const TextStyle(
                              fontFamily: "Poppins-Regular",
                              fontSize: 18,
                              //fontWeight: FontWeight.w600,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            time(widget.arrTime!),
                            // formatTime(widget.arrTime!),
                            style: const TextStyle(
                              fontFamily: "Poppins-Regular",
                              fontSize: 18,
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
              Expanded(
                child: Row(
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
                            date(widget.depTime!),
                            // formatDate(widget.depTime!),
                            style: const TextStyle(
                              fontFamily: "Poppins-Regular",
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF1E1F29),
                            ),
                          ),
                        ],
                      ),
                    ),
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
                            date(widget.arrTime!),
                            // formatDate(widget.depTime!),
                            style: const TextStyle(
                              fontFamily: "Poppins-Regular",
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF1E1F29),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
                    //   child: Center(
                    //     child: Container(
                    //       //height: widget.queryData.size.height*0.25*0.6,
                    //       //color: Colors.black,
                    //       //width: queryData.size.width*0.45,
                    //       decoration: BoxDecoration(
                    //         color: Colors.blueAccent,
                    //         border: Border.all(
                    //           color: Colors.blue,
                    //           width: 1.0,
                    //         ),
                    //         borderRadius: BorderRadius.circular(18)
                    //       ),
                    //       // child: const Padding(
                    //       //   padding: EdgeInsets.all(2.0),
                    //       //   child: Text(
                    //       //     "Recommended",
                    //       //     style: TextStyle(
                    //       //       color: Colors.white,
                    //       //       fontFamily: "Poppins-Regular",
                    //       //       fontSize: 13,
                    //       //       fontWeight: FontWeight.w600,
                    //       //     ),
                    //       //   ),
                    //       // ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


}
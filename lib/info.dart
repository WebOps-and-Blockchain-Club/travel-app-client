
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:searchfield/searchfield.dart';

class AwesomeDropdownExample extends StatefulWidget {
  const AwesomeDropdownExample({ Key? key }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AwesomeDropdownExampleState createState() => _AwesomeDropdownExampleState();
}

class _AwesomeDropdownExampleState extends State<AwesomeDropdownExample> {
  String? _selectedItem;

  int suggestionsCount = 12;



  @override
  Widget build(BuildContext context) {

    final suggestions = List.generate(suggestionsCount, (index) => 'suggestion $index');

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text('@theflutterlover', style: TextStyle(
          color: Colors.black,
        ),),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Padding(
                //   padding: EdgeInsets.all(20.0),
                //   child: Text('Select a country', style: TextStyle(
                //       fontSize: 16,
                //       color: Colors.blueGrey
                //   ),),
                // ),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        blurRadius: 10,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: SearchField(
                    hint: 'Search',
                    searchInputDecoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blueGrey.shade200,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 2,
                          color: Colors.blue.withOpacity(0.8),
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    maxSuggestionsInViewPort: 6,
                    itemHeight: 50,
                    suggestionsDecoration: SuggestionDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    onSuggestionTap: (value) {
                      setState(() {
                        _selectedItem = value as String?;
                      });

                      print(value);
                    },
                    suggestions: suggestions
                        .map((e) => SearchFieldListItem<String>(e,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Text(e,
                              style: const TextStyle(fontSize: 24, color: Colors.red)),
                        )))
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
          // Container(
          //   height: 90,
          //   padding: EdgeInsets.only(right: 20, left: 20, bottom: 20),
          //   decoration: BoxDecoration(
          //     color: Colors.white,
          //   ),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       _selectedItem == null ? Text('Please select a Country to Continue', style: TextStyle(
          //           fontSize: 16,
          //           color: Colors.blueGrey
          //       ),) : Text(_selectedItem!, style: TextStyle(
          //           fontSize: 16,
          //           color: Colors.grey.shade800,
          //           fontWeight: FontWeight.w600
          //       )),
          //       MaterialButton(
          //         onPressed: () {},
          //         color: Colors.black,
          //         minWidth: 50,
          //         height: 50,
          //         shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(50),
          //         ),
          //         padding: EdgeInsets.all(0),
          //         child: Icon(Icons.arrow_forward_ios, color: Colors.blueGrey, size: 24,),
          //       )
          //     ],
          //   ),
          // )
        ],
      ),
    );
  }
}

class Avaition {
  final String apiKey;
  final String baseUrl = 'http://api.aviationstack.com/v1';

  Avaition(this.apiKey);

  Future<http.Response> fetchData(dep,arr) async {
    final response = await http.get(
      Uri.parse('$baseUrl/flights?access_key=87afb06edeb00b82d2f48951a0570cd5&dep_iata=$dep&arr_iata=$arr'),
      headers: {'Authorization': 'Bearer $apiKey'},
    );

    return response;
  }
}








// String xmlData = '''Your XML data here''';

// class MyApp extends StatefulWidget {
//   const MyApp({super.key});
//
//   @override
//   State<MyApp> createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//
//   String? xmlData;
//
//   @override
//   Widget build(BuildContext context) {
//
//     void fetchAirportData() async {
//       const url = 'https://timetable-lookup.p.rapidapi.com/airports/countries/IN/';
//       final headers = {
//         'X-RapidAPI-Key': 'cd988d1ba3msh80e5cc1cdf2241ep16817ajsn5d06bd5f5e06',
//         'X-RapidAPI-Host': 'timetable-lookup.p.rapidapi.com',
//       };
//
//       try {
//         final response = await http.get(
//           Uri.parse(url),
//           headers: headers,
//         );
//
//         if (response.statusCode == 200) {
//           final result = response.body;
//           setState(() {
//             xmlData = result;
//           });
//           print(result);
//         } else {
//           print('Request failed with status: ${response.statusCode}');
//         }
//       } catch (error) {
//         print(error);
//       }
//     }
//
//     fetchAirportData();
//
//     // List<Map<String, String>> airportList = parseXmlData(xmlData!);
//
//     // Use the structured data (airportList) as needed in your Flutter application.
//
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('XML Parsing Example'),
//         ),
//         body: ListView.builder(
//           itemCount: airportList.length,
//           itemBuilder: (context, index) {
//             return ListTile(
//               title: Text(airportList[index]['Name']!),
//               subtitle: Text('IATA Code: ${airportList[index]['IATACode']}'),
//             );
//           },
//         ),
//       ),
//     );
//   }
//
//   List<Map<String, String>> parseXmlData(String xmlString) {
//     final document = xml.XmlDocument.parse(xmlString);
//     List<Map<String, String>> airports = [];
//
//     for (var airport in document.findAllElements('Airport')) {
//       Map<String, String> airportData = {
//         'IATACode': airport.getAttribute('IATACode') ?? '',
//         'Country': airport.getAttribute('Country') ?? '',
//         'State': airport.getAttribute('State') ?? '',
//         'Name': airport.getAttribute('Name') ?? '',
//         'Latitude': airport.getAttribute('Latitude') ?? '',
//         'Longitude': airport.getAttribute('Longitude') ?? '',
//       };
//       airports.add(airportData);
//     }
//
//     return airports;
//   }
// }





Future<void> fetchFlightDestinations(dep, arr) async {
  const String apiUrl = 'https://test.api.amadeus.com/v1/shopping/flight-destinations?origin=AMS&maxPrice=200';
  final Map<String, String> headers = {
    'Authorization': 'Bearer M6NY46AGIICrLEUeYv6tWWPVnC0M',
  };

  final Uri uri = Uri.parse(apiUrl);

  final response = await http.get(uri, headers: headers);

  if (response.statusCode == 200) {
    // Request was successful, you can parse and handle the response data here.
    print('Response data: ${response.body}');
  } else {
    // Request failed, handle the error here.
    print('Request failed with status: ${response.statusCode}');
  }




}

Future<void> fetchFlightPrice(dep, arr) async {
  String apiUrl = 'https://test.api.amadeus.com/v2/shopping/flight-offers?originLocationCode=$dep&destinationLocationCode=$arr&departureDate=2023-10-31&returnDate=2024-03-01&adults=1&nonStop=false&maxPrice=200';
  final Map<String, String> headers = {
    'Authorization': 'Bearer zoQkR7YdJhbPopes2AK9CpQwSYrA',
  };

  final Uri uri = Uri.parse(apiUrl);

  final response = await http.get(uri, headers: headers);

  if (response.statusCode == 200) {
    // Request was successful, you can parse and handle the response data here.
    // print('Response price data: ${response.body}');

    final data = json.decode(response.body);

    print(data);
    print(data["meta"]["count"]);
    print(data["data"][1]["price"]);

  } else {
    // Request failed, handle the error here.
    print('Request failed with status: ${response.statusCode}');
  }




}



// Future<void> fetchFlightDestinations() async {
//   const baseUrl = 'https://test.api.amadeus.com/v1';  // Replace with the actual API base URL
//   const endpoint = '/shopping/availability/flight-availabilities';
//   const apiUrl = '$baseUrl$endpoint';
//
//
//   final requestData = {
//     "originDestinations": [
//       {
//         "id": "1",
//         "originLocationCode": "BOS",
//         "destinationLocationCode": "MAD",
//         "departureDateTime": {
//           "date": "2023-11-14",
//           "time": "21:15:00"
//         }
//       }
//     ],
//     "travelers": [
//       {
//         "id": "1",
//         "travelerType": "ADULT"
//       }
//     ],
//     "sources": [
//       "GDS"
//     ]
//   };
//
//   final requestBody = jsonEncode(requestData);
//
//   final response = await http.post(
//     Uri.parse(apiUrl),
//     headers: {
//       'Authorization': 'Bearer RUrl592iWck5AYSQ6uOn7fKSCnI7',
//       'Content-Type': 'application/json',
//     },
//     body: requestBody,
//   );
//
//   if (response.statusCode == 200) {
//     // Successful response, parse the JSON response if needed
//     final responseData = jsonDecode(response.body);
//     print(responseData);   // Do something with the responseData
//   } else {
//     // Handle error or non-200 status code
//     print('API request failed with status code: ${response.statusCode}');
//   }
//
//
//
//
//
//
// }









Future<void> fetchAccessToken() async {
  const String apiUrl = "https://test.api.amadeus.com/v1/security/oauth2/token";
  const String clientId = 'your_client_id';
  const String clientSecret = 'your_client_secret';

  final response = await http.post(
    Uri.parse(apiUrl),
    headers: {
      'Content-Type': 'application/x-www-form-urlencoded',
    },
    body: {
      'grant_type': 'client_credentials',
      'client_id': clientId,
      'client_secret': clientSecret,
    },
  );

  if (response.statusCode == 200) {
    print(response);
    print('Access Token: ${response.body}');
    // Handle the access token here
  } else {
    print('Failed to fetch access token. Status code: ${response.statusCode}');
    // Handle the error
  }
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
      print(data["data"]["flightOffers"][0]["segments"][0]["legs"][0]["departureTime"]);
      print(data["data"]["flightOffers"][0]["segments"][0]["legs"][0]["arrivalTime"]);
      print(data["data"]["flightOffers"][0]["segments"][0]["legs"][0]["carriersData"][0]["name"]);
      print(data["data"]["flightOffers"][0]["priceBreakdown"]["total"]["units"]);
      // print(data["data"]["flightOffers"][0]["segments"][0]["legs"][0]);

    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  } catch (error) {
    print('Error: $error');
  }
}

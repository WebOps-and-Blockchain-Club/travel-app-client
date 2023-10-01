

class Flight{
  String? company;
  String? price;
  String? from;
  String? to;
  DateTime? departure;
  DateTime? landing;

  Flight({required this.company,required this.price,this.from,this.to, required this.departure, required this.landing});

}
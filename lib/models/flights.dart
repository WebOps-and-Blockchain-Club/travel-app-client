

class Flight{
  String? company;
  String? price;
  String? dep;
  String? arr;
  DateTime? depTime;
  DateTime? arrTime;

  Flight({required this.company,required this.price,this.dep,this.arr, required this.depTime, required this.arrTime});

}
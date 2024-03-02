import 'Usermodel.dart';

// ignore: empty_constructor_bodies
class UserModel {
  String? id;
  String? email;
  String? password;
  String? name;
  String? nationality;
  String? city;
  String? address;
  String? state;
  String? phone_number;
  DateTime? dob;

  UserModel(
      {this.id,
      this.email,
      this.password,
      this.name,
      this.nationality,
      this.city,
      this.address,
      this.state,
      this.phone_number});

  UserModel.fromJson(Map<String, dynamic> data)
      : id = data["id"],
        name = data["name"],
        email = data['email'],
        password = data['password'],
        nationality = data['nationality'],
        city = data['city'],
        address = data['address'],
        state = data['state'],
        phone_number = data['phone_number'];
}

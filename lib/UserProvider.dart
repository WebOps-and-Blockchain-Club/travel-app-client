import 'models/Usermodel.dart';
import 'package:travel_app_client/httpService.dart';
import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Userprovider extends ChangeNotifier {
  UserModel? userModel;
  String? token;
  final FlutterSecureStorage storage = FlutterSecureStorage();
  Userprovider() {
    _initialize();
  }

  _initialize() async {
    await getToken();
  }

  getToken() async {
    token = await storage.read(key: 'token');
    await getUser();
    notifyListeners();
  }

  removeToken() async {
    await storage.delete(key: 'token');
    notifyListeners();
  }

  getUser() async {
    if (token != null) {
      final httpService = HttpService();
      var res = await httpService.getRequest('/viewprofile');
      if (res != null) {
        if (res["success"])
          userModel = UserModel.fromJson(res['data']);
        else if (res['message'] == 'Forbidden') removeToken();

        print(userModel);
      }
      notifyListeners();
    }
  }
}

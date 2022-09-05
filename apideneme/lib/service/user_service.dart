import 'dart:convert';

import '../model/users_model.dart';
import 'package:http/http.dart' as http;
class UserService{
  final String url = 'https://reqres.in/api/users?page=2';
  Future<UsersModel?> fetchUsers() async{
    final res = await http.get(Uri.parse(url));
    if(res.statusCode == 200){
      return UsersModel.fromJson(jsonDecode(res.body));
    }else{
      print("Error ${res.statusCode}");
    }
  }
}
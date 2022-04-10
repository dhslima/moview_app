import 'dart:convert';

import 'package:moview_app/models/moview.dart';
import 'package:shared_preferences/shared_preferences.dart';

const moviewListKey = 'moview_list';
class MoviewRepository {

  late SharedPreferences sharedPreferences;

  Future<List<Moview>> getMoviewList() async{
    sharedPreferences = await SharedPreferences.getInstance();
    final String jsonString = sharedPreferences.getString(moviewListKey) ?? '[]';
    final List jsonDecoded = json.decode(jsonString) as List;
    return jsonDecoded.map((e) => Moview.fromJson(e)).toList();
  }

  void saveMoviewList(List<Moview> todos) {
    final String jsonString = json.encode(todos);
    sharedPreferences.setString('moview_list', jsonString);
  }

}

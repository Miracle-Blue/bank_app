import 'package:bank_app/models/card_model.dart';
import 'package:hive/hive.dart';

class HiveDB {
  static String DB_NAME = "bank_app";
  static var box = Hive.box(DB_NAME);

  static void storeData(List<CCard> cards) async {
    List<Map<String, dynamic>> list = cards.map((e) => e.toJson()).toList();
    box.put("cards", list);
  }

  static Future<List<CCard>> loadData() async {
    List<Map<String, dynamic>> list = box.get("cards") ?? [];
    List<CCard> cards = list.map((e) => CCard.fromJson(e)).toList();
    return cards;
  }

  static void removeData() {
    box.delete("cards");
  }
}


  import 'dart:convert';
  import 'package:http/http.dart' as http;

class ExpenseListApi {
  static Future<List<dynamic>> getOrderList() async {
    var url = Uri.parse('http://mycropguruapiwow.cropguru.in/api/FarmerPlotExpence/1');
    try {
      var response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode({
            "CAT_ID": "",
            "START": "1",
            "END": "1000",
            "WORD": "",
            "EXTRA1": "",
            "EXTRA2": "",
            "EXTRA3": "",
            "LANG_ID": "1",
            "USER_ID": "60640",
            "START_DATE": "04\/01\/2023",
            "END_DATE": "04\/30\/2023",
            "PLOT_ID": "67898"
          }));

      if (response.statusCode >= 400) {
        throw Exception('Something went wrong!');
      }
      List<dynamic> orderList = jsonDecode(response.body)['DATA'];

      return orderList;
    } catch (error) {
      rethrow;
    }
  }
}
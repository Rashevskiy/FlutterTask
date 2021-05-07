import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:test_task/model/bitcoinData.dart';

class JsonReader {
  final url = Uri.parse('https://api.binance.com/api/v3/ticker/24hr');

  Future<List<BitcoinData>> get bitcoins async {
    List<BitcoinData> _bitcoins = [];
    final res = await http.get(url, headers: {"Accept": "aplication/json"});
    final jsonData = json.decode(res.body) as List;

    jsonData.forEach((element) {
      _bitcoins.add(BitcoinData(element['lastPrice']));
    });
    return _bitcoins;
  }
}

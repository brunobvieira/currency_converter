import 'dart:convert';

import 'package:currency_converter/src/models/currency_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

// For more information about the service see --> https://freecurrencyapi.net/documentation
class FreeCurrencyApiService {
  static const apiUrl = 'https://freecurrencyapi.net/api/v2/latest';
  static const headers = {'Content-Type': 'application/json; charset=UTF-8'};
  String apiKey = '';

  FreeCurrencyApiService() {
    var apiKey = dotenv.env['FREE_CURRENCY_API_KEY'];

    if (apiKey != null && apiKey.isNotEmpty) {
      this.apiKey = apiKey;
    } else {
      throw Exception('enviroment var "FREE_CURRENCY_API_KEY" is not defined.');
    }
  }

  Future<Currency> fetchExchangeRates(String baseCurrency) async {
    var queryParams =
        Uri(queryParameters: {'apikey': apiKey, 'base_currency': baseCurrency})
            .query;
    var url = Uri.parse('$apiUrl?$queryParams');

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      return Currency.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load exchange rates for "$baseCurrency"');
    }
  }
}

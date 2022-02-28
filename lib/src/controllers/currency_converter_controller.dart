import 'package:currency_converter/src/models/currency_model.dart';
import 'package:currency_converter/src/services/free_currency_api_service.dart';
import 'package:flutter/cupertino.dart';

class CurrencyConverterController {
  final FreeCurrencyApiService service;

  TextEditingController fromController = TextEditingController();
  TextEditingController toController = TextEditingController();

  Map<CurrencyTokens, Currency> currencies = <CurrencyTokens, Currency>{};

  CurrencyTokens toCurrency = CurrencyTokens.USD;
  CurrencyTokens fromCurrency = CurrencyTokens.EUR;

  CurrencyConverterController({required this.service});

  Future<Currency> fetchCurrency(CurrencyTokens token) async {
    if (currencies.containsKey(token)) {
      return currencies[token] as Currency;
    }

    var currency = await service.fetchExchangeRates(token.name);

    currencies[currency.token] = currency;
    return currency;
  }

  void convert() async {
    var currency = await fetchCurrency(fromCurrency);
    var exchangeValue = currency.exchanges[toCurrency] as double;

    var valueToConvert = double.parse(fromController.text.replaceAll(',', '.'));
    var valueConverted = valueToConvert * exchangeValue;

    toController.text = valueConverted.toString();
  }
}

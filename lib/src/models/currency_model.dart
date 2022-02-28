class Currency {
  final CurrencyTokens token;
  final DateTime fetchDate;
  final Map<CurrencyTokens, double> exchanges;

  Currency(
      {required this.token, required this.fetchDate, required this.exchanges});

  factory Currency.fromJson(Map<String, dynamic> json) {
    var rawExchanges = json['data'] as Map<String, dynamic>;
    Map<CurrencyTokens, double> exchanges = {};

    for (CurrencyTokens token in CurrencyTokens.values) {
      var found = rawExchanges[token.name] ?? '1';
      exchanges[token] =
          found is String ? 0.0 + double.parse(found) : 0.0 + found;
    }

    return Currency(
        token: CurrencyTokens.values
            .firstWhere((e) => e.name == json['query']['base_currency']),
        fetchDate:
            DateTime.fromMicrosecondsSinceEpoch(json['query']['timestamp']),
        exchanges: exchanges);
  }
}

// ignore: constant_identifier_names
enum CurrencyTokens {
  USD,
  EUR,
  JPY,
  CAD,
  BRL,
  CNY,
  ARS,
  GBP,
  RUB,
}

class Currency {
  final String token;
  final DateTime fetchDate;
  final Map<String, double> exchanges;

  Currency(this.token, this.fetchDate, this.exchanges);

  factory Currency.fromJson(Map<String, dynamic> json) {
    return Currency(
        json['query']['base_currency'],
        DateTime.fromMicrosecondsSinceEpoch(json['query']['timestamp']),
        json['data']);
  }
}

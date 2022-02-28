import 'package:currency_converter/src/pages/currency_converter_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main() async {
  await dotenv.load();
  runApp(App());
}

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Currency Converter App',
        theme: ThemeData.dark(),
        home: CurrencyConverterPage());
  }
}

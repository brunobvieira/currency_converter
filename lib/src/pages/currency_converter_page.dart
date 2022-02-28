import 'package:currency_converter/src/controllers/currency_converter_controller.dart';
import 'package:currency_converter/src/models/currency_model.dart';
import 'package:currency_converter/src/services/free_currency_api_service.dart';
import 'package:currency_converter/src/widgets/currency_input_widget.dart';
import 'package:flutter/material.dart';

class CurrencyConverterPage extends StatefulWidget {
  @override
  _CurrencyConverterPageState createState() => _CurrencyConverterPageState();
}

class _CurrencyConverterPageState extends State<CurrencyConverterPage> {
  late final CurrencyConverterController ctrl;
  bool _isloading = false;

  @override
  void initState() {
    super.initState();

    var service = FreeCurrencyApiService();
    ctrl = CurrencyConverterController(service: service);
    ctrl.fetchCurrency(ctrl.fromCurrency);
  }

  _handleChangeFromCurrency(CurrencyTokens? currencyToken) async {
    if (currencyToken == null) return;
    setState(() {
      _isloading = true;
    });

    await ctrl.fetchCurrency(currencyToken);

    setState(() {
      ctrl.fromCurrency = currencyToken;
      _isloading = false;
    });
  }

  _handleChangeToCurrency(CurrencyTokens? currencyToken) async {
    if (currencyToken == null) return;
    setState(() {
      ctrl.toCurrency = currencyToken;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 10, right: 10, top: 100),
                  child: Image(
                    width: 150,
                    height: 150,
                    image: AssetImage('assets/images/logo.png'),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                CurrencyInput(
                  currencyToken: ctrl.fromCurrency,
                  textController: ctrl.fromController,
                  onChangeCurrency: _handleChangeFromCurrency,
                ),
                const SizedBox(
                  height: 20,
                ),
                CurrencyInput(
                  currencyToken: ctrl.toCurrency,
                  textController: ctrl.toController,
                  onChangeCurrency: _handleChangeToCurrency,
                  textEnabled: false,
                ),
                const SizedBox(
                  height: 25,
                ),
                SizedBox(
                  width: 200,
                  height: 45,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.amber),
                    ),
                    onPressed: _isloading ? null : ctrl.convert,
                    child: _isloading
                        ? CircularProgressIndicator()
                        : const Text('CONVERT', style: TextStyle(fontSize: 18)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

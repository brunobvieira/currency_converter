import 'package:currency_converter/src/models/currency_model.dart';
import 'package:flutter/material.dart';

class CurrencyInput extends StatelessWidget {
  final CurrencyTokens currencyToken;
  final TextEditingController textController;
  final void Function(CurrencyTokens?) onChangeCurrency;
  bool? textEnabled = true;

  CurrencyInput({
    Key? key,
    required this.currencyToken,
    required this.textController,
    required this.onChangeCurrency,
    this.textEnabled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: SizedBox(
            height: 57,
            child: DropdownButton(
              isExpanded: true,
              value: currencyToken,
              iconEnabledColor: Colors.amber,
              underline: Container(height: 1, color: Colors.amber),
              items: CurrencyTokens.values.map((CurrencyTokens token) {
                return DropdownMenuItem<CurrencyTokens>(
                    value: token, child: Text(token.name));
              }).toList(),
              onChanged: onChangeCurrency,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          flex: 2,
          child: TextField(
            enabled: textEnabled,
            controller: textController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.amber))),
          ),
        ),
      ],
    );
  }
}

import 'dart:math';

import 'package:flutter/material.dart';

double roundDouble(double value, int place) {
  final num mod = pow(10.0, place);
  return (value * mod).round().toDouble() / mod;
}

void main() {
  runApp(const FlutterApp());
}

class FlutterApp extends StatelessWidget {
  const FlutterApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController controller = TextEditingController();
  String display = ' ';
  String? errorText;
  double doubleAmount = 0;
  String stringAmount = '0';
  bool pressed = false;
  bool isOk = true;
  String hintText = 'Enter the amount in EUR';
  String prefixText = '€ ';
  String currency = ' RON';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Currency convertor'),
        backgroundColor: const Color(0xFF4CAF50),
      ),
      body: Column(
        children: <Widget>[
          Image.network(
            'https://www.crestwood.com/wp-content/uploads/2020/04/Global-Currency1100px-1024x682.jpeg',
          ),
          const SizedBox(height: 5),
          Container(
            margin: const EdgeInsetsDirectional.all(15.0),
            child: TextField(
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              controller: controller,
              onChanged: (String? value) {
                final double? doubleValue = double.tryParse(value!);
                double? aValue = doubleValue;

                if (doubleValue == null) {
                  setState(() {
                    errorText = 'Enter a valid number';
                    doubleAmount = 0;
                    stringAmount = doubleAmount.toString();
                    isOk = false;
                  });
                } else {
                  if (prefixText == '€ ') {
                    setState(() {
                      errorText = null;
                      aValue = doubleValue;
                      doubleAmount = roundDouble(aValue! * 4.95, 2);
                      stringAmount = doubleAmount.toString();

                      isOk = true;
                    });
                  } else if (prefixText == 'RON ') {
                    setState(() {
                      errorText = null;
                      aValue = doubleValue;
                      doubleAmount = roundDouble(aValue! / 4.95, 2);
                      stringAmount = doubleAmount.toString();

                      isOk = true;
                    });
                  }
                }
              },
              decoration: InputDecoration(
                errorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.green, width: 2.5),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.green, width: 2.5),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                errorText: errorText,
                hintText: hintText,
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.green, width: 2.5),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.green, width: 2.5),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                isDense: true,
                contentPadding: const EdgeInsets.all(4.0),
                suffix: IconButton(
                  iconSize: 20.0,
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    controller.clear();
                    setState(() {
                      doubleAmount = 0;
                      stringAmount = doubleAmount.toString();
                    });
                  },
                ),
                prefixText: prefixText,
              ),
            ),
          ),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
                fixedSize: const Size(120, 40),
              ),
              child: const Text(
                'Convert 🔄',
                style: TextStyle(fontSize: 16),
              ),
              onPressed: () {
                final double? checker = double.tryParse(controller.text);
                if (checker == null) {
                  doubleAmount = 0;
                } else {
                  doubleAmount = double.parse(controller.value.text);
                }
                if (!pressed) {
                  setState(() {
                    prefixText = 'RON ';
                    currency = ' €';
                    hintText = 'Enter the amount in RON';

                    doubleAmount = roundDouble(doubleAmount / 4.95, 2);

                    stringAmount = doubleAmount.toString();

                    pressed = !pressed;
                  });
                } else {
                  setState(() {
                    prefixText = '€ ';
                    hintText = 'Enter the amount in EUR';
                    currency = ' RON';

                    doubleAmount = roundDouble(doubleAmount * 4.95, 2);

                    stringAmount = (doubleAmount).toString();

                    pressed = !pressed;
                  });
                }

                FocusScope.of(context).requestFocus(FocusNode());
              },
            ),
          ),
          const SizedBox(height: 5),
          Text(
            stringAmount + currency,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

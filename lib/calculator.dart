
import 'package:calculator/colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({super.key});

  @override
  State<CalculatorApp> createState() => CalculatorAppState();
}

class CalculatorAppState extends State<CalculatorApp> {
  num firstNumber = 0.0;
  num secondNumber = 0.0;
  var input = "";
  var output = "";
  var operator = "";
  var hideInput = false;
  double outputSize = 38;
  onPressedButton(value) {
    if (value == "AC") {
      input = "";
      output = "";
    } else if (value == "<") {
      hideInput = false;
      if (input.isNotEmpty) input = input.substring(0, input.length - 1);
    } else if (value == "=") {
      if (input.isNotEmpty) {
        var userInput = input;
        userInput = input.replaceAll("x", "*");
        Parser p = Parser();
        Expression expression = p.parse(userInput);
        ContextModel cm = ContextModel();
        var finalValue = expression.evaluate(EvaluationType.REAL, cm);
        output = finalValue.toString();
        if (output.endsWith(".0"))
          output = output.substring(0, output.length - 2);
        input = output;
        hideInput = true;
      }
    } else {
      hideInput = false;
      input = input + value;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: 
           Column(
          children: [
            Expanded(
                child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    hideInput ? "" : input,
                    style: TextStyle(fontSize: 48, color: Colors.white),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    output,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: outputSize,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  )
                ],
              ),
            )),
            Row(
              children: [
                button(
                    label: "AC",
                    labelColor: Colors.orange,
                    buttonBGcolor: operatorColor),
                button(
                    label: "<",
                    labelColor: Colors.orange,
                    buttonBGcolor: operatorColor),
                button(label: "", buttonBGcolor: Colors.transparent),
                button(
                    label: "/",
                    buttonBGcolor: operatorColor,
                    labelColor: Colors.orange)
              ],
            ),
            Row(
              children: [
                button(label: "7"),
                button(label: "8"),
                button(label: "9"),
                button(
                    label: "x",
                    labelColor: Colors.orange,
                    buttonBGcolor: operatorColor)
              ],
            ),
            Row(
              children: [
                button(label: "4"),
                button(label: "5"),
                button(label: "6"),
                button(
                    label: "-",
                    labelColor: Colors.orange,
                    buttonBGcolor: operatorColor)
              ],
            ),
            Row(
              children: [
                button(label: "1"),
                button(label: "2"),
                button(label: "3"),
                button(
                    label: "+",
                    labelColor: Colors.orange,
                    buttonBGcolor: operatorColor)
              ],
            ),
            Row(
              children: [
                button(label: "%"),
                button(label: "0"),
                button(label: "."),
                button(label: "=", buttonBGcolor: Colors.orangeAccent)
              ],
            )
          ],
        ),
      
    );
  }

  Widget button({label, buttonBGcolor: buttonColor, labelColor: Colors.white}) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(8),
        child: ElevatedButton(
          onPressed: () {
            onPressedButton(label);
          },
          style: ElevatedButton.styleFrom(
              primary: buttonBGcolor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              padding: const EdgeInsets.all(22)),
          child: Text(
            label,
            style: TextStyle(
                color: labelColor, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

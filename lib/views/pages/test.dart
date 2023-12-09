import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Grams Input'),
        ),
        body: Center(
          child: GramsInput(),
        ),
      ),
    );
  }
}

class GramsInput extends StatefulWidget {
  @override
  _GramsInputState createState() => _GramsInputState();
}

class _GramsInputState extends State<GramsInput> {
  TextEditingController _controller = TextEditingController();
  String? gramsValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: _controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Enter value in grams',
              hintText: 'e.g., 250',
              suffixText: 'g',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              setState(() {
                gramsValue = value;
              });
            },
          ),
          SizedBox(height: 16.0),
          if (gramsValue != null)
            Text(
              'Entered value: $gramsValue grams',
              style: TextStyle(fontSize: 16.0),
            ),
        ],
      ),
    );
  }
}

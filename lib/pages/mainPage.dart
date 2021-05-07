import 'package:flutter/material.dart';
import 'package:test_task/model/bitcoinData.dart';
import 'package:test_task/service/jsonReader.dart';

class TestApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TestApp',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: FutureBuilder<List<BitcoinData>>(
        future: JsonReader().bitcoins,
        builder: (context, bitcoins) {
          if (bitcoins.hasData) {
            return MainPage(bitcoins.data);
          } else if (bitcoins.hasError) {
            return Text('Its Error! ' + bitcoins.error.toString());
          } else {
            return Center(
                child: CircularProgressIndicator(
              strokeWidth: 5,
            ));
          }
        },
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  List<BitcoinData> bitcoins;
  MainPage(this.bitcoins);
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<bool> stateButtons = [];

  @override
  void initState() {
    stateButtons = List.filled(widget.bitcoins.length, false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Container(
          width: 100,
          height: 200,
          decoration: BoxDecoration(
            color: Colors.grey[350],
            // border: Border.all(color: Colors.cyan[700], width: 2),
            borderRadius: BorderRadius.circular(4),
          ),
          child: _drawButtons(),
        ),
      ),
    );
  }

  Widget _drawButtons() {
    return ListView.builder(
        itemCount: widget.bitcoins.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.symmetric(vertical: 8),
            child: MaterialButton(
              onPressed: () {
                setState(() {
                  stateButtons[index] = !stateButtons[index];
                });
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: FittedBox(
                  child: Text((stateButtons[index])
                      ? widget.bitcoins[index].lastPrice.toString()
                      : 'Press Me'),
                ),
              ),
              color: Colors.blueGrey,
            ),
          );
        });
  }
}

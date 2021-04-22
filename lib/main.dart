import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primaryColor: Colors.black),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.center,
              child: Image.asset(
                "assets/logo.png",
                fit: BoxFit.contain,
                width: 45,
                height: 45,
              ),
            ),
            const SizedBox(width: 15),
            Text(
              "Hydro-SDK Registry",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
      body: Stack(
        children: [
          Container(
            color: Color(0xFF75166132),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 2.2,
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 165,
              right: 165,
              top: 35,
            ),
            child: TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.black12,
                border: OutlineInputBorder(),
                labelText: "Search Components",
              ),
            ),
          ),
        ],
      ),
    );
  }
}

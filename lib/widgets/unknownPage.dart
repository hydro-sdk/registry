import 'package:flutter/material.dart';
import 'package:registry/widgets/appScaffold.dart';

class UnknownPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => AppScaffold(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    "404",
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
}

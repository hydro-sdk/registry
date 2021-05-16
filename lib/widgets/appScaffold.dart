import 'package:flutter/material.dart';

class AppScaffold extends StatefulWidget {
  final Widget child;
  final bool showBackgroundLogoColor;

  AppScaffold({
    required this.child,
    this.showBackgroundLogoColor = false,
  });

  @override
  _AppScaffoldState createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
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
                const Text(
                  "Hydro-SDK Registry",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
            Row(
              children: [
                TextButton(
                  child: const Text("Signup"),
                  onPressed: () => Navigator.pushNamed(context, "/signup"),
                ),
                TextButton(
                  child: const Text("Login"),
                  onPressed: () async {},
                ),
                const SizedBox(width: 10),
              ],
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          widget.showBackgroundLogoColor
              ? Container(
                  color: const Color(0x75166132),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 2.2,
                )
              : const SizedBox(),
          widget.child,
        ],
      ),
    );
  }
}

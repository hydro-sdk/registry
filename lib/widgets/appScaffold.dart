import 'package:flutter/material.dart';

class AppScaffold extends StatelessWidget {
  final Widget child;
  final bool showBackgroundLogoColor;

  AppScaffold({
    required this.child,
    this.showBackgroundLogoColor = false,
  });

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
            const Text(
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
          showBackgroundLogoColor
              ? Container(
                  color: const Color(0x75166132),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 2.2,
                )
              : const SizedBox(),
          child,
        ],
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:registry/util/userController.dart';

enum ScaffoldMenuItems {
  projects,
}

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
    final userController = Provider.of<UserController>(context);
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
                  child: Material(
                    type: MaterialType.transparency,
                    child: InkWell(
                      onTap: () => Navigator.of(context).pushNamed("/"),
                      splashColor: const Color(0x75166132),
                      child: Image.asset(
                        "assets/logo.png",
                        fit: BoxFit.contain,
                        width: 45,
                        height: 45,
                      ),
                    ),
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
              children: userController.user == null
                  ? [
                      TextButton(
                          child: const Text("Sign in with Github"),
                          onPressed: () async {
                            await FirebaseAuth.instance
                                .signInWithPopup(GithubAuthProvider());
                          }),
                      const SizedBox(width: 10),
                    ]
                  : [
                      PopupMenuButton(
                        child:
                            (userController.user!.photoURL?.isNotEmpty ?? false)
                                ? CircleAvatar(
                                    child: Image.network(
                                        userController.user!.photoURL!),
                                  )
                                : null,
                        icon:
                            (userController.user!.photoURL?.isNotEmpty ?? false)
                                ? null
                                : const Icon(Icons.account_circle),
                        onSelected: (result) {
                          switch (result) {
                            case ScaffoldMenuItems.projects:
                              Navigator.pushNamed(context, "/projects");
                              return;
                          }
                        },
                        itemBuilder: (_) => [
                          const PopupMenuItem(
                            value: ScaffoldMenuItems.projects,
                            child: Text("Projects"),
                          )
                        ],
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

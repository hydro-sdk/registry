import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:registry/util/userController.dart';

Widget changeNotifier({
  required UserController userController,
  required Widget child,
}) =>
    MultiProvider(
      providers: [
        ChangeNotifierProvider<UserController>.value(
          value: userController,
        ),
      ],
      child: Builder(
        builder: (_) => child,
      ),
    );

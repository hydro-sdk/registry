import 'package:flutter/material.dart';
import 'package:registry/util/userController.dart';
import 'package:provider/provider.dart';

Widget changeNotifier({
  required UserController userController,
  required Widget child,
}) =>
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: userController,
        ),
      ],
      child: child,
    );

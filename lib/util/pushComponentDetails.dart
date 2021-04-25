import 'package:flutter/material.dart';

Future<void> pushComponentDetails({
  required String projectName,
  required String componentName,
  required BuildContext context,
}) =>
    Navigator.pushNamed(context, "/component/${projectName}/${componentName}");

import 'package:flutter/material.dart';

Future<void> pushComponentDetails({
  required String componentId,
  required BuildContext context,
}) =>
    Navigator.pushNamed(context, "/component/${componentId}");

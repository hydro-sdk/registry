import 'package:flutter/material.dart';

Future<void> pushProjectDetails({
  required String projectId,
  required BuildContext context,
}) =>
    Navigator.pushNamed(context, "/project/$projectId");

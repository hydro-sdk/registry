import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:hydro_sdk/registry/registryApi.dart';

import 'package:registry/widgets/createProjectDialog.dart';

Future<void> showCreateProjectDialog(
  BuildContext context, {
  required RegistryApi registryApi,
  required String name,
  required String description,
  required User user,
}) =>
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => CreateProjectDialog(
        registryApi: registryApi,
        name: name,
        description: description,
        user: user,
      ),
    );

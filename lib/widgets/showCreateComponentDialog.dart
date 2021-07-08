import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:hydro_sdk/registry/dto/projectEntity.dart';
import 'package:hydro_sdk/registry/registryApi.dart';

import 'package:registry/widgets/createComponentDialog.dart';

Future<void> showCreateComponentDialog(
  BuildContext context, {
  required RegistryApi registryApi,
  required ProjectEntity projectEntity,
  required String name,
  required String description,
  required User user,
}) =>
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => CreateComponentDialiog(
        registryApi: registryApi,
        projectEntity: projectEntity,
        name: name,
        description: description,
        user: user,
      ),
    );

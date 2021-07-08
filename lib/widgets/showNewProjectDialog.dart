import 'package:flutter/material.dart';

import 'package:hydro_sdk/registry/registryApi.dart';

import 'package:registry/widgets/newProjectDialog.dart';

Future<NewProjectDialogDto?> showNewProjectDialog(
  BuildContext context, {
  required RegistryApi registryApi,
}) =>
    showDialog(
      context: context,
      builder: (_) => NewProjectDialog(
        registryApi: registryApi,
      ),
    );

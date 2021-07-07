import 'package:flutter/material.dart';
import 'package:hydro_sdk/registry/dto/projectEntity.dart';
import 'package:hydro_sdk/registry/registryApi.dart';
import 'package:registry/widgets/newComponentDialog.dart';

Future<NewComponentDialogDto?> showNewComponentDialog(
  BuildContext context, {
  required ProjectEntity projectEntity,
  required RegistryApi registryApi,
}) =>
    showDialog<NewComponentDialogDto>(
      context: context,
      builder: (_) => NewComponentDialog(
        projectEntity: projectEntity,
        registryApi: registryApi,
      ),
    );

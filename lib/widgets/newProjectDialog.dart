import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydro_sdk/registry/registryApi.dart';

import 'package:registry/util/formatEntityName.dart';

part 'newProjectDialog.freezed.dart';

class NewProjectDialog extends StatefulWidget {
  final RegistryApi registryApi;

  const NewProjectDialog({
    required this.registryApi,
    Key? key,
  }) : super(
          key: key,
        );

  @override
  _NewProjectDialogState createState() => _NewProjectDialogState();
}

class _NewProjectDialogState extends State<NewProjectDialog> {
  late final TextEditingController nameTextEditingController;
  late final TextEditingController descriptionTextEditingController;

  void _nameTextEditingControllerOnChanged() => setState(() => null);

  @override
  void initState() {
    nameTextEditingController = TextEditingController();
    nameTextEditingController.addListener(_nameTextEditingControllerOnChanged);

    descriptionTextEditingController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    nameTextEditingController
        .removeListener(_nameTextEditingControllerOnChanged);
    nameTextEditingController.dispose();

    descriptionTextEditingController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
        title: const Text("New Project"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop<NewProjectDialogDto>(
              const NewProjectDialogDto.fromNewProjectDialogCancelDto(
                newProjectDialogCancelDto: NewProjectDialogCancelDto(),
              ),
            ),
            child: const Text(
              "Cancel",
              textAlign: TextAlign.end,
            ),
          ),
          TextButton(
            onPressed: () =>
                formatEntityName(nameTextEditingController.text).isNotEmpty
                    ? (({
                        required String name,
                        required String description,
                      }) =>
                            Navigator.of(context).pop<NewProjectDialogDto>(
                              NewProjectDialogDto.fromNewProjectDialogAcceptDto(
                                newProjectDialogAcceptDto:
                                    NewProjectDialogAcceptDto(
                                  name: name,
                                  description: description,
                                ),
                              ),
                            ))(
                        name: formatEntityName(nameTextEditingController.text),
                        description: descriptionTextEditingController.text)
                    : null,
            child: const Text(
              "Create",
              textAlign: TextAlign.end,
            ),
          )
        ],
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Name",
              ),
              controller: nameTextEditingController,
            ),
            Text([
              formatEntityName(nameTextEditingController.text),
            ].join("")),
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Description",
              ),
              controller: descriptionTextEditingController,
            )
          ],
        ),
      );
}

@freezed
class NewProjectDialogAcceptDto with _$NewProjectDialogAcceptDto {
  const NewProjectDialogAcceptDto._();

  const factory NewProjectDialogAcceptDto({
    required String name,
    required String description,
  }) = _$NewProjectDialogAcceptDtoCtor;
}

@freezed
class NewProjectDialogCancelDto with _$NewProjectDialogCancelDto {
  const NewProjectDialogCancelDto._();

  const factory NewProjectDialogCancelDto() = _$NewProjectDialogCancelDtoCtor;
}

@freezed
class NewProjectDialogDto with _$NewProjectDialogDto {
  const NewProjectDialogDto._();

  const factory NewProjectDialogDto.fromNewProjectDialogAcceptDto({
    required NewProjectDialogAcceptDto newProjectDialogAcceptDto,
  }) = _$NewProjectDialogDtoFromNewProjectDialogAcceptDto;

  const factory NewProjectDialogDto.fromNewProjectDialogCancelDto({
    required NewProjectDialogCancelDto newProjectDialogCancelDto,
  }) = _$NewProjectDialogDtoFromNewProjectCancelDto;
}

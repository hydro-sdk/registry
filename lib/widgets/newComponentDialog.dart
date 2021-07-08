import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydro_sdk/registry/dto/projectEntity.dart';
import 'package:hydro_sdk/registry/registryApi.dart';

import 'package:registry/util/formatEntityName.dart';

part 'newComponentDialog.freezed.dart';

class NewComponentDialog extends StatefulWidget {
  final RegistryApi registryApi;
  final ProjectEntity projectEntity;

  const NewComponentDialog({
    required this.registryApi,
    required this.projectEntity,
    Key? key,
  }) : super(
          key: key,
        );

  @override
  _NewComponentDialogState createState() => _NewComponentDialogState();
}

class _NewComponentDialogState extends State<NewComponentDialog> {
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
        title: const Text("New Component"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop<NewComponentDialogDto>(
              const NewComponentDialogDto.fromNewComponentDialogCancelDto(
                newComponentDialogCancelDto: NewComponentDialogCancelDto(),
              ),
            ),
            child: const Text(
              "Cancel",
              textAlign: TextAlign.end,
            ),
          ),
          TextButton(
            onPressed: () => formatEntityName(nameTextEditingController.text)
                    .isNotEmpty
                ? (({
                    required String name,
                    required String description,
                  }) =>
                        Navigator.of(context).pop<NewComponentDialogDto>(
                          NewComponentDialogDto.fromNewComponentDialogAcceptDto(
                            newComponentDialogAcceptDto:
                                NewComponentDialogAcceptDto(
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
              widget.projectEntity.name,
              formatEntityName(nameTextEditingController.text),
            ].join("/")),
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
class NewComponentDialogAcceptDto with _$NewComponentDialogAcceptDto {
  const NewComponentDialogAcceptDto._();

  const factory NewComponentDialogAcceptDto({
    required String name,
    required String description,
  }) = _$NewComponentDialogAcceptDtoCtor;
}

@freezed
class NewComponentDialogCancelDto with _$NewComponentDialogCancelDto {
  const NewComponentDialogCancelDto._();

  const factory NewComponentDialogCancelDto() =
      _$NewComponentDialogCancelDtoCtor;
}

@freezed
class NewComponentDialogDto with _$NewComponentDialogDto {
  const NewComponentDialogDto._();

  const factory NewComponentDialogDto.fromNewComponentDialogAcceptDto({
    required NewComponentDialogAcceptDto newComponentDialogAcceptDto,
  }) = _$NewComponentDialogDtoFromNewComponentDialogAcceptDto;

  const factory NewComponentDialogDto.fromNewComponentDialogCancelDto({
    required NewComponentDialogCancelDto newComponentDialogCancelDto,
  }) = _$NewComponentDialogDtoFromNewComponentDialogCancelDto;
}

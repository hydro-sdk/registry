import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
  late final TextEditingController textEditingController;

  void _textEditingControllerOnChanged() => setState(() => null);

  @override
  void initState() {
    textEditingController = TextEditingController();
    textEditingController.addListener(_textEditingControllerOnChanged);

    super.initState();
  }

  @override
  void dispose() {
    textEditingController.removeListener(_textEditingControllerOnChanged);
    textEditingController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
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
          onPressed: () => ((String text) =>
              Navigator.of(context).pop<NewComponentDialogDto>(
                NewComponentDialogDto.fromNewComponentDialogAcceptDto(
                  newComponentDialogAcceptDto: NewComponentDialogAcceptDto(
                    name: text,
                  ),
                ),
              ))(formatEntityName(textEditingController.text)),
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
            controller: textEditingController,
          ),
          Text([
            widget.projectEntity.name,
            formatEntityName(textEditingController.text),
          ].join("/")),
        ],
      ),
    );
  }
}

@freezed
class NewComponentDialogAcceptDto with _$NewComponentDialogAcceptDto {
  const NewComponentDialogAcceptDto._();

  const factory NewComponentDialogAcceptDto({
    required String name,
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

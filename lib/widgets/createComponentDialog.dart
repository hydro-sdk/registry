import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:clipboard/clipboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hydro_sdk/registry/dto/createComponentDto.dart';
import 'package:hydro_sdk/registry/dto/createComponentResponseDto.dart';
import 'package:hydro_sdk/registry/dto/projectEntity.dart';
import 'package:hydro_sdk/registry/dto/sessionDto.dart';
import 'package:hydro_sdk/registry/registryApi.dart';

class CreateComponentDialiog extends StatefulWidget {
  final RegistryApi registryApi;
  final ProjectEntity projectEntity;
  final String name;
  final String description;
  final User user;

  const CreateComponentDialiog({
    required this.registryApi,
    required this.projectEntity,
    required this.name,
    required this.description,
    required this.user,
    Key? key,
  }) : super(
          key: key,
        );

  @override
  _CreateComponentDialiogState createState() => _CreateComponentDialiogState();
}

class _CreateComponentDialiogState extends State<CreateComponentDialiog> {
  CreateComponentResponseDto? createComponentResponseDto;

  @override
  void initState() {
    widget.user.getIdToken().then(
          (value) => widget.registryApi
              .createComponent(
                dto: CreateComponentDto(
                  name: widget.name,
                  description: widget.description,
                  projectId: widget.projectEntity.id,
                ),
                sessionDto: SessionDto(authToken: value),
              )
              .then(
                (value) => mounted
                    ? setState(
                        () => createComponentResponseDto = value.maybeWhen(
                              success: (val) => val.result,
                              orElse: () => null,
                            ))
                    : null,
              ),
        );

    super.initState();
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
        title: createComponentResponseDto == null
            ? const Text("Creating Component")
            : Text("Created component ${widget.name}"),
        actions: [
          createComponentResponseDto != null
              ? TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text(
                    "Done",
                    textAlign: TextAlign.end,
                  ))
              : const SizedBox()
        ],
        content: createComponentResponseDto == null
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
                ],
              )
            : Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                      "Below is the key that will be used to sign new packages created for this component. Save it and don't lost it. You'll never be able to see it again. "),
                  Material(
                    child: InkWell(
                      onTap: () async {
                        await FlutterClipboard.copy(
                            createComponentResponseDto!.publishingPrivateKey);
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text("Click to copy full key"),
                          Text(
                            [
                              createComponentResponseDto!
                                  .publishingPrivateKey.characters
                                  .take(145),
                              "...",
                            ].join(""),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      );
}

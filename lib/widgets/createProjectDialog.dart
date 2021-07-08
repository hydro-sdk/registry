import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:hydro_sdk/registry/dto/createProjectDto.dart';
import 'package:hydro_sdk/registry/dto/projectEntity.dart';
import 'package:hydro_sdk/registry/dto/sessionDto.dart';
import 'package:hydro_sdk/registry/registryApi.dart';

class CreateProjectDialog extends StatefulWidget {
  final RegistryApi registryApi;
  final String name;
  final String description;
  final User user;

  const CreateProjectDialog({
    required this.registryApi,
    required this.name,
    required this.description,
    required this.user,
    Key? key,
  }) : super(
          key: key,
        );

  @override
  _CreateProjectDialogState createState() => _CreateProjectDialogState();
}

class _CreateProjectDialogState extends State<CreateProjectDialog> {
  ProjectEntity? createProjectResponse;

  @override
  void initState() {
    widget.user.getIdToken().then(
          (value) => widget.registryApi
              .createProject(
                dto: CreateProjectDto(
                  name: widget.name,
                  description: widget.description,
                ),
                sessionDto: SessionDto(
                  authToken: value,
                ),
              )
              .then(
                (value) => mounted
                    ? setState(() => createProjectResponse = value)
                    : null,
              ),
        );

    super.initState();
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
        title: createProjectResponse == null
            ? const Text("Creating Project")
            : Text("Created project ${widget.name}"),
        actions: [
          createProjectResponse != null
              ? TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text(
                    "Done",
                    textAlign: TextAlign.end,
                  ))
              : const SizedBox()
        ],
        content: createProjectResponse == null
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
                ],
              )
            : const SizedBox(),
      );
}

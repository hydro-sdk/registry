import 'package:flutter/material.dart';
import 'package:hydro_sdk/registry/dto/componentReadDto.dart';
import 'package:hydro_sdk/registry/dto/packageReadDto.dart';
import 'package:hydro_sdk/registry/dto/projectEntity.dart';
import 'package:hydro_sdk/registry/dto/projectReadDto.dart';
import 'package:hydro_sdk/registry/dto/releaseChannelReadDto.dart';
import 'package:hydro_sdk/registry/registryApi.dart';
import 'package:registry/widgets/appScaffold.dart';
import 'package:registry/widgets/releaseChannelDetails.dart';

class ProjectDetailsPage extends StatefulWidget {
  final RegistryApi registryApi;
  final String projectId;

  ProjectDetailsPage({
    required this.registryApi,
    required this.projectId,
  });

  @override
  _ProjectDetailsPageState createState() => _ProjectDetailsPageState();
}

class _ProjectDetailsPageState extends State<ProjectDetailsPage> {
  _ProjectDetailsPageState();

  ProjectEntity? projectReadDto;

  @override
  void initState() {
    widget.registryApi
        .getProjectById(projectId: widget.projectId)
        .then((value) {
      if (mounted) {
        setState(() {
          projectReadDto = value;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: projectReadDto == null
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.only(
                left: 30,
                right: 30,
              ),
              child: ListView(
                shrinkWrap: true,
                children: [],
              ),
            ),
    );
  }
}

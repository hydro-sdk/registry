import 'package:flutter/material.dart';
import 'package:hydro_sdk/registry/dto/componentReadDto.dart';
import 'package:hydro_sdk/registry/dto/packageReadDto.dart';
import 'package:hydro_sdk/registry/dto/releaseChannelReadDto.dart';
import 'package:hydro_sdk/registry/registryApi.dart';
import 'package:registry/widgets/appScaffold.dart';
import 'package:registry/widgets/releaseChannelDetails.dart';

class ComponentDetailsPage extends StatefulWidget {
  final RegistryApi registryApi;
  final String projectName;
  final String componentName;

  ComponentDetailsPage({
    required this.registryApi,
    required this.projectName,
    required this.componentName,
  });

  @override
  _ComponentDetailsPageState createState() => _ComponentDetailsPageState();
}

class _ComponentDetailsPageState extends State<ComponentDetailsPage> {
  ComponentReadDto? componentReadDto;
  List<ReleaseChannelReadDto>? releaseChannelDtos;
  List<PackageReadDto>? packageReadDtos;

  @override
  void initState() {
    widget.registryApi
        .getComponentByNameInProjectByName(
      projectName: widget.projectName,
      componentName: widget.componentName,
    )
        .then((value) async {
      await Future<void>.delayed(const Duration(seconds: 1));
      if (mounted) {
        setState(() {
          componentReadDto = value;
        });
      }

      await widget.registryApi
          .getAllReleaseChannelsByComponentId(componentId: value.id)
          .then((value) async {
        await Future<void>.delayed(const Duration(seconds: 1));
        if (mounted) {
          setState(() {
            releaseChannelDtos = value;
          });
        }
      });
    });

    ;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: componentReadDto == null || (releaseChannelDtos?.isEmpty ?? true)
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.only(
                left: 30,
                right: 30,
              ),
              child: ListView(
                children: [
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          componentReadDto?.name ?? "",
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Card(
                    child: ReleaseChannelDetails(
                      registryApi: widget.registryApi,
                      releaseChannelReadDto: releaseChannelDtos!.first,
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
    );
  }
}

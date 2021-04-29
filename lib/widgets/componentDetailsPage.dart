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
  ReleaseChannelReadDto? selectedReleaseChannel;

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
            selectedReleaseChannel = value.first;
          });
        }
      });
    });

    ;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(releaseChannelDtos);
    return AppScaffold(
      child: componentReadDto == null || (releaseChannelDtos?.isEmpty ?? true)
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.only(
                left: 30,
                right: 30,
              ),
              child: ListView(
                shrinkWrap: true,
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
                  Row(
                    children: [
                      const Text(
                        "Channel:",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      DropdownButton<ReleaseChannelReadDto>(
                        items: releaseChannelDtos!
                            .map((x) => DropdownMenuItem<ReleaseChannelReadDto>(
                                  value: x,
                                  child: Text(x.name),
                                ))
                            .toList(),
                        value: selectedReleaseChannel,
                        onChanged: (value) {
                          if (mounted) {
                            setState(() {
                              selectedReleaseChannel = value;
                            });
                          }
                        },
                      ),
                    ],
                  ),
                  ReleaseChannelDetails(
                    registryApi: widget.registryApi,
                    releaseChannelReadDto: selectedReleaseChannel!,
                    projectName: widget.projectName,
                    componentName: widget.componentName,
                    releaseChannelName: selectedReleaseChannel!.name,
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
    );
  }
}

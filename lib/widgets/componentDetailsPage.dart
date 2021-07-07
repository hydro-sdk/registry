import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hydro_sdk/registry/dto/releaseChannelReadDto.dart';
import 'package:hydro_sdk/registry/registryApi.dart';
import 'package:registry/hooks/useAllReleaseChannelsByComponentId.dart';
import 'package:registry/hooks/useComponentById.dart';
import 'package:registry/hooks/useProjectById.dart';
import 'package:registry/widgets/appScaffold.dart';
import 'package:registry/widgets/releaseChannelDetails.dart';

class ComponentDetailsPage extends StatefulHookWidget {
  final RegistryApi registryApi;
  final String componentId;

  ComponentDetailsPage({
    required this.registryApi,
    required this.componentId,
  });

  @override
  _ComponentDetailsPageState createState() => _ComponentDetailsPageState();
}

class _ComponentDetailsPageState extends State<ComponentDetailsPage> {
  ReleaseChannelReadDto? selectedReleaseChannel;

  @override
  Widget build(BuildContext context) {
    final component = useComponentById(
      widget.componentId,
      registryApi: widget.registryApi,
    );
    final releaseChannels = useReleaseChannelsByComponentId(
      widget.componentId,
      registryApi: widget.registryApi,
    );
    final project = useProjectById(
      component?.projectId ?? "",
      registryApi: widget.registryApi,
    );

    return AppScaffold(
      child: component == null ||
              project == null ||
              (releaseChannels?.isEmpty ?? true)
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
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: Text(
                          component.name,
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
                        items: releaseChannels!
                            .map((x) => DropdownMenuItem<ReleaseChannelReadDto>(
                                  value: x,
                                  child: Text(x.name),
                                ))
                            .toList(),
                        value: selectedReleaseChannel ?? releaseChannels.first,
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
                    releaseChannelReadDto:
                        selectedReleaseChannel ?? releaseChannels.first,
                    projectName: project.name,
                    componentName: component.name,
                    releaseChannelName: selectedReleaseChannel?.name ??
                        releaseChannels.first.name,
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
    );
  }
}

import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hydro_sdk/registry/registryApi.dart';
import 'package:registry/hooks/useComponentsInProjectById.dart';

class ProjectComponentsList extends HookWidget {
  final String projectId;
  final RegistryApi registryApi;

  const ProjectComponentsList({
    required this.projectId,
    required this.registryApi,
    Key? key,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    final components = useComponentsInProjectById(
      projectId,
      registryApi: registryApi,
    );

    return (components?.isNotEmpty ?? false)
        ? Column(
            children: components!
                .map((x) => Column(
                      children: [Text(x.name)],
                    ))
                .toList(),
          )
        : const Text(
            "No components",
          );
  }
}

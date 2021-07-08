import 'package:flutter/widgets.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hydro_sdk/registry/registryApi.dart';

import 'package:registry/hooks/useComponentsInProjectById.dart';
import 'package:registry/widgets/entryCard.dart';

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: components!
                .map(
                  (x) => EntryCard(
                    title: x.name,
                    subTitle: x.description,
                    onTap: () {},
                  ),
                )
                .toList(),
          )
        : const Text(
            "No components",
          );
  }
}

import 'package:flutter/material.dart';
import 'package:hydro_sdk/registry/dto/componentReadDto.dart';
import 'package:hydro_sdk/registry/registryApi.dart';
import 'package:registry/widgets/appScaffold.dart';

class ComponentDetailsPage extends StatelessWidget {
  final RegistryApi registryApi;
  final String projectName;
  final String componentName;

  ComponentDetailsPage({
    required this.registryApi,
    required this.projectName,
    required this.componentName,
  });

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: ListView(
        shrinkWrap: true,
        children: [
          FutureBuilder<ComponentReadDto>(
              future: registryApi.getComponentByNameInProjectByName(
                projectName: projectName,
                componentName: componentName,
              ),
              builder: (context, snapshot) {
                print(snapshot.error);
                switch (snapshot.connectionState) {
                  case ConnectionState.done:
                    return Text(snapshot.data?.name ?? "");
                }

                return const SizedBox();
              })
        ],
      ),
    );
  }
}

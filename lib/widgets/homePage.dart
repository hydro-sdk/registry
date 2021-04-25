import 'package:flutter/material.dart';
import 'package:hydro_sdk/registry/registryApi.dart';
import 'package:registry/widgets/appScaffold.dart';
import 'package:registry/widgets/searchComponentsTextField.dart';

class HomePage extends StatelessWidget {
  final RegistryApi registryApi;

  const HomePage({
    required this.registryApi,
  });

  @override
  Widget build(BuildContext context) => AppScaffold(
        child: Stack(
          children: [
            Container(
              color: const Color(0x75166132),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2.2,
            ),
            Padding(
                padding: const EdgeInsets.only(
                  left: 100,
                  right: 100,
                  top: 35,
                ),
                child: SearchComponentsTextField(
                  registryApi: registryApi,
                )),
          ],
        ),
      );
}

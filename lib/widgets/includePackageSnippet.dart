import 'package:flutter/material.dart';
import 'package:hydro_sdk/registry/dto/packageReadDto.dart';
import 'package:registry/widgets/syntaxHighlighter.dart';

class IncludePackageSnippet extends StatelessWidget {
  final PackageReadDto packageReadDto;
  final String projectName;
  final String componentName;
  final String releaseChannelName;

  const IncludePackageSnippet({
    required this.packageReadDto,
    required this.projectName,
    required this.componentName,
    required this.releaseChannelName,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Include this component in your app",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          decoration: BoxDecoration(
            color: const Color.fromRGBO(246, 246, 246, 1),
            border: Border.all(
              color: Colors.black,
            ),
          ),
          child: Material(
            child: InkWell(
              onHover: (_) {},
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: RichText(
                  text: DartSyntaxHighlighter().format("""
RunComponent(
    project: "$projectName",
    component: "$componentName",
    channel: "$releaseChannelName",
    publicKey: "${packageReadDto.deploymentPublicKey.characters.take(45)}...",
  )
  """),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

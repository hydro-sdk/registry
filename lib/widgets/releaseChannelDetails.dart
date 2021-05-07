import 'package:flutter/material.dart';
import 'package:hydro_sdk/registry/dto/componentReadDto.dart';
import 'package:hydro_sdk/registry/dto/packageReadDto.dart';
import 'package:hydro_sdk/registry/dto/releaseChannelReadDto.dart';
import 'package:hydro_sdk/registry/registryApi.dart';
import 'package:registry/widgets/appScaffold.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:registry/widgets/includePackageSnippet.dart';

class ReleaseChannelDetails extends StatefulWidget {
  final RegistryApi registryApi;
  final ReleaseChannelReadDto releaseChannelReadDto;
  final String projectName;
  final String componentName;
  final String releaseChannelName;

  ReleaseChannelDetails({
    required this.registryApi,
    required this.releaseChannelReadDto,
    required this.projectName,
    required this.componentName,
    required this.releaseChannelName,
  });

  @override
  _ReleaseChannelDetailsState createState() => _ReleaseChannelDetailsState();
}

class _ReleaseChannelDetailsState extends State<ReleaseChannelDetails> {
  PackageReadDto? packageReadDto;

  @override
  void initState() {
    widget.registryApi
        .getLatestMetadataForReleaseChannelId(
            releaseChannelId: widget.releaseChannelReadDto.id)
        .then((value) async {
      await Future<void>.delayed(const Duration(seconds: 1));
      if (mounted) {
        setState(() {
          packageReadDto = value;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return packageReadDto == null
        ? const Center(child: CircularProgressIndicator())
        : Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Version: " + packageReadDto!.displayVersion,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: MarkdownBody(
                      shrinkWrap: true,
                      selectable: true,
                      onTapLink: (text, href, title) {
                        print(href);
                      },
                      data: packageReadDto?.readmeMd ?? "",
                    ),
                  ),
                  IncludePackageSnippet(
                    packageReadDto: packageReadDto!,
                    projectName: widget.projectName,
                    componentName: widget.componentName,
                    releaseChannelName: widget.releaseChannelName,
                  ),
                ],
              ),
            ],
          );
  }
}

import 'package:flutter/material.dart';
import 'package:hydro_sdk/registry/dto/componentReadDto.dart';
import 'package:hydro_sdk/registry/dto/packageReadDto.dart';
import 'package:hydro_sdk/registry/dto/releaseChannelReadDto.dart';
import 'package:hydro_sdk/registry/registryApi.dart';
import 'package:registry/widgets/appScaffold.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class ReleaseChannelDetails extends StatefulWidget {
  final RegistryApi registryApi;
  final ReleaseChannelReadDto releaseChannelReadDto;

  ReleaseChannelDetails({
    required this.registryApi,
    required this.releaseChannelReadDto,
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
        : MarkdownBody(
          shrinkWrap: true,
          selectable: true,
          onTapLink: (text, href, title) {
            print(href);
          },
          data: packageReadDto?.readmeMd ?? "");
  }
}

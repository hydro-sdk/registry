import 'package:flutter/material.dart';
import 'package:hydro_sdk/registry/dto/componentReadDto.dart';
import 'package:hydro_sdk/registry/dto/packageReadDto.dart';
import 'package:hydro_sdk/registry/dto/releaseChannelReadDto.dart';
import 'package:hydro_sdk/registry/registryApi.dart';
import 'package:registry/widgets/appScaffold.dart';

class ReleaseChannelDetails extends StatefulWidget {
  ReleaseChannelReadDto releaseChannelReadDto;

  ReleaseChannelDetails({
    required this.releaseChannelReadDto,
  });
  
  @override
  _ReleaseChannelDetailsState createState() => _ReleaseChannelDetailsState();
}

class _ReleaseChannelDetailsState extends State<ReleaseChannelDetails> {
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}
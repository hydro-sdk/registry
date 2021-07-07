import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hydro_sdk/registry/dto/releaseChannelReadDto.dart';
import 'package:hydro_sdk/registry/registryApi.dart';

List<ReleaseChannelReadDto>? useReleaseChannelsByComponentId(
  String componentId, {
  required RegistryApi registryApi,
}) =>
    use(_AllReleaseChannelsByComponentIdHook(
      componentId,
      registryApi: registryApi,
    ));

class _AllReleaseChannelsByComponentIdHook
    extends Hook<List<ReleaseChannelReadDto>?> {
  final String componentId;
  final RegistryApi registryApi;

  const _AllReleaseChannelsByComponentIdHook(
    this.componentId, {
    required this.registryApi,
  });

  @override
  __AllReleaseChannelsByComponentIdHookState createState() =>
      __AllReleaseChannelsByComponentIdHookState();
}

class __AllReleaseChannelsByComponentIdHookState extends HookState<
    List<ReleaseChannelReadDto>?, _AllReleaseChannelsByComponentIdHook> {
  List<ReleaseChannelReadDto>? releaseChannels;

  Future<void> _retreiveReleaseChannels() async {
    await hook.registryApi
        .getAllReleaseChannelsByComponentId(
      componentId: hook.componentId,
    )
        .then((value) {
      setState(() {
        releaseChannels = value;
      });
    });
  }

  @override
  void didUpdateHook(covariant _AllReleaseChannelsByComponentIdHook old) {
    if (old.componentId != hook.componentId) {
      _retreiveReleaseChannels();
    }

    super.didUpdateHook(old);
  }

  @override
  void initHook() {
    _retreiveReleaseChannels();
    super.initHook();
  }

  @override
  List<ReleaseChannelReadDto>? build(_) => releaseChannels;
}

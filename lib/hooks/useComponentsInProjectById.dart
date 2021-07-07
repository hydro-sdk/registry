import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hydro_sdk/registry/dto/componentReadDto.dart';
import 'package:hydro_sdk/registry/registryApi.dart';

List<ComponentReadDto>? useComponentsInProjectById(
  String projectId, {
  required RegistryApi registryApi,
}) =>
    use(_ComponentsInProjectByIdHook(
      projectId,
      registryApi: registryApi,
    ));

class _ComponentsInProjectByIdHook extends Hook<List<ComponentReadDto>?> {
  final String projectId;
  final RegistryApi registryApi;
  const _ComponentsInProjectByIdHook(
    this.projectId, {
    required this.registryApi,
  });

  @override
  _ComponentsInProjectByIdHookState createState() =>
      _ComponentsInProjectByIdHookState();
}

class _ComponentsInProjectByIdHookState
    extends HookState<List<ComponentReadDto>?, _ComponentsInProjectByIdHook> {
  List<ComponentReadDto>? components;

  Future<void> _retreiveProject() async {
    await hook.registryApi
        .getAllComponentsInProject(
      projectId: hook.projectId,
    )
        .then((value) {
      setState(() {
        components = value;
      });
    });
  }

  @override
  void didUpdateHook(covariant _ComponentsInProjectByIdHook old) {
    if (old.projectId != hook.projectId) {
      _retreiveProject();
    }

    super.didUpdateHook(old);
  }

  @override
  void initHook() {
    _retreiveProject();
    super.initHook();
  }

  @override
  List<ComponentReadDto>? build(_) => components;
}

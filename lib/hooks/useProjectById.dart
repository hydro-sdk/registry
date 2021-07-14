import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hydro_sdk/registry/dto/projectEntity.dart';
import 'package:hydro_sdk/registry/registryApi.dart';

ProjectEntity? useProjectById(
  String projectId, {
  required RegistryApi registryApi,
}) =>
    use(_ProjectByIdHook(
      projectId,
      registryApi: registryApi,
    ));

class _ProjectByIdHook extends Hook<ProjectEntity?> {
  final String projectId;
  final RegistryApi registryApi;
  const _ProjectByIdHook(
    this.projectId, {
    required this.registryApi,
  });

  @override
  _ProjectByIdHookState createState() => _ProjectByIdHookState();
}

class _ProjectByIdHookState
    extends HookState<ProjectEntity?, _ProjectByIdHook> {
  ProjectEntity? project;

  Future<void> _retreiveProject() async {
    await hook.registryApi
        .getProjectById(
      projectId: hook.projectId,
    )
        .then((value) {
      setState(() {
        project = value.maybeWhen(
          success: (val) => val.result,
          orElse: () => null,
        );
      });
    });
  }

  @override
  void didUpdateHook(covariant _ProjectByIdHook old) {
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
  ProjectEntity? build(_) => project;
}

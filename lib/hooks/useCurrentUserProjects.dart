import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hydro_sdk/registry/dto/projectEntity.dart';
import 'package:hydro_sdk/registry/dto/sessionDto.dart';
import 'package:hydro_sdk/registry/registryApi.dart';

List<ProjectEntity>? useCurrentUserProjects(
  User? user, {
  required RegistryApi registryApi,
}) =>
    use(_CurrentUserProjectsHook(
      user,
      registryApi: registryApi,
    ));

class _CurrentUserProjectsHook extends Hook<List<ProjectEntity>?> {
  final User? user;
  final RegistryApi registryApi;
  const _CurrentUserProjectsHook(
    this.user, {
    required this.registryApi,
  });

  @override
  _CurrentUserProjectsHookState createState() =>
      _CurrentUserProjectsHookState();
}

class _CurrentUserProjectsHookState
    extends HookState<List<ProjectEntity>?, _CurrentUserProjectsHook> {
  List<ProjectEntity>? projects;

  Future<void> _retreiveProjects() async {
    await hook.user?.getIdToken().then((value) => hook.registryApi
            .canUpdateProjects(
          sessionDto: SessionDto(
            authToken: value,
          ),
        )
            .then((value) {
          print(value);
          setState(() {
            projects = value.maybeWhen(
          success: (val) => val.result,
          orElse: () => null,
        );
          });
        }).onError((error, stackTrace) {
          print(error);
          print(stackTrace);
        }));
  }

  @override
  void didUpdateHook(covariant _CurrentUserProjectsHook old) {
    if (old.user != hook.user) {
      _retreiveProjects();
    }

    super.didUpdateHook(old);
  }

  @override
  void initHook() {
    _retreiveProjects();
    super.initHook();
  }

  @override
  List<ProjectEntity>? build(_) => projects;
}

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hydro_sdk/registry/dto/componentReadDto.dart';
import 'package:hydro_sdk/registry/registryApi.dart';

ComponentReadDto? useComponentById(
  String componentId, {
  required RegistryApi registryApi,
}) =>
    use(_ComponentByIdHook(
      componentId,
      registryApi: registryApi,
    ));

class _ComponentByIdHook extends Hook<ComponentReadDto?> {
  final String componentId;
  final RegistryApi registryApi;

  const _ComponentByIdHook(
    this.componentId, {
    required this.registryApi,
  });

  @override
  _ComponentByIdHookState createState() => _ComponentByIdHookState();
}

class _ComponentByIdHookState
    extends HookState<ComponentReadDto?, _ComponentByIdHook> {
  ComponentReadDto? component;

  Future<void> _retreiveComponent() async {
    await hook.registryApi
        .getComponentById(
      componentId: hook.componentId,
    )
        .then((value) {
      setState(() {
        component = value.maybeWhen(
          success: (val) => val.result,
          orElse: () => null,
        );
      });
    });
  }

  @override
  void didUpdateHook(covariant _ComponentByIdHook old) {
    if (old.componentId != hook.componentId) {
      _retreiveComponent();
    }

    super.didUpdateHook(old);
  }

  @override
  void initHook() {
    _retreiveComponent();
    super.initHook();
  }

  @override
  ComponentReadDto? build(_) => component;
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hydro_sdk/registry/dto/componentSearchDto.dart';
import 'package:hydro_sdk/registry/registryApi.dart';
import 'package:provider/provider.dart';
import 'package:registry/widgets/textSearchController.dart';
import 'package:registry/util/pushComponentDetails.dart';

class SearchComponentsResults extends StatelessWidget {
  final RegistryApi registryApi;

  SearchComponentsResults({
    required this.registryApi,
  });

  @override
  Widget build(BuildContext context) {
    final textSearchController = Provider.of<TextSearchController>(context);

    return _SearchComponentsResultsInner(
      textSearchController: textSearchController,
      registryApi: registryApi,
    );
  }
}

class _SearchComponentsResultsInner extends StatefulWidget {
  final TextSearchController textSearchController;
  final RegistryApi registryApi;

  _SearchComponentsResultsInner({
    required this.textSearchController,
    required this.registryApi,
  });
  @override
  __SearchComponentsResultsInnerState createState() =>
      __SearchComponentsResultsInnerState(
        textSearchController: textSearchController,
        registryApi: registryApi,
      );
}

class __SearchComponentsResultsInnerState
    extends State<_SearchComponentsResultsInner> {
  final TextSearchController textSearchController;
  final RegistryApi registryApi;

  __SearchComponentsResultsInnerState({
    required this.textSearchController,
    required this.registryApi,
  });

  StreamSubscription<List<ComponentSearchDto>>? searchRequest;
  List<ComponentSearchDto>? searchResults;
  bool searchInProgress = false;
  Timer? searchTimer;

  @override
  void initState() {
    super.initState();
    textSearchController.addListener(resetSearch);
    resetSearch();
    searchInProgress = true;
  }

  @override
  void dispose() {
    textSearchController.removeListener(resetSearch);
    super.dispose();
  }

  Timer debounce({
    required Timer? timer,
    required void Function() callback,
    required Duration duration,
  }) {
    if (timer?.isActive ?? false) {
      timer?.cancel();
    }
    return Timer(duration, callback);
  }

  void resetSearch() {
    if (mounted) {
      setState(() {
        searchInProgress = false;
      });
    }
    resetSearchResults();
    if (textSearchController.searchText?.isNotEmpty ?? false) {
      searchTimer = debounce(
        timer: searchTimer,
        callback: () {
          if (mounted) {
            setState(() {
              searchInProgress = true;
            });
          }
        },
        duration: const Duration(milliseconds: 1500),
      );
    }
  }

  void resetSearchResults() {
    if (mounted) {
      searchRequest?.cancel();
      setState(() {
        searchResults = null;
        if (textSearchController.searchText?.isNotEmpty ?? false) {
          searchRequest = registryApi
              .searchComponents(
                searchTerm: textSearchController.searchText,
              )
              .asStream()
              .listen((
            event,
          ) {
            if (mounted) {
              setState(() {
                searchResults = event.isNotEmpty ? event : null;
                searchInProgress = false;
              });
            }
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) => searchInProgress == true
      ? (searchResults == null)
          ? const ListTile(
              title: Text(
                "...",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : searchResults != null
              ? ListView(
                  shrinkWrap: true,
                  children: searchResults
                          ?.map(
                            (x) => ListTile(
                              title: Text(x.name),
                              subtitle: Text(x.description),
                              onTap: () => pushComponentDetails(
                                context: context,
                                componentName: x.name,
                                projectName: x.projectName,
                              ),
                            ),
                          )
                          .toList() ??
                      [],
                )
              : const ListTile(
                  title: Text("No Results"),
                )
      : const SizedBox();
}

import 'package:flutter/foundation.dart';

class TextSearchController extends ChangeNotifier {
  String? _searchText;
  String? get searchText => _searchText;

  void changeSearchText({
    required String? searchText,
  }) {
    _searchText = searchText;
    notifyListeners();
  }
}

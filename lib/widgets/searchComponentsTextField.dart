import 'package:flutter/material.dart';

class SearchComponentsTextField extends StatefulWidget {
  @override
  _SearchComponentsTextFieldState createState() =>
      _SearchComponentsTextFieldState();
}

class _SearchComponentsTextFieldState extends State<SearchComponentsTextField> {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController textEditingController = TextEditingController();
  late GlobalKey _key;
  bool _isMenuOpen = false;
  Offset? _tilePosition;
  Size? _tileSize;
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();

    _key = LabeledGlobalKey("searchBox");

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        openMenu();
      } else {
        closeMenu();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    closeMenu();
    _focusNode.dispose();
  }

  void findBox() {
    RenderBox? renderBox = _key.currentContext?.findRenderObject() as RenderBox;
    _tileSize = renderBox.size;
    _tilePosition = renderBox.localToGlobal(Offset.zero);
  }

  void closeMenu() {
    if (_isMenuOpen) {
      _focusNode.unfocus();
      _overlayEntry?.remove();
      _isMenuOpen = !_isMenuOpen;
    }
  }

  void toggleMenu() {
    if (_isMenuOpen) {
      closeMenu();
    } else {
      openMenu();
    }
  }

  void openMenu() {
    if (!_isMenuOpen) {
      findBox();
      _overlayEntry = _overlayEntryBuilder();

      if (_overlayEntry != null) {
        Overlay.of(context)?.insert(_overlayEntry!);
        _isMenuOpen = !_isMenuOpen;
      }
    }
  }

  OverlayEntry _overlayEntryBuilder() => OverlayEntry(
        builder: (context) => Stack(
          children: [
            Positioned.fill(
              child: GestureDetector(
                onTap: () => closeMenu(),
                child: Container(
                  color: Colors.transparent,
                ),
              ),
            ),
            Positioned(
              top: (_tilePosition?.dy ?? 0) + (_tileSize?.height ?? 0),
              left: _tilePosition != null ? _tilePosition!.dx + 40 : 0,
              width: _tileSize != null ? _tileSize!.width - 40 : 0,
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () => toggleMenu(),
                child: Material(
                  elevation: 4.0,
                  child: ListView(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    children: <Widget>[
                      const ListTile(
                        title: Text('Foo'),
                      ),
                      const ListTile(
                        title: Text('Bar'),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: _focusNode,
      controller: textEditingController,
      key: _key,
      decoration: const InputDecoration(
        icon: Icon(Icons.search),
        filled: true,
        fillColor: Colors.black12,
        border: OutlineInputBorder(),
        labelText: "Search Components",
      ),
    );
  }
}

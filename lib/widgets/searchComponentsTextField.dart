import 'package:flutter/material.dart';
import 'package:registry/widgets/textSearchController.dart';

class SearchComponentsTextField extends StatefulWidget {
  @override
  _SearchComponentsTextFieldState createState() =>
      _SearchComponentsTextFieldState();
}

class _SearchComponentsTextFieldState extends State<SearchComponentsTextField> {
  final FocusNode focusNode = FocusNode();
  final TextEditingController textEditingController = TextEditingController();
  final TextSearchController textSearchController = TextSearchController();
  late GlobalKey _key;
  bool isMenuOpen = false;
  Offset? tilePosition;
  Size? tilesize;
  OverlayEntry? overlayEntry;

  @override
  void initState() {
    super.initState();

    _key = LabeledGlobalKey("searchBox");

    focusNode.addListener(() {
      if (focusNode.hasFocus) {
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
    focusNode.dispose();
  }

  void findBox() {
    RenderBox? renderBox = _key.currentContext?.findRenderObject() as RenderBox;
    tilesize = renderBox.size;
    tilePosition = renderBox.localToGlobal(Offset.zero);
  }

  void closeMenu() {
    if (isMenuOpen) {
      focusNode.unfocus();
      overlayEntry?.remove();
      isMenuOpen = !isMenuOpen;
    }
  }

  void toggleMenu() {
    if (isMenuOpen) {
      closeMenu();
    } else {
      openMenu();
    }
  }

  void openMenu() {
    if (!isMenuOpen) {
      findBox();
      overlayEntry = overlayEntryBuilder();

      if (overlayEntry != null) {
        Overlay.of(context)?.insert(overlayEntry!);
        isMenuOpen = !isMenuOpen;
      }
    }
  }

  OverlayEntry overlayEntryBuilder() => OverlayEntry(
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
              top: (tilePosition?.dy ?? 0) + (tilesize?.height ?? 0),
              left: tilePosition != null ? tilePosition!.dx + 40 : 0,
              width: tilesize != null ? tilesize!.width - 40 : 0,
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
      focusNode: focusNode,
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

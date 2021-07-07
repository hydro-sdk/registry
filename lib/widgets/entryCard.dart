import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class EntryCard extends StatelessWidget {
  final String title;
  final String subTitle;
  final void Function() onTap;

  const EntryCard({
    required this.title,
    required this.subTitle,
    required this.onTap,
    Key? key,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) => Container(
        width: MediaQuery.of(context).size.width / 4,
        height: 125,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
        ),
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            splashColor: Colors.black,
            onTap: () => onTap(),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    subTitle,
                    style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                        fontWeight: FontWeight.w300),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}

import 'package:flutter/material.dart';

class CellShell extends StatelessWidget {
  const CellShell({
    super.key,
    this.color = Colors.transparent,
    this.size = 50,
    this.iconData,
    this.onLeftClick,
    this.onRightClick,
    this.bombNumber,
    this.bombNumberColor,
  });

  final Color? color;
  final double size;
  final IconData? iconData;
  final void Function()? onLeftClick;
  final void Function()? onRightClick;
  final int? bombNumber;
  final Color? bombNumberColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1),
      child: Material(
        child: InkWell(
          onTap: onLeftClick,
          onSecondaryTap: onRightClick,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(width: 1),
              color: color,
            ),
            width: size,
            height: size,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (iconData != null) Icon(iconData),
                if (bombNumber != null && bombNumber != 0)
                  Stack(
                    children: [
                      Text(
                        bombNumber.toString(),
                        style: TextStyle(
                          fontSize: size * (2 / 5),
                          foreground: Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 2
                            ..color = Colors.black,
                        ),
                      ),
                      Text(
                        bombNumber.toString(),
                        style: TextStyle(
                          fontSize: size * (2 / 5),
                          color: bombNumberColor,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

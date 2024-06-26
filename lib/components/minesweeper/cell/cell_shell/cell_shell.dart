import 'package:flutter/material.dart';
import 'package:flutter_minesweeper/components/minesweeper/cell/cell_state/cell_state.dart';

class CellShell extends StatelessWidget {
  const CellShell({
    super.key,
    required this.state,
    this.color = Colors.transparent,
    this.size = 50,
    this.iconData,
    this.onLeftClick,
    this.onRightClick,
    this.bombNumber,
    this.bombNumberColor,
  });

  final CellState state;
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
            child: Stack(
              alignment: Alignment.center,
              children: [
                Column(
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '(${state.x.toString()}, ${state.y.toString()})',
                          style: const TextStyle(fontSize: 10),
                        ),
                      ],
                    )
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

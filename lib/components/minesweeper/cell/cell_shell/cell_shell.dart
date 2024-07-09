import 'package:flutter/material.dart';
import 'package:flutter_minesweeper/components/minesweeper/cell/cell_state/cell_state.dart';

class CellShell extends StatelessWidget {
  const CellShell({
    required this.state,
    required this.size,
    this.color = Colors.transparent,
    this.iconData,
    this.onLeftClick,
    this.onRightClick,
    this.bombNumber,
    this.bombNumberColor,
    this.showBombCoords = false,
    super.key,
  });

  final CellState state;
  final Color? color;
  final double size;
  final IconData? iconData;
  final void Function()? onLeftClick;
  final void Function()? onRightClick;
  final int? bombNumber;
  final Color? bombNumberColor;
  final bool showBombCoords;

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
            width: size - 2,
            height: size - 2,
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
                if (showBombCoords)
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

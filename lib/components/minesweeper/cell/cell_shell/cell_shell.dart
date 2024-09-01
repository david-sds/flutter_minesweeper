import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_minesweeper/components/minesweeper/cell/cell_state/cell_state.dart';

class CellShell extends StatelessWidget {
  const CellShell({
    required this.state,
    required this.size,
    this.color = Colors.transparent,
    this.image,
    this.onLeftClick,
    this.onRightClick,
    this.bombNumber,
    this.bombNumberColor,
    this.showHover = true,
    this.showBombCoords = false,
    super.key,
  });

  final CellState state;
  final Color? color;
  final double size;
  final Widget? image;
  final void Function()? onLeftClick;
  final void Function()? onRightClick;
  final int? bombNumber;
  final Color? bombNumberColor;
  final bool showHover;
  final bool showBombCoords;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          hoverColor: showHover ? null : Colors.transparent,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          focusColor: Colors.transparent,
          onTap: onLeftClick,
          onSecondaryTap: onRightClick,
          onLongPress: !kIsWeb && (Platform.isAndroid || Platform.isIOS)
              ? onRightClick
              : null,
          child: Padding(
            padding: const EdgeInsets.all(.5),
            child: Container(
              decoration: BoxDecoration(border: Border.all(width: .5)),
              width: size - 1,
              height: size - 1,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (image != null)
                        SizedBox(
                          width: size * .60,
                          child: image,
                        ),
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
      ),
    );
  }
}

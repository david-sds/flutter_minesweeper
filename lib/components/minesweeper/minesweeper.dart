import 'package:flutter/material.dart';
import 'package:flutter_minesweeper/components/minesweeper/cell/cell.dart';
import 'package:flutter_minesweeper/components/minesweeper/face/face.dart';
import 'package:flutter_minesweeper/components/minesweeper/minesweeper_controller.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

enum Difficulty {
  classic(
    x: 8,
    y: 8,
    bombNumber: 9,
  ),
  easy(
    x: 9,
    y: 9,
    bombNumber: 10,
  ),
  medium(
    x: 16,
    y: 16,
    bombNumber: 40,
  ),
  expert(
    x: 30,
    y: 16,
    bombNumber: 99,
  );

  const Difficulty({
    required this.x,
    required this.y,
    required this.bombNumber,
  });

  final int x;
  final int y;
  final int bombNumber;
}

class Minesweeper extends StatefulWidget {
  const Minesweeper({
    required this.initialDifficulty,
    super.key,
  });

  final Difficulty initialDifficulty;

  @override
  State<Minesweeper> createState() => _MinesweeperState();
}

class _MinesweeperState extends State<Minesweeper> {
  final ctrl = MinesweeperController();

  @override
  initState() {
    ctrl.initBoard(widget.initialDifficulty);
    super.initState();
  }

  double getCellSize(BoxConstraints constraints) {
    var maxCellSizeWidth = 30.0;
    var maxCellSizeHeight = 30.0;

    if (ctrl.difficulty.x * maxCellSizeWidth > constraints.maxWidth) {
      maxCellSizeWidth = constraints.maxWidth / ctrl.difficulty.x;
    }

    if (ctrl.difficulty.y * maxCellSizeHeight > constraints.maxHeight) {
      maxCellSizeHeight = constraints.maxHeight / ctrl.difficulty.y;
    }

    return maxCellSizeWidth < maxCellSizeHeight
        ? maxCellSizeWidth
        : maxCellSizeHeight;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Observer(builder: (context) {
          return Stack(
            children: [
              Center(
                child: Face(
                  state: ctrl.gameState,
                  onTap: () {
                    ctrl.initBoard(ctrl.difficulty);
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  DropdownButton<Difficulty>(
                    value: ctrl.difficulty,
                    items: Difficulty.values
                        .map((value) => DropdownMenuItem(
                              value: value,
                              child: Text(
                                value.name,
                              ),
                            ))
                        .toList(),
                    onChanged: (value) {
                      if (value != null) ctrl.initBoard(value);
                    },
                  ),
                ],
              ),
            ],
          );
        }),
        Expanded(
          child: LayoutBuilder(builder: (context, constraints) {
            return Container(
              color: Colors.grey[600],
              child: Observer(builder: (context) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    ctrl.boardState.length,
                    (x) {
                      return Container(
                        color: Colors.black,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: List.generate(
                            ctrl.boardState[x].length,
                            (y) {
                              return Cell(
                                cellSize: getCellSize(constraints),
                                state: ctrl.boardState[x][y],
                                gameState: ctrl.gameState,
                                neighborCells: ctrl.getNeighborCells(
                                  ctrl.boardState[x][y],
                                ),
                                onChangeState: (state) {
                                  ctrl.updateCellState(state);
                                },
                                onClearSurroundingCells: (state) {
                                  ctrl.clearSurroundingCells(state);
                                },
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                );
              }),
            );
          }),
        ),
      ],
    );
  }
}

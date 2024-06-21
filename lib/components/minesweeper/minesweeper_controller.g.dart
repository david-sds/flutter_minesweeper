// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'minesweeper_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MinesweeperController on MinesweeperControllerBase, Store {
  Computed<List<List<CellState>>>? _$boardStateComputed;

  @override
  List<List<CellState>> get boardState => (_$boardStateComputed ??=
          Computed<List<List<CellState>>>(() => super.boardState,
              name: 'MinesweeperControllerBase.boardState'))
      .value;

  late final _$_boardStateAtom =
      Atom(name: 'MinesweeperControllerBase._boardState', context: context);

  @override
  List<List<CellState>> get _boardState {
    _$_boardStateAtom.reportRead();
    return super._boardState;
  }

  @override
  set _boardState(List<List<CellState>> value) {
    _$_boardStateAtom.reportWrite(value, super._boardState, () {
      super._boardState = value;
    });
  }

  late final _$MinesweeperControllerBaseActionController =
      ActionController(name: 'MinesweeperControllerBase', context: context);

  @override
  void initBoard(Difficulty difficulty) {
    final _$actionInfo = _$MinesweeperControllerBaseActionController
        .startAction(name: 'MinesweeperControllerBase.initBoard');
    try {
      return super.initBoard(difficulty);
    } finally {
      _$MinesweeperControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateCellState(int x, int y, CellState value) {
    final _$actionInfo = _$MinesweeperControllerBaseActionController
        .startAction(name: 'MinesweeperControllerBase.updateCellState');
    try {
      return super.updateCellState(x, y, value);
    } finally {
      _$MinesweeperControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
boardState: ${boardState}
    ''';
  }
}

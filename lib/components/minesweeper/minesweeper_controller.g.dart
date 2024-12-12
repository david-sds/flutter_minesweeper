// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'minesweeper_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MinesweeperController on MinesweeperControllerBase, Store {
  Computed<Difficulty>? _$difficultyComputed;

  @override
  Difficulty get difficulty =>
      (_$difficultyComputed ??= Computed<Difficulty>(() => super.difficulty,
              name: 'MinesweeperControllerBase.difficulty'))
          .value;
  Computed<List<List<CellState>>>? _$boardStateComputed;

  @override
  List<List<CellState>> get boardState => (_$boardStateComputed ??=
          Computed<List<List<CellState>>>(() => super.boardState,
              name: 'MinesweeperControllerBase.boardState'))
      .value;
  Computed<GameState>? _$gameStateComputed;

  @override
  GameState get gameState =>
      (_$gameStateComputed ??= Computed<GameState>(() => super.gameState,
              name: 'MinesweeperControllerBase.gameState'))
          .value;
  Computed<int>? _$numberFlaggedComputed;

  @override
  int get numberFlagged =>
      (_$numberFlaggedComputed ??= Computed<int>(() => super.numberFlagged,
              name: 'MinesweeperControllerBase.numberFlagged'))
          .value;

  late final _$_difficultyAtom =
      Atom(name: 'MinesweeperControllerBase._difficulty', context: context);

  @override
  Difficulty get _difficulty {
    _$_difficultyAtom.reportRead();
    return super._difficulty;
  }

  @override
  set _difficulty(Difficulty value) {
    _$_difficultyAtom.reportWrite(value, super._difficulty, () {
      super._difficulty = value;
    });
  }

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
  void setDifficulty(Difficulty difficulty) {
    final _$actionInfo = _$MinesweeperControllerBaseActionController
        .startAction(name: 'MinesweeperControllerBase.setDifficulty');
    try {
      return super.setDifficulty(difficulty);
    } finally {
      _$MinesweeperControllerBaseActionController.endAction(_$actionInfo);
    }
  }

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
  void updateCellStates(List<CellState> values) {
    final _$actionInfo = _$MinesweeperControllerBaseActionController
        .startAction(name: 'MinesweeperControllerBase.updateCellStates');
    try {
      return super.updateCellStates(values);
    } finally {
      _$MinesweeperControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateCellState(CellState value) {
    final _$actionInfo = _$MinesweeperControllerBaseActionController
        .startAction(name: 'MinesweeperControllerBase.updateCellState');
    try {
      return super.updateCellState(value);
    } finally {
      _$MinesweeperControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearSurroundingCells(CellState value) {
    final _$actionInfo = _$MinesweeperControllerBaseActionController
        .startAction(name: 'MinesweeperControllerBase.clearSurroundingCells');
    try {
      return super.clearSurroundingCells(value);
    } finally {
      _$MinesweeperControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
difficulty: ${difficulty},
boardState: ${boardState},
gameState: ${gameState},
numberFlagged: ${numberFlagged}
    ''';
  }
}

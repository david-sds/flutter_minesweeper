// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cronometer_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CronometerController on _CronometerControllerBase, Store {
  Computed<double>? _$elapsedTimeComputed;

  @override
  double get elapsedTime =>
      (_$elapsedTimeComputed ??= Computed<double>(() => super.elapsedTime,
              name: '_CronometerControllerBase.elapsedTime'))
          .value;
  Computed<bool>? _$isStartedComputed;

  @override
  bool get isStarted =>
      (_$isStartedComputed ??= Computed<bool>(() => super.isStarted,
              name: '_CronometerControllerBase.isStarted'))
          .value;
  Computed<bool>? _$isEndedComputed;

  @override
  bool get isEnded => (_$isEndedComputed ??= Computed<bool>(() => super.isEnded,
          name: '_CronometerControllerBase.isEnded'))
      .value;

  late final _$_isStartedAtom =
      Atom(name: '_CronometerControllerBase._isStarted', context: context);

  @override
  bool get _isStarted {
    _$_isStartedAtom.reportRead();
    return super._isStarted;
  }

  @override
  set _isStarted(bool value) {
    _$_isStartedAtom.reportWrite(value, super._isStarted, () {
      super._isStarted = value;
    });
  }

  late final _$_isEndedAtom =
      Atom(name: '_CronometerControllerBase._isEnded', context: context);

  @override
  bool get _isEnded {
    _$_isEndedAtom.reportRead();
    return super._isEnded;
  }

  @override
  set _isEnded(bool value) {
    _$_isEndedAtom.reportWrite(value, super._isEnded, () {
      super._isEnded = value;
    });
  }

  late final _$_CronometerControllerBaseActionController =
      ActionController(name: '_CronometerControllerBase', context: context);

  @override
  void start() {
    final _$actionInfo = _$_CronometerControllerBaseActionController
        .startAction(name: '_CronometerControllerBase.start');
    try {
      return super.start();
    } finally {
      _$_CronometerControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void stop() {
    final _$actionInfo = _$_CronometerControllerBaseActionController
        .startAction(name: '_CronometerControllerBase.stop');
    try {
      return super.stop();
    } finally {
      _$_CronometerControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void reset() {
    final _$actionInfo = _$_CronometerControllerBaseActionController
        .startAction(name: '_CronometerControllerBase.reset');
    try {
      return super.reset();
    } finally {
      _$_CronometerControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
elapsedTime: ${elapsedTime},
isStarted: ${isStarted},
isEnded: ${isEnded}
    ''';
  }
}

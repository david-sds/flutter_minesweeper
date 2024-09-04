import 'package:mobx/mobx.dart';

part 'cronometer_controller.g.dart';

class CronometerController extends _CronometerControllerBase
    with _$CronometerController {}

abstract class _CronometerControllerBase with Store {
  final Stopwatch _stopwatch = Stopwatch();

  @computed
  double get elapsedTime {
    if (!_isEnded && !_isStarted) {
      return 0.0;
    }
    return _stopwatch.elapsed.inMilliseconds / 1000;
  }

  @observable
  bool _isStarted = false;
  @computed
  bool get isStarted => _isStarted;

  @observable
  bool _isEnded = false;
  @computed
  bool get isEnded => _isEnded;

  @action
  void start() {
    _stopwatch.start();
    _isStarted = true;
  }

  @action
  void stop() {
    _stopwatch.stop();
    _isEnded = true;
  }

  @action
  void reset() {
    _stopwatch.stop();
    _stopwatch.reset();
    _isEnded = false;
    _isStarted = false;
  }
}

import 'dart:async';

class CountdownTimer {
  CountdownTimer(int duration) {
    _duration = duration;
  }

  int _duration;
  Duration _interval = Duration(seconds: 1);
  StreamController _controller = StreamController<int>();
  Timer _timer;
  int _elapsedSeconds = 0;

  Stream get stream => _controller.stream;

  void start() {
    if (_elapsedSeconds == 0) {
      _controller.sink.add(_duration);
    }
    _timer = Timer.periodic(_interval, _tick);
  }

  void pause() {
    if (_timer != null) {
      _timer.cancel();
    }
  }

  void cancel() {
    _timer.cancel();
    _controller.close();
  }

  void _tick(Timer timer) {
    _elapsedSeconds++;
    _controller.sink.add(_duration - _elapsedSeconds);
    if (_elapsedSeconds == _duration) {
      cancel();
    }
  }
}

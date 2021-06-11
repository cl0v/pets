import 'dart:async';

class SimpleBloc<T> {
  final _controller = StreamController<T>.broadcast();
  Stream<T> get stream => _controller.stream;

  add(T obj) {
    if (!_controller.isClosed) {
      _controller.add(obj);
    }
  }

  subscribe(Stream<T> s) {
    _controller.addStream(s);
  }

  addError(Object obj) {
    if (!_controller.isClosed) {
      _controller.addError(obj);
    }
  }

  dispose() {
    _controller.close();
  }
}

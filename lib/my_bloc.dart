// ignore_for_file: avoid_print

import 'dart:async';

class MyBloc {
  final StreamController<int> _stateStreamController = StreamController<int>();

  StreamSink get _stateStreamSink => _stateStreamController.sink;
  Stream<int> get stateStream => _stateStreamController.stream;

  final StreamController<Event> _eventStreamController =
      StreamController<Event>();

  StreamSink get eventStreamSink => _eventStreamController.sink;
  Stream<Event> get _eventStream => _eventStreamController.stream;

  MyBloc() {
    _eventStream.listen((event) {
      print(event);
      // int incrementedEkvent =
      businessLogic(event); // Get the incremented value
      // _stateStreamSink.add(event);
    });
  }

  void businessLogic(Event event) {
    // return event + 1; // Increment the event and return the modified value

    int? value;
    if (event is IncrementEvents) {
      value = event.value;
      value++;
    } else if (event is DecrementEvents) {
      value = event.value;
      value--;
    }
    _stateStreamSink.add(value);
  }
}

abstract class Event {}

class IncrementEvents extends Event {
  int value;
  IncrementEvents({required this.value});
}

class DecrementEvents extends Event {
  int value;
  DecrementEvents({required this.value});
}

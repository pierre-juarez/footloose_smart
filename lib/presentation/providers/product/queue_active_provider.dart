import 'package:flutter_riverpod/flutter_riverpod.dart';

class QueueActiveProvider extends StateNotifier<Map<String, bool>> {
  QueueActiveProvider() : super({"activeQueue": false});

  void changeState() {
    state = {...state, "activeQueue": true};
  }

  void disableQueue() {
    state = {...state, "activeQueue": false};
  }
}

final queueActiveProvider = StateNotifierProvider<QueueActiveProvider, Map<String, bool>>(
  (ref) => QueueActiveProvider(),
);

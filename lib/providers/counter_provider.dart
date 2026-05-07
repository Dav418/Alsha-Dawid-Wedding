import 'package:flutter_riverpod/flutter_riverpod.dart';

final counterProvider =
    NotifierProvider.autoDispose<CounterNotifier, int>(CounterNotifier.new);

class CounterNotifier extends AutoDisposeNotifier<int> {
  @override
  int build() => 0;

  void increment() => state++;
}

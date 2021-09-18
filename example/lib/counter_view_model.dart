import 'package:published/published.dart';

part 'counter_view_model.published.dart';

@published
abstract class CounterViewModel extends _$CounterViewModel {
  @Publisher(defaultValue: 2)
  abstract int count;

  @Publisher(defaultValue: "Haris")
  abstract String name;

  void increment() => count++;

  @override
  bool get enableLogging => true;
}

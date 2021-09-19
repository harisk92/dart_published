import 'package:published/published.dart';

part 'counter_view_model.published.dart';

class HttpService {}

@published
abstract class CounterViewModel extends _$CounterViewModel {
  @Publisher()
  abstract int count;

  abstract HttpService _httpService;

  @Publisher(defaultValue: "Haris")
  abstract String name;

  void increment() => count++;

  @override
  bool get enableLogging => true;
}

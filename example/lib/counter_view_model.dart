import 'package:published/published.dart';

part 'counter_view_model.published.dart';

@published
abstract class CounterViewModel extends _$CounterViewModel {
  @Publisher()
  abstract int count;

  void increment() => count++;

  @override
  bool get enableLogging => true;

  @override
  void onBind() {
    // TODO: implement onBind
    super.onBind();
  }
}

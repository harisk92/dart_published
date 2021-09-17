import 'package:published/published.dart';

part 'counter_view_model.published.dart';

@PublishedAnnotation()
abstract class CounterViewModel extends _$CounterViewModel {
  @Publisher(defaultValue: 0)
  abstract int count;

  CounterViewModel();

  factory CounterViewModel.make({required int count}) =>
      _CounterViewModel(count: count);

  void increment() => count++;
}

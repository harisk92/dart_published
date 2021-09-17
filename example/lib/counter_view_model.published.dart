// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'counter_view_model.dart';

// **************************************************************************
// PublishedGenerator
// **************************************************************************

abstract class _$CounterViewModel extends ObservableObject {
  abstract final BehaviorSubject<int> $count;
}

class _CounterViewModel extends CounterViewModel {
  final BehaviorSubject<int> $count;

  _CounterViewModel({required int count})
      : this.$count = BehaviorSubject.seeded(count);

  int get count => this.$count.value;

  set count(int value) => this.$count.add(value);

  @override
  void dispose() {
    super.dispose();
    $count.close();
  }
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'counter_view_model.dart';

// **************************************************************************
// PublishedGenerator
// **************************************************************************

extension CounterViewModelExtension on CounterViewModel {
  int get count => this.$count.value;

  set count(int value) => this.$count.add(value);
}

class _CounterViewModel extends CounterViewModel {
  _CounterViewModel() : super();

  @override
  void dispose() {
    super.dispose();
    $count.close();
  }
}

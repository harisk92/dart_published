// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'counter_view_model.dart';

// **************************************************************************
// PublishedGenerator
// **************************************************************************

//ignore_for_file: close_sinks

abstract class _$CounterViewModel extends ObservableObject {
  abstract final BehaviorSubject<int> $count;

  abstract final Stream didChange;

  bool get enableLogging => false;

  void onBind() {}
}

abstract class CounterViewModelBuilder extends CounterViewModel {
  CounterViewModelBuilder();

  factory CounterViewModelBuilder.build({required int count}) =>
      _CounterViewModel(count: count);
}

class _CounterViewModel extends CounterViewModelBuilder {
  final BehaviorSubject<int> $count;

  _CounterViewModel({required int count})
      : this.$count = BehaviorSubject.seeded(count) {
    this.shouldEnableLogger();
    this.onBind();
  }

  int get count => this.$count.value;

  set count(int value) => this.$count.add(value);

  Stream get didChange => MergeStream([$count]);

  void shouldEnableLogger() {
    if (!enableLogging) return;

    didChange.listen(dumpLogOnChange).addTo(disposables);
  }

  void dumpLogOnChange(signal) {
    print("------------------");
    print("DidChange:");
    print("CounterViewModel{");
    print(" count: ${this.count}");
    print("}");
    print("------------------");
  }

  @override
  void dispose() {
    super.dispose();
    $count.close();
  }
}

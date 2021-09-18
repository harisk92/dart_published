// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'counter_view_model.dart';

// **************************************************************************
// PublishedGenerator
// **************************************************************************

//ignore_for_file: close_sinks

abstract class _$CounterViewModel extends ObservableObject {
  abstract final BehaviorSubject<int> $count;
  abstract final BehaviorSubject<String> $name;

  abstract final Stream didChange;

  bool get enableLogging => false;
}

class _CounterViewModel extends CounterViewModel {
  final BehaviorSubject<int> $count;
  final BehaviorSubject<String> $name;

  _CounterViewModel({int? count, String? name})
      : this.$count = BehaviorSubject.seeded(count ?? 2),
        this.$name = BehaviorSubject.seeded(name ?? "Haris") {
    this.shouldEnableLogger();
  }

  int get count => this.$count.value;
  String get name => this.$name.value;

  set count(int value) => this.$count.add(value);
  set name(String value) => this.$name.add(value);

  Stream get didChange => MergeStream([$count, $name]);

  void shouldEnableLogger() {
    if (!enableLogging) return;

    didChange.listen(dumpLogOnChange).addTo(disposables);
  }

  void dumpLogOnChange(signal) {
    print("------------------");
    print("DidChange:");
    print("CounterViewModel{");
    print(" count: ${this.count}");
    print(" name: ${this.name}");
    print("}");
    print("------------------");
  }

  @override
  void dispose() {
    super.dispose();
    $count.close();
    $name.close();
  }
}

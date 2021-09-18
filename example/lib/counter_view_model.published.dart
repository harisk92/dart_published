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

abstract class CounterViewModelBuilder extends CounterViewModel {
  CounterViewModelBuilder();

  factory CounterViewModelBuilder.build({int? count, String? name}) =>
      _CounterViewModel(count: count, name: name);
}

class _CounterViewModel extends CounterViewModelBuilder {
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

abstract class _$NewViewModel extends ObservableObject {
  abstract final BehaviorSubject<T> $age;

  abstract final Stream didChange;

  bool get enableLogging => false;
}

abstract class NewViewModelBuilder extends NewViewModel {
  NewViewModelBuilder();

  factory NewViewModelBuilder.build({required T age}) =>
      _NewViewModel(age: age);
}

class _NewViewModel extends NewViewModelBuilder {
  T age;

  _NewViewModel({required T age}) : this.age = age {
    this.shouldEnableLogger();
  }

  Stream get didChange => MergeStream([]);

  void shouldEnableLogger() {
    if (!enableLogging) return;

    didChange.listen(dumpLogOnChange).addTo(disposables);
  }

  void dumpLogOnChange(signal) {
    print("------------------");
    print("DidChange:");
    print("NewViewModel{");

    print("}");
    print("------------------");
  }

  @override
  void dispose() {
    super.dispose();
    $age.close();
  }
}

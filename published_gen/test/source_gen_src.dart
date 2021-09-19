import 'package:published/published.dart';
import 'package:source_gen_test/annotations.dart';

@ShouldThrow("Can be only used on class")
@published
Object? example;

@ShouldThrow("Can be only used on abstract class")
@published
class Test {}

@ShouldThrow("Default value of count is not of type int")
@published
abstract class Counter {
  @Publisher(defaultValue: "")
  abstract int count;
}

@ShouldGenerate('''
//ignore_for_file: close_sinks
''', contains: true)
abstract class Test2 {}

@ShouldGenerate(
  '''
//ignore_for_file: close_sinks

abstract class _\$CounterViewModel extends ObservableObject {
  abstract final BehaviorSubject<int> \$count;

  abstract final Stream didChange;

  bool get enableLogging => false;
}

abstract class CounterViewModelBuilder extends CounterViewModel {
  CounterViewModelBuilder();

  factory CounterViewModelBuilder.build({required int count}) =>
      _CounterViewModel(count: count);
}

class _CounterViewModel extends CounterViewModelBuilder {
  final BehaviorSubject<int> \$count;

  _CounterViewModel({required int count})
      : this.\$count = BehaviorSubject.seeded(count) {
    this.shouldEnableLogger();
  }

  int get count => this.\$count.value;

  set count(int value) => this.\$count.add(value);

  Stream get didChange => MergeStream([\$count]);

  void shouldEnableLogger() {
    if (!enableLogging) return;

    didChange.listen(dumpLogOnChange).addTo(disposables);
  }

  void dumpLogOnChange(signal) {
    print("------------------");
    print("DidChange:");
    print("CounterViewModel{");
    print(" count: \${this.count}");
    print("}");
    print("------------------");
  }

  @override
  void dispose() {
    super.dispose();
    \$count.close();
  }
}
''',
)
@published
abstract class CounterViewModel {
  @Publisher()
  abstract int count;
}

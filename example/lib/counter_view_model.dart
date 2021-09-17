import 'package:published/published.dart';
import 'package:rxdart/rxdart.dart';

part 'counter_view_model.published.dart';

@PublishedAnnotation()
class CounterViewModel extends ObservableObject {
  final Published<int> $count = Published.seeded(0);

  CounterViewModel();

  factory CounterViewModel.make() = _CounterViewModel;

  void increment() => count++;
}

abstract class _ObservableObject extends ObservableObject {
  abstract final Published<String> $firstName;
}

abstract class SomeViewModel extends _ObservableObject {
  abstract final String firstName;

  SomeViewModel();

  factory SomeViewModel.build({required String firstName}) =>
      SomeViewModelExt(firstName: firstName);

  void start() {}
}

class SomeViewModelExt extends SomeViewModel {
  SomeViewModelExt({required String firstName})
      : $firstName = BehaviorSubject.seeded(firstName);

  @override
  // TODO: implement firstName
  String get firstName => throw UnimplementedError();

  @override
  // TODO: implement $firstName
  final Published<String> $firstName;
}

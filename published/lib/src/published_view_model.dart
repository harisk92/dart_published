import 'package:rxdart/rxdart.dart';

abstract class ObservableObject {
  final CompositeSubscription disposables = CompositeSubscription();

  void dispose() => disposables.dispose();
}

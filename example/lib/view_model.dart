import 'package:rxdart/rxdart.dart';

abstract class ViewModel {
  final CompositeSubscription disposables = CompositeSubscription();

  void dispose() => disposables.dispose();
}

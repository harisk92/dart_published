import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:published/published.dart';
import 'package:rxdart/rxdart.dart';

typedef ViewModelInitCallback<T> = Function(T viewModel);
typedef ViewModelObserverCallback<T> = List<StreamSubscription> Function(
    T viewModel);

T useViewModel<T extends ObservableObject>(
  T viewModel, {
  ViewModelInitCallback<T>? onInit,
  ViewModelObserverCallback<T>? observe,
}) {
  return use(_ViewModelHook<T>(
    viewModel: viewModel,
    onInit: onInit,
    observe: observe,
  ));
}

class _ViewModelHook<T extends ObservableObject> extends Hook<T> {
  final T viewModel;
  final ViewModelInitCallback<T>? onInit;
  final ViewModelObserverCallback<T>? observe;

  _ViewModelHook({
    required this.viewModel,
    this.onInit,
    this.observe,
  }) : super();

  @override
  HookState<T, Hook<T>> createState() => _ViewModelHookState<T>();
}

class _ViewModelHookState<T extends ObservableObject>
    extends HookState<T, _ViewModelHook<T>> {
  final CompositeSubscription subscriptions = CompositeSubscription();

  @override
  void initHook() {
    super.initHook();

    hook.onInit?.call(hook.viewModel);
    subscriptions.addAll(hook.observe?.call(hook.viewModel));

    print("Got ${subscriptions.length} subscriptions");
  }

  @override
  T build(BuildContext context) => hook.viewModel;

  @override
  void dispose() => hook.viewModel.dispose();
}

extension on CompositeSubscription {
  void addAll(List<StreamSubscription>? subscriptions) {
    if (subscriptions == null) return;
    subscriptions.forEach(add);
  }
}

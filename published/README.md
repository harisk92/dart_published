
# Motivation

Published was inspired by Published property wrapper from Swift.

There are approaches like using BloC that depend on streams and they introduce a lot of boilerplate.

Published goal is reduce that boilerplate and introduce simple state management.


# How to use

## Installation

To use [package:published][published] in your package, add these
dependencies to your `pubspec.yaml`.

```yaml
dependencies:
  published:

dev_dependencies:
  build_runner:
  published_gen:
```

## Usage

```dart

import 'package:published/published.dart';

part 'counter_view_model.published.dart';

@published
abstract class CounterViewModel extends _$CounterViewModel {
  @Publisher()
  abstract int count;

  void increment() => count++;

  @override
  bool get enableLogging => true;
}

```

You'll have to make abstract class and annotate it with `@published` and extend it with `_$ClassName`.

Annotate abstract field for which you want to expose stream with `@Publisher()`.

* Note: It's important to use abstract fields and classes so we can replicate Swift structs.

Then run `pub run build_runner build` to generate files into your source directory.

```console
> pub run build_runner build
[INFO] ensureBuildScript: Generating build script completed, took 368ms
[INFO] BuildDefinition: Reading cached asset graph completed, took 54ms
[INFO] BuildDefinition: Checking for updates since last build completed, took 663ms
[INFO] Build: Running build completed, took 10ms
[INFO] Build: Caching finalized dependency graph completed, took 44ms
[INFO] Build: Succeeded after 4687ms with 1 outputs
```

_NOTE_: If you're using Flutter, replace `pub run` with
`flutter packages pub run`.


To use it do following

``` dart
 //Init
 final model = CounterViewModelBuilder.build(count: 0);
 ...

 Widget build(BuildContext context) {
   
   return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            StreamBuilder<int>(
              stream: model.$count,
              builder: (context,snapshot) => Text("${snapshot.data ?? 0}");
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => model.count++,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
 }

```

`$classNameBuilder.build()` needs to be used to create instance of the object. If you don't want to pass default value in `build()` use defaultValue property on `Publisher` like this:

``` dart
@Publisher(defaultValue: "John")
abstract String name;
```

To observe if any property annotated with `Publisher` changed you can use `didChange`:

```dart
model.didChange.listen(() => doSomething())
```

If you want to enableLogging you can override getter `enableLogging`:

```dart

@published
abstract class CounterViewModel extends _$CounterViewModel {
  ...
  @override
  bool get enableLogging => true;
}

```

Finally if you want to do something on object creation you can override `onBind` method and place your logic there:

```dart

@published
abstract class CounterViewModel extends _$CounterViewModel {
  ...
  @override
  @override
  void onBind() {
    super.onBind();
    fetchSomeData();
  }
}

```


[published]: https://pub.dev/packages/published
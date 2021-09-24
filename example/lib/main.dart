import 'package:flutter/material.dart';
import 'package:published/published.dart';

import 'counter_view_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: CounterPage(),
    );
  }
}

class CounterPage extends StatefulWidget {
  @override
  _CounterPageState createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  late final CounterViewModel counterViewModel;

  @override
  void initState() {
    super.initState();
    counterViewModel = CounterViewModelBuilder.build(count: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Test"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            PublishedBuilder<int>(
              counterViewModel.$count,
              onResult: (context, value) => Text(
                '$value',
                style: Theme.of(context).textTheme.headline4,
              ),
              onError: (context, error) => Text(error.toString()),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: counterViewModel.increment,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

typedef ResultWidgetBuilder<T> = Widget Function(BuildContext context, T data);
typedef LoadingWidgetBuilder = WidgetBuilder;
typedef ErrorWidgetBuilder = Widget Function(
    BuildContext context, Object error);

class PublishedBuilder<T> extends StreamBuilder<T> {
  PublishedBuilder(
    BehaviorSubject<T> publisher, {
    required ResultWidgetBuilder<T> onResult,
    LoadingWidgetBuilder? onLoading,
    ErrorWidgetBuilder? onError,
  }) : super(
          stream: publisher,
          initialData: publisher.value,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print("Error");
              return onError?.call(context, snapshot.error!) ?? Container();
            }

            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return onLoading?.call(context) ?? Container();
              case ConnectionState.active:
                if (snapshot.hasData) return onResult(context, snapshot.data!);
                break;
              default:
                return Container();
            }
            return Container();
          },
        );
}

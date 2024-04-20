// import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:state_management_bloc/my_bloc.dart';
// import 'package:flutter_application_1/my_bloc.dart';

void main() {
  runApp(const MyApp());
  // DevicePreview(
  //   enabled: true,
  //   builder: (context) => const MyApp(),
  // ),
  // );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // ignore: deprecated_member_use
      useInheritedMediaQuery: true,
      // locale: DevicePreview.locale(context),
      // builder: DevicePreview.appBuilder,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  MyBloc myBloc = MyBloc();

  // ignore: unused_element
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            StreamBuilder<int>(
                stream: myBloc.stateStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    _counter = snapshot.data ?? 0;
                    return Text(
                      '${snapshot.data}',
                      style: Theme.of(context).textTheme.headlineMedium,
                    );
                  } else {
                    return const Text("0");
                  }
                }),
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        width: 200,
        height: 200,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            FloatingActionButton(
              onPressed: () {
                // _counter++;
                myBloc.eventStreamSink.add(IncrementEvents(value: _counter));
              },
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            ),
            FloatingActionButton(
              onPressed: () {
                // _counter++;
                myBloc.eventStreamSink.add(DecrementEvents(value: _counter));
              },
              tooltip: 'Increment',
              child: const Icon(Icons.remove),
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Counter()),
      ],
      child: const MyApp(),
    ),
  );
}


class Counter with ChangeNotifier, DiagnosticableTreeMixin {
  int _count = 0;
  List<bool> listCheck = [false, false, false, false];

  int get count => _count;

  set count(int value) {
    _count = value;
  }

  void changeIndexIsTrue(int index) {
    listCheck[index] = true;
    notifyListeners();
  }

  Color changeColorIndex(int index) {
    listCheck[index] = false;
    return Colors.black;
  }
  void increment() {
      _count++;
      notifyListeners();
    }

  /// Makes `Counter` readable inside the devtools by listing all of its properties
  /*@override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IntProperty('count', count));
  }*/
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Example'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('You have pushed the button this many times:'),
            Count(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        key: const Key('increment_floatingActionButton'),

        /// Calls `context.read` instead of `context.watch` so that it does not rebuild
        /// when [Counter] changes.
        onPressed: () => context.read<Counter>().increment(),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class Count extends StatelessWidget {
  //const Count({Key key}) : super(key: key);

  List<String> listNameGroupMoney = ['Expenditure', 'Expenditure Fixed', 'Turnover', 'Turnover Fixed'];
  List<Color> listColorElevatedButton = [Colors.deepPurple[100], Color(0xff13d38e), Colors.indigo[400], Colors.blueGrey[600]];

  Widget MoneyGroup(BuildContext context) {
      return Container(
        padding: EdgeInsets.only(top: 10),
        //height: 50,
        height: 70,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: listNameGroupMoney.length,
            itemBuilder: (context, index) {
              return
                Container(
                  child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          context.read<Counter>().changeIndexIsTrue(index);
                          print(Provider.of<Counter>(context, listen: false).listCheck[index]);
                        },
                        child: Text(listNameGroupMoney[index]),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                    (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.pressed)) {
                                    return Colors.black45;
                                  }
                                  else {
                                    //return Colors.lightBlueAccent;
                                    return listColorElevatedButton[index];
                                  }
                                }
                            )
                        ),
                      ),
                      Container(
                        height: 4.5,
                        width: 50,
                        color: ((context.watch<Counter>().listCheck[index] == true) ? context.watch<Counter>().changeColorIndex(index) : Colors.white),
                      )
                      /*Consumer<Counter>(
                        builder: (context, counter, child) {
                          return Container(
                            height: 4.5,
                            width: 50,
                            color: ((counter.listCheck[index] == true) ? counter.changeColorIndex(index) : Colors.white),
                          );
                        },
                      ),*/
                    ],
                  ),
                  padding: EdgeInsets.only(left: 10),
                );
            }
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(

            /// Calls `context.watch` to make [Count] rebuild when [Counter] changes.
            //'${context.watch<Counter>().count}',
              '${Provider.of<Counter>(context, listen: true).count}',
              key: const Key('counterState'),
              style: Theme.of(context).textTheme.headline4),
          MoneyGroup(context),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';

import 'requests/zones.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cloudflare App',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(title: 'Cloudflare App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      cloudflareZones.getZones();
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        drawer: Drawer(
          child: Container(
            decoration: const BoxDecoration(color: Color.fromARGB(255, 229, 136, 59)),
            // decoration: const BoxDecoration(color: Color(0xFF0098c2)),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        title: const Text(
                          'Zones',
                          style: TextStyle(fontSize: 18.0, color: Colors.white),
                        ),
                        leading: const Icon(
                          Icons.dns,
                          size: 20.0,
                          color: Colors.white,
                        ),
                        onTap: () {
                          /* Navigator.pop(context);
                      Navigator.of(context).push(new MaterialPageRoute(
                          builder: (context) => dealerBuilder()));*/
                        },
                      ),
                      ListTile(
                        title: const Text(
                          'Tokens',
                          style: TextStyle(fontSize: 18.0, color: Colors.white),
                        ),
                        leading: const Icon(
                          Icons.token,
                          size: 20.0,
                          color: Colors.white,
                        ),
                        onTap: () {
                          /*Navigator.pop(context);
                      Navigator.of(context).push(new MaterialPageRoute(
                          builder: (context) => shufflerBuilder()));*/
                        },
                      ),
                      ListTile(
                        title: const Text(
                          'DNS',
                          style: TextStyle(fontSize: 18.0, color: Colors.white),
                        ),
                        leading: const Icon(
                          Icons.info_outline,
                          size: 20.0,
                          color: Colors.white,
                        ),
                        onTap: () {
                          /* Navigator.pop(context);
                      Navigator.of(context).push(new MaterialPageRoute(
                          builder: (context) => mistakePage()));*/
                        },
                      ),
                    ],
                  ),
                ),
                Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: Column(
                      children: const <Widget>[
                        Divider(),
                        ListTile(
                            leading: Icon(Icons.settings),
                            title: Text('Accounts')),
                        ListTile(
                            leading: Icon(Icons.help),
                            title: Text('Info'))
                      ],
                    )),
              ],
            ),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'You have pushed the button this many times:',
              ),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headline4,
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _incrementCounter,
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

// import './pages/pages_exports.dart';
import './pages/why_porxyprov.dart';
import './pages/proxyprov_update.dart';
import './pages/proxyprov_create_update.dart';
import './pages/proxyprov_proxyprov.dart';
import './pages/chgnotiprov_chgnotiproxyprov.dart';
import './pages/chgnotiprov_proxyprov.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter PoxyProvider Demo',
      debugShowCheckedModeBanner: false,
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

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      //   title: Text(widget.title),
      // ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: ListView(
            shrinkWrap: true, // true : 화면 중간에 배치
            children: [
              ElevatedButton(
                child: const Text(
                  'Why\nProxyProvider',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const WhyProxyProv(),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 30.0,
              ),
              ElevatedButton(
                child: const Text(
                  'ProxyProvider\nupdate',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProxyProvUpdate(),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 20.0,
              ),
              ElevatedButton(
                child: const Text(
                  'ProxyProvider\ncreate/update',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProxyProvCreateUpdate(),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 30.0,
              ),
              ElevatedButton(
                child: const Text(
                  'ProxyProvider\nProxyProvider',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProxyProvProxyProv(),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 30.0,
              ),
              ElevatedButton(
                child: const Text(
                  'ChangeNotifierProvider\nChangeNotifierProxyProvider',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ChgnotiprovChgnotiproxyprov(),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 30.0,
              ),
              ElevatedButton(
                child: const Text(
                  'ChangeNotifierProvider\nProxyProvider',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ChgnotiprovProxyprov(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

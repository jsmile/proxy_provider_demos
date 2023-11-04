import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Translations {
  final int _value;

  Translations(this._value);

  String get title => 'You clicked $_value times!';
}

class ProxyProvUpdate extends StatefulWidget {
  const ProxyProvUpdate({super.key});

  @override
  State<ProxyProvUpdate> createState() => _ProxyProvUpdateState();
}

class _ProxyProvUpdateState extends State<ProxyProvUpdate> {
  int counter = 0;

  void increment() {
    setState(() {
      counter++;
      print('*** counter: $counter');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Why ProxyProvider Update'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const ShowTransrations(),
            const SizedBox(height: 20),
            IncreasedButton(increment: increment),
          ],
        ),
      ),
    );
  }
}

class ShowTransrations extends StatelessWidget {
  const ShowTransrations({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'You clicked 0 times!',
      style: TextStyle(fontSize: 28.0),
    );
  }
}

class IncreasedButton extends StatelessWidget {
  final VoidCallback increment;

  const IncreasedButton({
    Key? key,
    required this.increment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: increment,
      child: const Text(
        'INCLEASE',
        style: TextStyle(fontSize: 20.0),
      ),
    );
  }
}

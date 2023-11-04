import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// ProxyProvider update
///
/// 어떤 위젯이 다른 class 에 의존하고 있을 때,
///
/// 1. ProxyProvider 위젯 사용
/// 해당 class 를 사용할 수 있게
/// 상위에서 ProxyProvider0<T> 위젯으로 생성 및 update 하고,
/// child 에서 Provider.of<T>() 로 접근하여 사용할 수 있게 함.
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
        // ProxyProvider0<T> 을 사용하여
        // 매번 대상 data 가 변할 때마다 새로운 instance 를 생성해서
        // 그것으로 update 하게 함.
        // 자동으로 dispose 시킴.
        child: ProxyProvider0<Translations>(
          update: (_, __) => Translations(counter),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const ShowTransrations(),
              const SizedBox(height: 20),
              IncreasedButton(increment: increment),
            ],
          ),
        ),
      ),
    );
  }
}

class ShowTransrations extends StatelessWidget {
  const ShowTransrations({super.key});

  @override
  Widget build(BuildContext context) {
    // Provider.of<T>(context) 를 사용하여 대상 instance 에 접근
    final title = Provider.of<Translations>(context).title;
    return Text(
      title,
      style: const TextStyle(fontSize: 28.0),
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

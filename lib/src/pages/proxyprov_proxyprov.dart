import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proxy_provider_demos/src/pages/chgnotiprov_chgnotiproxyprov.dart';

/// Multiprovider
/// ProxyProvider0<T> & ProxyProvider<T, R>
///
/// int 를 반환하는 provider 과
/// 그 변화하는 int 를 받아서 새로운 object 를 생성하며 직접 수정하는 방식
/// async 한 작업없이 객체들 간의 상호작업으로만 이루어 진다면 ProxyProvider 사용.
class Translations {
  final int _value;

  Translations(this._value);

  String get title => 'You clicked $_value times!';
}

class ProxyProvProxyProv extends StatefulWidget {
  const ProxyProvProxyProv({super.key});

  @override
  State<ProxyProvProxyProv> createState() => _ProxyProvProxyProvState();
}

class _ProxyProvProxyProvState extends State<ProxyProvProxyProv> {
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
        title: const Text('Multi ProxyProvider'),
      ),
      body: Center(
        child: MultiProvider(
          providers: [
            ProxyProvider0<int>(
              update: (_, __) => counter, // __ : 사용하지 않는 이전 값
            ),
            // int 형의 counter 에 의존하는 Translations 생성
            // async 한 작업없이 객체들 간의 상호작업으로만 이루어 진다면 ProxyProvider 사용.
            ProxyProvider<int, Translations>(
              // __ : 사용하지 않는 이전 값
              update: (_, value, __) => Translations(value),
            ),
          ],
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
    final String title = context.watch<Translations>().title;
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

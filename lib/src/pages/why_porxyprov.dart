import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Why ProxyProvider
///
/// 어떤 위젯이 다른 class 에 의존하고 있을 때,
///
/// 1. Provider 위젯 사용
/// 해당 class 를 사용할 수 있게 상위에서 Provider 위젯의 create 로 생성하고,
/// child 에서 Provider.of<T>() 로 접근하여 사용할 수 있게 함.
/// but
/// create 는 초기 1회만 실행되므로 그 후 변경되는 상태를 반영하지 못함.

// ShowTranslation 에서 의존하는 class ( data class)
class Translations {
  final int _value;

  Translations(this._value);

  String get title => 'You clicked $_value times!';
}

class WhyProxyProv extends StatefulWidget {
  const WhyProxyProv({super.key});

  @override
  State<WhyProxyProv> createState() => _WhyProxyProvState();
}

class _WhyProxyProvState extends State<WhyProxyProv> {
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
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Why ProxyProvider'),
      ),
      body: Center(
        // 관련 데이터( translations )를 하위에서 사용하게 하기 위하여
        // 해당 유형을 생성할 수 있는 Provider 로 감싸줌
        child: Provider<Translations>(
          create: (_) => Translations(counter), // 사용할 의존데이터 생성
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

// Translations 의 instance 를 구해서 접근할 수 있으면
// property 를 title 을 통해 접근할 수 있고,
// 그러면 해당 State( data )의 변화를 표시할 수 있음.
class ShowTransrations extends StatelessWidget {
  const ShowTransrations({super.key});

  @override
  Widget build(BuildContext context) {
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

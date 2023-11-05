import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// ChangeNotifierProvider & ProxyProvider
///
/// 관찰 대상인 ChangeNotifier 를 만들고
/// 자신은 그것에 의존하여 관찰대상이 변화 시마다 자신도 변화하는 class 만들기
///

// 변화 관찰의 대상이 되는 ChangeNotifier 클래스
class Counter with ChangeNotifier {
  int counter = 0;

  void increment() {
    counter++;
    notifyListeners();
  }
}

class Translations {
  final int _value;

  Translations(this._value);

  String get title => 'You clicked $_value times!';
}

class ChgNotiProvProxyProv extends StatefulWidget {
  const ChgNotiProvProxyProv({super.key});

  @override
  State<ChgNotiProvProxyProv> createState() => _ChgNotiProvProxyProvState();
}

class _ChgNotiProvProxyProvState extends State<ChgNotiProvProxyProv> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ChangeNotifierProvider & ProxyProvider'),
      ),
      body: Center(
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider<Counter>(create: (_) => Counter()),
            ProxyProvider<Counter, Translations>(
              update: (_, Counter counter, Translations? translations) {
                // 생성자를 직접 호출하여 result 를 사용하지 않음
                return Translations(counter.counter); // 매번 새로운 Translations 생성
                // result 를 사용하기 위해서는 아래와 같이 작성
                // 그러나 현재 update() 를 만들지 않았음.
                // return translations!.update( counter.counter);
              },
            ),
          ],
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ShowTransrations(),
              SizedBox(height: 20),
              IncreasedButton(),
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

// Counter 에 increment() 가 있으므로
// 해당 코드들은 삭제하고,
// context.read<T>() 를 사용함.
class IncreasedButton extends StatelessWidget {
  // final VoidCallback increment;

  const IncreasedButton({
    Key? key,
    // required this.increment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context.read<Counter>().increment();
      },
      child: const Text(
        'INCLEASE',
        style: TextStyle(fontSize: 20.0),
      ),
    );
  }
}

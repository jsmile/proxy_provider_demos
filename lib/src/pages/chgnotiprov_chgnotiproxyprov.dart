import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// ChangeNotifierProvider<T> & ChangeNotifierProxyProvider<T, R>
///
/// ChangeNotifier 와 그것을 사용( 의존 )하는 또 다른 ChangeNotifier 를 만들고
/// 그 두개를 연결하기 위해서 ChangeNotifierProxyProvider 사용.

// 변화 관찰의 대상이 되는 ChangeNotifier 클래스
class Counter with ChangeNotifier {
  int counter = 0;

  void increment() {
    counter++;
    notifyListeners();
  }
}

// 다른 Notifier 의 변화에 의존하는 Notifier 클래스
class Translations with ChangeNotifier {
  late int value;

  // 타 notifier 인 Counter.counter 에 의존하여 변경됨.
  void increment(Counter counter) {
    value = counter.counter;
    notifyListeners();
  }

  String get title => 'You clicked $value times!';
}

class ChgnotiprovChgnotiproxyprov extends StatefulWidget {
  const ChgnotiprovChgnotiproxyprov({super.key});

  @override
  State<ChgnotiprovChgnotiproxyprov> createState() =>
      _ChgnotiprovChgnotiproxyprovState();
}

class _ChgnotiprovChgnotiproxyprovState
    extends State<ChgnotiprovChgnotiproxyprov> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('ChangeNotifierProvider & ChangeNotifierProxyProvider'),
      ),
      body: Center(
        child: MultiProvider(
          providers: [
            // 단순히 Counter 만 생성하면 되므로 ChangeNotifierProvider 사용.
            ChangeNotifierProvider<Counter>(
              create: (_) => Counter(),
            ),
            // Counter.counter 의 변화에 의존하는 Translations 생성하도록
            // ChangeNotifierProxyProvider 사용.
            ChangeNotifierProxyProvider<Counter, Translations>(
              create: (_) => Translations(),
              update: (
                BuildContext context,
                Counter counter, // 의존 대상
                Translations? translations, // 사용 대상
              ) {
                translations!.increment(counter); // 일단 생성된 Result 재사용
                return translations;
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

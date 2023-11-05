import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// ProxyProvider create & update
///

// ShowTranslation 에서 의존하는 class ( data class )로서
// update 시 값이 변경될 있도록 property 에서 final 을 제거함.
class Translations {
  late int _value;

  void update(int newValue) {
    _value = newValue;
    print('*** _value: $_value');
  }

  String get title => 'You clicked $_value times!';
}

class ProxyProvCreateUpdate extends StatefulWidget {
  const ProxyProvCreateUpdate({super.key});

  @override
  State<ProxyProvCreateUpdate> createState() => _ProxyProvCreateUpdateState();
}

class _ProxyProvCreateUpdateState extends State<ProxyProvCreateUpdate> {
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
        title: const Text('ProxyProvider Create & Update'),
      ),
      body: Center(
        child: ProxyProvider0<Translations>(
          create: (_) => Translations(), // 사용할 의존데이터 생성
          // 생성한 것을 건네주고 update 시 호출
          update: (_, Translations? translations) {
            translations!.update(counter);
            return translations;
          },
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
    final title = context.watch<Translations>().title;
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

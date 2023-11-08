import 'package:flutter/material.dart';
import 'package:signal/signal_widget.dart';

class StateSample extends StatelessWidget {
  const StateSample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text('State Sample'),
      ),
      body: const Center(
        child: Teste(),
      ),
    );
  }
}

class Teste extends SignalWidget {
  const Teste({super.key});

  @override
  Widget build(BuildContext context) {
    final (count, setCount) = (context as SignalElement).createSignal(0);
    context.createEffect(() {
      print('one time only effect');
    });
    context.createEffect(() {
      print('count changed: ${count()}');
    });
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            setCount(count() - 1);
          },
          child: const Text('-1'),
        ),
        Text('${count()}'),
        ElevatedButton(
          onPressed: () {
            setCount(count() + 1);
          },
          child: const Text('+1'),
        ),
      ],
    );
  }
}

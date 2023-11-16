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
    final (count2, setCount2) = (context as SignalElement).createSignal(10);
    context.createEffect(() {
      print('one time only effect');
    });
    context.createEffect(() {
      print('count changed: ${count()}');
    });
    context.createEffect(() {
      print('count or count2 changed: count:${count()}/count2:${count2()}');
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
        ElevatedButton(
          onPressed: () {
            setCount2(count2() - 1);
          },
          child: const Text('-1'),
        ),
        Text('${count2()}'),
        ElevatedButton(
          onPressed: () {
            setCount2(count2() + 1);
          },
          child: const Text('+1'),
        ),
      ],
    );
  }
}

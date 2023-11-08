import 'package:flutter/material.dart';
import 'package:signal/signal_widget.dart';

typedef SignalId = int;
typedef EffectId = int;

class Signal<T> {
  final SignalId id;
  T value;

  Signal({required this.id, required this.value});
}

typedef SignalGetter = T Function<T>();
typedef SignalSetter = Function<T>(T);

class SignalBuilder extends SignalWidget {
  final Widget Function(BuildContext context) builder;
  const SignalBuilder({super.key, required this.builder});

  @override
  Widget build(BuildContext context) => builder(context);
}

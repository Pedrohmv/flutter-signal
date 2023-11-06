class Signal {
  final int id;

  Signal({required this.id});
}

typedef SignalGetter = T Function<T>();
typedef SignalSetter = Function<T>(T);

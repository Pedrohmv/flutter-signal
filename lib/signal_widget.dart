import 'package:flutter/material.dart';

abstract class SignalWidget extends StatelessWidget {
  const SignalWidget({super.key});

  @override
  SignalElement createElement() => SignalElement(this);
}

class SignalElement extends StatelessElement {
  SignalElement(super.widget);

  final List<ValueNotifier> _signalValues = [];
  final Map<String, VoidCallback> _runningEffects = {};
  bool _mustRebuild = true;
  bool _didRebuild = false;
  Widget? _buildCache;
  int _index = 0;

  (T Function(), void Function(T)) createSignal<T>(T initialData) {
    final valueNotifier =
        _didRebuild ? _signalValues[_index] : ValueNotifier(initialData)
          ..addListener(() {
            _mustRebuild = true;
            _didRebuild = true;
            _index = 0;
            markNeedsBuild();
          });
    if (!_didRebuild) {
      _signalValues.add(valueNotifier);
    }
    final id = _didRebuild ? _index++ : _signalValues.length - 1;
    getter() {
      //_runningEffects[id] =
      return _signalValues[id].value as T;
    }

    void setter(T newData) {
      _signalValues[id].value = newData;
    }

    return (getter, setter);
  }

  createEffect<T>(Function() effect) {}

  @override
  Widget build() {
    if (!_mustRebuild) {
      return _buildCache!;
    }
    _buildCache = super.build();
    _mustRebuild = false;
    return _buildCache!;
  }
}

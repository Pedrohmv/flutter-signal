import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:signal/signal.dart';

abstract class SignalWidget extends StatelessWidget {
  const SignalWidget({super.key});

  @override
  SignalElement createElement() => SignalElement(this);
}

class SignalElement extends StatelessElement {
  SignalElement(super.widget);

  final List<Signal> _signalValues = [];
  final Map<SignalId, HashSet<int>> _signalSubscribers = {};
  SignalId _runningEffect = -1;
  final List<VoidCallback> _effects = [];
  bool _mustRebuild = true;
  bool _didRebuild = false;
  Widget? _buildCache;
  int _index = 0;

  (T Function(), void Function(T)) createSignal<T>(T initialData) {
    final id = _didRebuild ? _index++ : _signalValues.length;
    if (!_didRebuild) {
      _signalValues.add(Signal(id: id, value: initialData));
    }
    getter() {
      if (_signalSubscribers[id] == null) {
        _signalSubscribers[id] = HashSet<int>();
      }
      if (_runningEffect != -1) {
        final subs = _signalSubscribers[id];
        subs?.add(_runningEffect);
      }
      return _signalValues[id].value as T;
    }

    void setter(T newData) {
      if (newData == _signalValues[id].value) return;
      _signalValues[id].value = newData;
      final subscribers = _signalSubscribers[id];
      if (subscribers != null) {
        for (final sub in subscribers) {
          _runEffect(sub);
        }
      }
      _forceRebuild();
    }

    return (getter, setter);
  }

  void _runEffect(int effectId) {
    final prevEffect = _runningEffect;
    _runningEffect = effectId;
    _effects[effectId].call();
    _runningEffect = prevEffect;
  }

  createEffect<T>(VoidCallback effect) {
    if (_didRebuild) return;
    _effects.add(effect);
    final effectId = _effects.length - 1;
    _runEffect(effectId);
  }

  void _forceRebuild() {
    _mustRebuild = true;
    _didRebuild = true;
    _index = 0;
    markNeedsBuild();
  }

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

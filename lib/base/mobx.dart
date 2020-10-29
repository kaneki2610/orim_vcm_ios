import 'package:mobx/mobx.dart' as Mobx;

abstract class BaseMobx<T> {
  Mobx.ReactionDisposer _autorun;
  Mobx.ReactionDisposer _reaction;
  Mobx.ReactionDisposer _when;

  autorun(Function(Mobx.Reaction) callback) {
    _autorun = Mobx.autorun((_) => callback);
  }

  reaction(T Function(Mobx.Reaction) fn, Function(T) effect) {
    _reaction = Mobx.reaction(fn, effect);
  }

  when(bool Function(Mobx.Reaction) predicate, void Function() effect) {
    _when = Mobx.when(predicate, effect);
  }

  asyncWhen(bool Function(Mobx.Reaction) predicate) {
    Mobx.asyncWhen(predicate);
  }

  dispose() {
    if (_autorun != null) {
      _autorun();
    }
    if (_reaction != null) {
      _reaction();
    }
    if (_when != null) {
      _when();
    }
  }
}

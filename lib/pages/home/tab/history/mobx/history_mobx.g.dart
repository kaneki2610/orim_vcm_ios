// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_mobx.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HistoryMobx on HistoryMobxStore, Store {
  final _$isShowCalendarAtom = Atom(name: 'HistoryMobxStore.isShowCalendar');

  @override
  bool get isShowCalendar {
    _$isShowCalendarAtom.context.enforceReadPolicy(_$isShowCalendarAtom);
    _$isShowCalendarAtom.reportObserved();
    return super.isShowCalendar;
  }

  @override
  set isShowCalendar(bool value) {
    _$isShowCalendarAtom.context.conditionallyRunInAction(() {
      super.isShowCalendar = value;
      _$isShowCalendarAtom.reportChanged();
    }, _$isShowCalendarAtom, name: '${_$isShowCalendarAtom.name}_set');
  }

  final _$HistoryMobxStoreActionController =
      ActionController(name: 'HistoryMobxStore');

  @override
  void toggleCalendar() {
    final _$actionInfo = _$HistoryMobxStoreActionController.startAction();
    try {
      return super.toggleCalendar();
    } finally {
      _$HistoryMobxStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void reset() {
    final _$actionInfo = _$HistoryMobxStoreActionController.startAction();
    try {
      return super.reset();
    } finally {
      _$HistoryMobxStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string = 'isShowCalendar: ${isShowCalendar.toString()}';
    return '{$string}';
  }
}

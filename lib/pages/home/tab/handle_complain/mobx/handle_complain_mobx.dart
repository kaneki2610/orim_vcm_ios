import 'package:mobx/mobx.dart';
import 'package:orim/base/mobx.dart';

class ComplainMobx = ComplainMobxStore with _$ComplainMobx;

abstract class ComplainMobxStore extends BaseMobx with Store {
  @observable
  bool isShowCalendar = false;

  int indexCurrentTab = 0;
  bool isChangeSearch = false;
  bool isChangeCalendar = false;

  @observable
  bool isShowSearch = false;

  @action
  void toggleCalendar() {
    this.isChangeCalendar = true;
    isShowCalendar = !isShowCalendar;
  }

  @action
  void toggleSearch() {
    this.isChangeSearch = true;
    isShowSearch = !isShowSearch;
  }

  @action
  void reset() {
    this.isChangeCalendar = false;
    this.isChangeSearch = false;
    isShowCalendar = false;
    isShowSearch = false;
  }


}

mixin _$ComplainMobx on ComplainMobxStore, Store {
  final _$isShowCalendarAtom = Atom(name: 'ComplainMobxStore.isShowCalendar');
  final _$isShowSearchAtom = Atom(name: 'ComplainMobxStore.isShowSearch');


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

  @override
  bool get isShowSearch {
    _$isShowSearchAtom.context.enforceReadPolicy(_$isShowSearchAtom);
    _$isShowSearchAtom.reportObserved();
    return super.isShowSearch;
  }

  @override
  set isShowSearch(bool value) {
    _$isShowSearchAtom.context.conditionallyRunInAction(() {
      super.isShowSearch = value;
      _$isShowSearchAtom.reportChanged();
    }, _$isShowSearchAtom, name: '${_$isShowSearchAtom.name}_set');
  }


  final _$HistoryMobxStoreActionController =
  ActionController(name: 'ComplainMobxStore');

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
  void toggleSearch() {
    final _$actionInfo = _$HistoryMobxStoreActionController.startAction();
    try {
      return super.toggleSearch();
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

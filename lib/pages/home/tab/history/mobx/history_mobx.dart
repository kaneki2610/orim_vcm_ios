import 'package:mobx/mobx.dart';
import 'package:orim/base/mobx.dart';

part 'history_mobx.g.dart';

class HistoryMobx = HistoryMobxStore with _$HistoryMobx;

abstract class HistoryMobxStore extends BaseMobx with Store {
  @observable
  bool isShowCalendar = false;

  @action
  void toggleCalendar() {
    isShowCalendar = !isShowCalendar;
  }

  @action
  void reset() {
    isShowCalendar = false;
  }

}
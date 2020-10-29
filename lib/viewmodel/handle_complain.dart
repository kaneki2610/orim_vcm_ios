import 'package:orim/base/viewmodel.dart';
import 'package:orim/pages/home/tab/handle_complain/handle_complain_bloc.dart';

class HandleComplainViewModel extends BaseViewModel<HandleComplainType> {
  void changeHandleComplainTab(HandleComplainType type) {
    this.data = type;
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orim/base/bloc.dart';
import 'package:orim/base/subject.dart';
import 'package:orim/model/issue/issue.dart';
import 'package:orim/navigator_service.dart';
import 'package:orim/pages/issue_detail/issue_detail_page.dart';
import 'package:orim/pages/issue_detail/issue_detail_view.dart';
import 'package:orim/pages/issue_map/issue_map_page.dart';
import 'package:orim/viewmodel/issue.dart';
import 'package:orim/viewmodel/send_feedback.dart';
import 'package:provider/provider.dart';

class IssueDetailBloc extends BaseBloc {
  IssueDetailBloc(
      {BuildContext context,
      IssueDetailView issueDetailView,
      IssueDetailArguments arguments})
      : model = arguments.model,
        _issueDetailView = issueDetailView,
        super(context: context) {
    _ratingSubject.value = model.rating;
  }

  IssueViewModel _issueViewModel;
  SendFeedbackViewModel _sendFeedbackViewModel;
  final IssueModel model;
  final IssueDetailView _issueDetailView;

  BehaviorSubject<double> _ratingSubject = BehaviorSubject(value: 3.0);

  Stream<double> get ratingObserver => _ratingSubject.stream;

  TextEditingController contentController = TextEditingController();
  FocusNode contentFocusNode = FocusNode();

  void showModalMap() {
    IssueMapPageArguments arguments = IssueMapPageArguments(
        location: model.location, position: model.position);
    print('position: ${model.position.longitude} - ${model.position.latitude}');
    NavigatorService.showModalIssueMap(context, arguments: arguments);
  }

  @override
  void updateDependencies(BuildContext context) {
    _issueViewModel = Provider.of<IssueViewModel>(context);
    _sendFeedbackViewModel = Provider.of<SendFeedbackViewModel>(context);
  }

  Future<bool> issueIsOwn() async {
    List<String> ids = await _issueViewModel.getIssueIds();
    int index = ids.indexOf(model.id);
    return index > -1;
  }

  @override
  void dispose() {
    _ratingSubject.close();
    contentController.dispose();
    contentFocusNode.dispose();
  }

  void changeRating(double rating) {
    _ratingSubject.value = rating;
  }

  Future<void> onPressSendFeedback() async {
    double rating = _ratingSubject.value;
    String comment = contentController?.text?.trim() ?? "";
    _issueDetailView.showLoading();
    try {
      bool res = await _sendFeedbackViewModel.sendFeedback(
          id: model.id, mark: rating, comment: comment);
      _issueDetailView.hideLoading().then((_) {
        if (res) {
          _issueDetailView.back();
        } else {
          _issueDetailView.sendFeedbackFailed('');
        }
      });
    } catch (err) {
      _issueDetailView.hideLoading().then((_) {
        if (err is String || err is int) {
          _issueDetailView.sendFeedbackFailed('$err');
        } else {
          print(err);
        }
      });
    }
  }
}

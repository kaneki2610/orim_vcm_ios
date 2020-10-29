import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:orim/components/raised_buttom_custom.dart';
import 'package:orim/config/colors_resource.dart';
import 'package:orim/config/imgs_resource.dart';
import 'package:orim/config/strings_resource.dart';
import 'package:orim/navigator_service.dart';
import 'package:orim/pages/intro/intro_bloc.dart';
import 'package:orim/utils/widget/widget.dart';
import 'package:page_indicator/page_indicator.dart';

class IntroPage extends StatefulWidget {
  static const routeName = 'Intro';

  final skip;

  IntroPage({this.skip = false});

  @override
  State<StatefulWidget> createState() {
    return _IntroState();
  }
}

class _IntroState extends State<IntroPage> {
  IntroBloc _introBloc;

  @override
  void initState() {
    super.initState();
    _introBloc = IntroBloc(context: context, stateCheck: widget.skip);
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _introBloc.startFirst();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _introBloc.updateDependencies(context);
  }

  @override
  void dispose() {
    _introBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double sizeIconButton = 20.0;
    return Scaffold(
      backgroundColor: ColorsResource.backgroundColorIntro,
      body: SafeArea(
          child: Stack(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 20,
              ),
              ImageView.asset(ImageResource.logo_intro_p1, scale: 1.5),
              Expanded(
                child: PageIndicatorContainer(
                  child: PageView(
                    onPageChanged: this.onPageChanged(),
                    children: <Widget>[
                      _step1(context),
                      _step2(context),
                      _step3(context),
                      _step4(context),
                    ],
                    controller: _introBloc.pageController,
                  ),
                  length: 4,
                  align: IndicatorAlign.bottom,
                  indicatorSpace: 20.0,
                  indicatorColor: Color(0xFF1E4A9A),
                  indicatorSelectorColor: Colors.white,
                  shape: IndicatorShape.circle(size: 12),
                ),
              ),
              Container(
                height: 70,
                padding: EdgeInsets.only(bottom: 10, top: 10),
                alignment: Alignment.center,
                color: ColorsResource.backgroundColorIntro,
//              color: ColorsResource.backgroundColorIntro,
                child: Text(
                  StringResource.getText(context, 'dev_unit') + ': VNPT',
                  style: TextStyle(
                      color: ColorsResource.textColorTutorial, fontSize: 16),
                ),
              )
            ],
          ),
          Positioned(
            left: 10.0,
            bottom: 20.0,
            child: Container(
              width: 50.0,
              height: 40.0,
              child: FlatButton(
                color: Color.fromRGBO(255, 255, 255, 0.637),
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(20.0),
                ),
                child: Container(
                  child: Icon(
                    Icons.arrow_back,
                    size: sizeIconButton,
                    color: Colors.white,
                  ),
                ),
                onPressed: clickedBackPage,
              ),
            ),
          ),
          Positioned(
            right: 10.0,
            bottom: 20.0,
            height: 40.0,
            width: 70.0,
            child: Container(
              child: FlatButton(
                color: Colors.black45,
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(20.0),
                ),
                child: Icon(Icons.arrow_forward,
                    size: sizeIconButton, color: Colors.white),
                onPressed: clickedNextPage,
              ),
            ),
          ),
        ],
      )),
    );
  }

  Widget _step1(BuildContext context) {
    return _StepContainer(
      child: Container(
        padding: EdgeInsets.only(top: 20.0),
        child: ImageView.asset(ImageResource.icon_intro_p1, scale: 1.2),
      ),
    );
  }

  Widget _step2(BuildContext context) {
    const paddingStep2 = 30.0;
    return _StepContainer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: paddingStep2, bottom: paddingStep2),
            child: Text(
              StringResource.getText(context, 'interact_sys').toUpperCase(),
              style: TextStyle(
                  color: ColorsResource.textColorTutorial,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: paddingStep2),
            child: Text(
              StringResource.getText(context, 'subTitle_intro_2'),
              style: TextStyle(
                  color: ColorsResource.textColorTutorial,
                  fontSize: 17,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Text(StringResource.getText(context, 'text_intro'),
              style: styleTextContent, textAlign: TextAlign.justify),
        ],
      ),
    );
  }

  Widget _step3(BuildContext context) {
    return _StepContainer(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 20.0),
            child: Text(
              StringResource.getText(context, 'guide').toUpperCase(),
              style: TextStyle(
                  color: ColorsResource.textColorTutorial,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 30.0),
            child: ImageView.asset(ImageResource.icon_intro_p3),
          ),
        ],
      ),
    );
  }

  Widget _step4(BuildContext context) {
    const paddingStep2 = 30.0;
    return _StepContainer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: paddingStep2, bottom: paddingStep2),
            child: Text(
              StringResource.getText(context, 'temp_policy').toUpperCase(),
              style: TextStyle(
                  color: ColorsResource.textColorTutorial,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Text(StringResource.getText(context, 'policy'),
              style: styleTextContent, textAlign: TextAlign.justify),
          SizedBox(height: paddingStep2),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              StreamBuilder(
                stream: _introBloc.isCheckedObservable,
                builder: (context, AsyncSnapshot<bool> snapshot) {
                  return Checkbox(
                    value: snapshot.hasData ? snapshot.data : false,
                    onChanged: _introBloc.onChangeStateCheck,
                  );
                },
              ),
              Text(StringResource.getText(context, 'agreement'),
                  style: styleTextContent)
            ],
          ),
          StreamBuilder(
            stream: _introBloc.isCheckedObservable,
            builder: (context, AsyncSnapshot<bool> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data) {
                  return RaisedButtonCustom(
                    onPressed: _onPressNext,
                    backgroundColor: ColorsResource.buttonColorTutorial,
                    text:
                        StringResource.getText(context, 'begin').toUpperCase(),
                  );
                }
              }
              return Container();
            },
          ),
        ],
      ),
    );
  }

  void _onPressNext() {
    _introBloc.next(widget.skip);
  }

  clickedNextPage() {
    setState(() {
      _introBloc.clickedNextPage();
    });
  }

  clickedBackPage() {
    setState(() {
      _introBloc.clickedBackPage();
    });
  }

  ValueChanged<int> onPageChanged() => (int pos) {
        _introBloc.changIndexPage(pos);
      };
}

class _StepContainer extends StatelessWidget {
  final Widget child;

  _StepContainer({this.child});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        padding: EdgeInsets.only(left: 15, right: 15), child: this.child);
  }
}

class _RowTextContentStep3 extends StatelessWidget {
  final String text;
  final padding = 20.0;

  _RowTextContentStep3({this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: padding, top: padding),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  color: ColorsResource.textColorTutorial, width: 1.0))),
      alignment: Alignment.centerLeft,
      child: Text(this.text,
          style: styleTextContent,
          softWrap: true,
          overflow: TextOverflow.ellipsis),
    );
  }
}

class IntroPageArguments {
  bool skip;

  IntroPageArguments({this.skip = false});
}

const styleTextContent = TextStyle(
  color: ColorsResource.textColorTutorial,
  fontSize: 16,
);

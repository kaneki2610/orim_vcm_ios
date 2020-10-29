import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:orim/components/loading.dart';
import 'package:orim/config/imgs_resource.dart';
import 'package:orim/pages/splash/splash_bloc.dart';
import 'package:orim/utils/widget/widget.dart';

class SplashPage extends StatefulWidget {
  static const routeName = 'SplashPage';

  const SplashPage();

  @override
  State<StatefulWidget> createState() {
    return _SplashState();
  }
}

class _SplashState extends State<SplashPage> {
  SplashBloc _splashBloc;

  @override
  void initState() {
    super.initState();
    _splashBloc = SplashBloc(context: context);
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _splashBloc?.next();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _splashBloc.updateDependencies(context);
  }

  @override
  void dispose() {
    _splashBloc?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF0063AD),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ImageView.asset(ImageResource.logo),
          ],
        ),
      ),
    );
  }
}

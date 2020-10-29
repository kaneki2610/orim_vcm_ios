import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:orim/config/colors_resource.dart';
import 'package:orim/main_bloc.dart';
import 'package:orim/main_view.dart';
import 'package:orim/navigator_service.dart';
import 'package:orim/pages/splash/splash_page.dart';
import 'package:orim/utils/http_bad_sercurity.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:orim/services/notification.dart';
import 'provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = AppHttpBadSercuriy();
  runApp(
    EasyLocalization(
      useOnlyLangCode: true,
      supportedLocales: [Locale('vi')],
      path: 'assets/langs',
      child: MyApp(),
    ),
  );
}

class _MyAppState extends State<MyApp> implements MainView {
  final providerApp = ProviderApp();
  MainBloc bloc;

  @override
  void initState() {
    super.initState();
    initBloc();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      onPostFrame();
    });
  }

  void initBloc() {
    bloc = MainBloc(context: context, view: this);
  }

  void onPostFrame() {
    this.bloc.notificationConfig();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providerApp.generateProvider(),
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: RefreshConfiguration(
          footerTriggerDistance: 15,
          dragSpeedRatio: 0.91,
          headerBuilder: () => MaterialClassicHeader(),
          footerBuilder: () => ClassicFooter(),
          enableLoadingWhenNoData: false,
          shouldFooterFollowWhenNotFull: (state) {
            // If you want load more with noMoreData state ,may be you should return false
            return false;
          },
          autoLoad: true,
          child: MaterialApp(
            title: "Flutter Demo",
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              EasyLocalization.of(context).delegate,
            ],
//        supportedLocales: [Locale('en'), Locale('vi')],
            supportedLocales: EasyLocalization.of(context).supportedLocales,
            locale: EasyLocalization.of(context).locale,
            theme: ThemeData(
              primarySwatch: ColorsResource.primaryColor,
              primaryColor: ColorsResource.primaryColor,
              accentColor: ColorsResource.accentColor,
              bottomAppBarColor: Colors.transparent,
              unselectedWidgetColor: Colors.grey,
            ),
            initialRoute: SplashPage.routeName,
            onGenerateRoute: NavigatorService.generateRoute,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() {
    return _MyAppState();
  }
}

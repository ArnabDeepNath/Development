import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zerodha/src/bloc/authentication/authentication_bloc.dart';
import 'package:zerodha/src/repository/helpeaze_preference_provider.dart';
import 'package:zerodha/src/repository/repository.dart';
import 'package:zerodha/src/ui/splash.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appRepository = Repository();
  final sharePreferenceProvider = await PreferenceProvider.getInstance();

  runApp(
    BlocProvider<AuthenticationBloc>(
      create: (context) {
        return AuthenticationBloc(appRepository, sharePreferenceProvider)
          ..add(AppStarted());
      },
      child: MyApp(
          appRepository: appRepository,
          sharePreferenceProvider: sharePreferenceProvider),
    ),
  );
}

class MyApp extends StatelessWidget {
  final Repository appRepository;
  final PreferenceProvider sharePreferenceProvider;

  const MyApp(
      {required this.appRepository, required this.sharePreferenceProvider});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Color(0xFFebecee),
      statusBarIconBrightness: Brightness.dark
    ));
    /*SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Color(0xFFebecee)
    ));*/
    return MaterialApp(
      title: 'HelpEaze',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Lato',
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is AuthenticationAuthenticated) {
            return SplashPage(
              appRepository: appRepository,
              sharePreferenceProvider: sharePreferenceProvider,
              isLoggedin: true,
            );
          } else if (state is AuthenticationUnAuthenticated) {
            return SplashPage(
                appRepository: appRepository,
                sharePreferenceProvider: sharePreferenceProvider,
                isLoggedin: false);
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

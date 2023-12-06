import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:zerodha/src/repository/helpeaze_preference_provider.dart';
import 'package:zerodha/src/repository/repository.dart';
import 'package:zerodha/src/utils/network_info.dart';

part 'authentication_event.dart';

part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final Repository appRepository;
  final PreferenceProvider preferenceProvider;
  final NetworkInfo networkInfo = NetworkInfoImpl();

  AuthenticationBloc(this.appRepository, this.preferenceProvider)
      : super(AuthenticationInitial());

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      bool isLogin = preferenceProvider.getBoolPreference('isLogin');
      if (isLogin) {
        yield AuthenticationAuthenticated();
      } else {
        yield AuthenticationUnAuthenticated();
      }
    }
  }
}

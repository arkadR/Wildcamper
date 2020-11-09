import 'package:WildcamperMobile/App/Firebase/FirebaseBloc.dart';
import 'package:WildcamperMobile/App/Authentication/LoginScreen.dart';
import 'package:WildcamperMobile/App/main_screen.dart';
import 'package:WildcamperMobile/Data/DataAccess/ImagesDataAccess.dart';
import 'package:WildcamperMobile/Data/DataAccess/PlacesDataAccess.dart';
import 'package:WildcamperMobile/Data/Repositories/PlacesRepository.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'App/Firebase/FirebaseState.dart';
import 'Domain/repositories/places_repository.dart';

final getIt = GetIt.instance;

void setupGetIt() {
  var dio = Dio();
  (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
      (client) {
    client.badCertificateCallback = (cert, host, port) => true;
  };
  getIt.registerSingleton<Dio>(dio);
  getIt.registerSingleton<PlacesDataAccess>(PlacesDataAccess());
  getIt.registerSingleton<ImagesDataAccess>(ImagesDataAccess());
  getIt.registerSingleton<IPlacesRepository>(PlacesRepository());
  getIt.registerSingletonAsync<SharedPreferences>(
      () async => await SharedPreferences.getInstance());
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupGetIt();
  runApp(Root());
}

class Root extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<FirebaseBloc>(
        create: (context) => FirebaseBloc(),
        child: BlocBuilder<FirebaseBloc, FirebaseState>(
            builder: (context, state) => MaterialApp(
                title: 'Wildcamper',
                theme: ThemeData(
                  primarySwatch: Colors.green,
                  visualDensity: VisualDensity.adaptivePlatformDensity,
                ),
                home: _getWidgetByAuthState(state.status))));
  }

  Widget _getWidgetByAuthState(FirebaseStatus status) {
    if (status == FirebaseStatus.unauthenticated) return LoginScreen();
    if (status == FirebaseStatus.authenticated)
      return MainScreen(title: 'Wildcamper');
    if (status == FirebaseStatus.error)
      return ErrorScreen(errorText: 'Firebase error');

    if (status == FirebaseStatus.uninitialized) return LoadingScreen();
    throw Exception("Invalid FirebaseAuth state");
  }
}

class ErrorScreen extends StatefulWidget {
  final String errorText;

  ErrorScreen({Key key, this.errorText}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Column(children: [Text(widget.errorText)]));
  }
}

class LoadingScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    return Text('Loading...');
  }
}

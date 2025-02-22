import 'package:WildcamperMobile/App/Firebase/FirebaseBloc.dart';
import 'package:WildcamperMobile/App/Authentication/LoginScreen.dart';
import 'package:WildcamperMobile/App/main_screen.dart';
import 'package:WildcamperMobile/Data/DataAccess/ImagesDataAccess.dart';
import 'package:WildcamperMobile/Data/DataAccess/PlaceTypeDataAccess.dart';
import 'package:WildcamperMobile/Data/DataAccess/PlacesDataAccess.dart';
import 'package:WildcamperMobile/Data/DataAccess/RatingsDataAccess.dart';
import 'package:WildcamperMobile/Data/DataAccess/UsersDataAccess.dart';
import 'package:WildcamperMobile/Data/Repositories/PlaceTypeRepository.dart';
import 'package:WildcamperMobile/Data/Repositories/PlacesRepository.dart';
import 'package:WildcamperMobile/Data/Repositories/RatingsRepository.dart';
import 'package:WildcamperMobile/Data/Repositories/UsersRepository.dart';
import 'package:WildcamperMobile/Domain/repositories/IPlaceTypeRepository.dart';
import 'package:WildcamperMobile/Domain/repositories/IRatingsRepository.dart';
import 'package:WildcamperMobile/Domain/repositories/IUsersRepository.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'App/Firebase/FirebaseState.dart';
import 'Domain/repositories/places_repository.dart';
import 'Infrastructure/ApiClient.dart';
import 'Infrastructure/UserProvider.dart';

final getIt = GetIt.instance;

void setupGetIt() {
  var dio = Dio();
  (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
      (client) {
    client.badCertificateCallback = (cert, host, port) => true;
  };
  getIt.registerSingleton<Dio>(dio);
  getIt.registerSingleton<ApiClient>(ApiClient());
  getIt.registerFactory<UserProvider>(() => UserProvider());
  bindDataAccess();
  bindRepositories();
}

void bindDataAccess() {
  getIt.registerSingleton<UsersDataAccess>(UsersDataAccess());
  getIt.registerSingleton<PlaceTypeDataAccess>(PlaceTypeDataAccess());
  getIt.registerSingleton<PlacesDataAccess>(PlacesDataAccess());
  getIt.registerSingleton<ImagesDataAccess>(ImagesDataAccess());
  getIt.registerSingleton<RatingsDataAccess>(RatingsDataAccess());
}

void bindRepositories() {
  getIt.registerSingleton<IPlaceTypeRepository>(PlaceTypeRepository());
  getIt.registerSingleton<IPlacesRepository>(PlacesRepository());
  getIt.registerSingleton<IRatingsRepository>(RatingsRepository());
  getIt.registerSingleton<IUsersRepository>(UsersRepository());
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
    debugPaintSizeEnabled = false;
    return BlocProvider<FirebaseBloc>(
        create: (context) => FirebaseBloc(),
        child: BlocBuilder<FirebaseBloc, FirebaseState>(
            builder: (context, state) => MaterialApp(
                debugShowCheckedModeBanner: false,
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

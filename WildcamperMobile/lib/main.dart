import 'dart:io';

import 'package:WildcamperMobile/App/Authentication/login_screen.dart';
import 'package:WildcamperMobile/App/main_screen.dart';
import 'package:WildcamperMobile/Data/DataAccess/ImagesDataAccess.dart';
import 'package:WildcamperMobile/Data/DataAccess/PlacesDataAccess.dart';
import 'package:WildcamperMobile/Data/Repositories/PlacesRepository.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

final FirebaseAuth _auth = FirebaseAuth.instance;

class Root extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          var errorText = snapshot.error?.toString();
          var isLoaded = snapshot.connectionState == ConnectionState.done;
          return MaterialApp(
              title: 'Flutter Demo',
              theme: ThemeData(
                primarySwatch: Colors.blue,
                visualDensity: VisualDensity.adaptivePlatformDensity,
              ),
              home: App(errorText: errorText, isLoaded: isLoaded));
        });
  }
}

class App extends StatefulWidget {
  final String errorText;
  bool get isLoggedIn {
    //TODO
    return true;
    // return _user Credential != null;
  }

  final bool isLoaded;
  UserCredential _userCredential;

  App({Key key, this.isLoaded, this.errorText}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    Widget content;
    if (widget.isLoaded == false)
      content = LoadingScreen();
    else if (widget.errorText != null)
      content = ErrorScreen(errorText: widget.errorText);
    else if (widget.isLoggedIn == false)
      content = LoginScreen(
        onLoggedIn: (credential) {
          setState(() {
            widget._userCredential = credential;
          });
        },
      );
    else
      content = MainScreen(title: 'Wildcamper');
    return content;
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

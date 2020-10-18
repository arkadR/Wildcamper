import 'package:WildcamperMobile/login_screen.dart';
import 'package:WildcamperMobile/main_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(Root());
}

class Root extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          var errorText = snapshot.error?.toString();
          var isLoaded = snapshot.connectionState == ConnectionState.done;
          var isLoggedIn = false;
          return MaterialApp(
              title: 'Flutter Demo',
              theme: ThemeData(
                primarySwatch: Colors.blue,
                visualDensity: VisualDensity.adaptivePlatformDensity,
              ),
              home: App(
                  errorText: errorText,
                  isLoaded: isLoaded,
                  isLoggedIn: isLoggedIn));
        });
  }
}

class App extends StatefulWidget {
  final String errorText;
  final bool isLoggedIn;
  final bool isLoaded;

  App({Key key, this.isLoaded, this.isLoggedIn, this.errorText})
      : super(key: key);

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
      content = LoginScreen();
    else
      content = MainScreen();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Log in'),
        ),
        body: content);
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

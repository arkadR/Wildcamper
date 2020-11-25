import 'package:WildcamperMobile/App/MyPlaces/MyPlacesScreen.dart';
import 'package:WildcamperMobile/App/Search/SearchScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Firebase/FirebaseBloc.dart';
import 'Firebase/FirebaseEvent.dart';
import 'Firebase/FirebaseState.dart';
import 'Map/MapScreen.dart';
import 'package:WildcamperMobile/Infrastructure/Extensions/UserExtensions.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 1;
  final List<Widget> _navBarItems = [
    MyPlacesScreen(),
    MapSample(),
    SearchScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: MainDrawer(),
      body: Center(child: _navBarItems[_selectedIndex]),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.view_compact), label: 'My Places'),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Map'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
        ],
        currentIndex: _selectedIndex,
        onTap: (int index) => setState(() => _selectedIndex = index),
      ),
    );
  }
}

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FirebaseBloc, FirebaseState>(
        builder: (context, state) => Drawer(
                child: ListView(padding: EdgeInsets.zero, children: <Widget>[
              DrawerHeader(
                child: Column(
                  children: [
                    Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          state.user.getDisplayName(),
                        )),
                    Expanded(
                        child: Align(
                            alignment: Alignment.bottomRight,
                            child: SafeCircleAvatar(
                                imageUrl: state.user.photoURL)))
                  ],
                ),
                decoration: BoxDecoration(
                    color: Colors.blue,
                    image: DecorationImage(
                        image: AssetImage("assets/background.jpg"),
                        fit: BoxFit.cover)),
              ),
              ListTile(
                title: Text('About app'),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                title: Text('Log out'),
                onTap: () =>
                    BlocProvider.of<FirebaseBloc>(context).add(LoggedOut()),
              ),
            ])));
  }
}

class SafeCircleAvatar extends StatelessWidget {
  final String imageUrl;

  SafeCircleAvatar({this.imageUrl});

  @override
  Widget build(BuildContext context) => CircleAvatar(
        backgroundImage: imageUrl == null ? null : NetworkImage(imageUrl),
        child: imageUrl == null ? Icon(Icons.account_circle, size: 40) : null,
      );
}

import 'package:flutter/material.dart';
import 'package:side_menu_scaffold/side_menu_scaffold.dart';
import 'package:side_menu_scaffold_example/drawer_menu.dart';
import 'package:provider/provider.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Side Menu',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  SideMenuController menuController;

  @override
  void initState() {
    super.initState();

    menuController = new SideMenuController(
      vsync: this,
    )..addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    menuController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (context) => menuController,
      child: SideMenuScaffold(
        menu: DrawerMenu(),
        title: new Text(
          "Side Menu",
          style: TextStyle(fontSize: 20, color: Colors.black87),
        ),
        actions: <Widget>[
          Icon(Icons.settings),
        ],
        body: Container(
          margin: EdgeInsets.only(top: 88),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(125)),
              shape: BoxShape.rectangle,
              color: Colors.lightBlue,
              boxShadow: [
                BoxShadow(
                  blurRadius: 100,
                  color: Colors.black45,
                )
              ]),
          child: new Center(
            child: Text(
              "Teja Droid",
              style: TextStyle(fontSize: 44, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}

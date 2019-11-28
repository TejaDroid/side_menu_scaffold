import 'package:side_menu_scaffold/side_menu_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DrawerMenu extends StatelessWidget {
  final String profileUrl =
      "https://apitest.lokaly.in/uploads/store/114/logo/image-1751950486-497.jpg";

  final List<MenuItem> menu = [
    MenuItem(Icons.home, 'Home'),
    MenuItem(Icons.favorite, 'Favorite'),
    MenuItem(Icons.calendar_today, 'Subscription'),
    MenuItem(Icons.info_outline, 'Help'),
    MenuItem(Icons.lock_outline, 'Logout'),
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onPanUpdate: (details) {
          //on swiping left
          if (details.delta.dx < -6) {
            Provider.of<SideMenuController>(context, listen: true).toggle();
          }
        },
        child: Container(
          padding: EdgeInsets.only(
              top: 62, left: 32, bottom: 8, right: MediaQuery.of(context).size.width / 2.9),
          color: Colors.cyan,
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: Container(
                      width: 44.0,
                      height: 44.0,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(image: NetworkImage(profileUrl)),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 10,
                              color: Colors.black45,
                            )
                          ]),
                    ),
                  ),
                  Text(
                    'Droid',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  )
                ],
              ),
              Spacer(),
              Column(
                children: menu.map((item) {
                  return ListTile(
                    leading: Icon(
                      item.icon,
                      color: Colors.white,
                      size: 20,
                    ),
                    title: Text(
                      item.title,
                      style: TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  );
                }).toList(),
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

class MenuItem {
  String title;
  IconData icon;

  MenuItem(this.icon, this.title);
}

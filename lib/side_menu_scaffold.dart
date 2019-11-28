import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SideMenuScaffold extends StatefulWidget {
  final Widget menu;
  final Widget title;
  final List<Widget> actions;
  final Widget body;

  SideMenuScaffold({this.menu, this.title, this.actions, this.body});

  @override
  _SideMenuScaffoldState createState() => new _SideMenuScaffoldState();
}

class _SideMenuScaffoldState extends State<SideMenuScaffold> with TickerProviderStateMixin {
  Curve scaleDownCurve = new Interval(0.0, 0.3, curve: Curves.easeOut);
  Curve scaleUpCurve = new Interval(0.0, 1.0, curve: Curves.easeOut);
  Curve slideOutCurve = new Interval(0.0, 1.0, curve: Curves.easeOut);
  Curve slideInCurve = new Interval(0.0, 1.0, curve: Curves.easeOut);

  GlobalKey _scaffoldKey = new GlobalKey();

  createContentDisplay() {
    return zoomAndSlideContent(new Container(
      child: new Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        appBar: new AppBar(
            backgroundColor: Colors.white,
            centerTitle: true,
            elevation: 0.0,
            leading: new IconButton(
                icon: Icon(
                  Icons.menu,
                  color: Colors.black,
                ),
                onPressed: () {
                  Provider.of<SideMenuController>(context, listen: true).toggle();
                }),
            title: widget.title,
            iconTheme: new IconThemeData(color: Colors.black87),
            actions: widget.actions),
        body: widget.body,
      ),
    ));
  }

  zoomAndSlideContent(Widget content) {
    var slidePercent;

    switch (Provider.of<SideMenuController>(context, listen: true).state) {
      case DrawerState.closed:
        slidePercent = 0.0;
        break;
      case DrawerState.open:
        slidePercent = 1.0;
        break;
      case DrawerState.opening:
        slidePercent = slideOutCurve
            .transform(Provider.of<SideMenuController>(context, listen: true).percentOpen);
        break;
      case DrawerState.closing:
        slidePercent = slideInCurve
            .transform(Provider.of<SideMenuController>(context, listen: true).percentOpen);
        break;
    }

    final slideAmount = 275.0 * slidePercent;
    final contentScale = 1.0;

    return new Transform(
      transform: new Matrix4.translationValues(slideAmount, 0.0, 0.0)
        ..scale(contentScale, contentScale),
      alignment: Alignment.centerLeft,
      child: new Container(
          decoration: new BoxDecoration(
            boxShadow: [
              new BoxShadow(
                color: Colors.black12,
                offset: const Offset(0.0, 5.0),
                blurRadius: 15.0,
                spreadRadius: 10.0,
              ),
            ],
          ),
          child: content),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          child: Scaffold(
            body: widget.menu,
          ),
        ),
        createContentDisplay()
      ],
    );
  }
}

class SideMenuScaffoldMenuController extends StatefulWidget {
  final SideMenuScaffoldBuilder builder;

  SideMenuScaffoldMenuController({
    this.builder,
  });

  @override
  SideMenuScaffoldMenuControllerState createState() {
    return new SideMenuScaffoldMenuControllerState();
  }
}

class SideMenuScaffoldMenuControllerState extends State<SideMenuScaffoldMenuController> {
  @override
  Widget build(BuildContext context) {
    return widget.builder(context, Provider.of<SideMenuController>(context, listen: true));
  }
}

typedef Widget SideMenuScaffoldBuilder(
    BuildContext context, SideMenuController menuController);

class SideMenuController extends ChangeNotifier {
  final TickerProvider vsync;
  final AnimationController _animationController;
  DrawerState state = DrawerState.closed;

  SideMenuController({
    this.vsync,
  }) : _animationController = new AnimationController(vsync: vsync) {
    _animationController
      ..duration = const Duration(milliseconds: 295)
      ..addListener(() {
        notifyListeners();
      })
      ..addStatusListener((AnimationStatus status) {
        switch (status) {
          case AnimationStatus.forward:
            state = DrawerState.opening;
            break;
          case AnimationStatus.reverse:
            state = DrawerState.closing;
            break;
          case AnimationStatus.completed:
            state = DrawerState.open;
            break;
          case AnimationStatus.dismissed:
            state = DrawerState.closed;
            break;
        }
        notifyListeners();
      });
  }

  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  get percentOpen {
    return _animationController.value;
  }

  open() {
    _animationController.forward();
  }

  close() {
    _animationController.reverse();
  }

  toggle() {
    if (state == DrawerState.open) {
      close();
    } else if (state == DrawerState.closed) {
      open();
    }
  }
}

enum DrawerState {
  closed,
  opening,
  open,
  closing,
}

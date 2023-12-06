import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons_null_safety/flutter_icons_null_safety.dart';
import 'package:zerodha/src/repository/helpeaze_preference_provider.dart';
import 'package:zerodha/src/repository/repository.dart';
import 'package:zerodha/src/ui/portfolio_tab_page.dart';
import 'package:zerodha/src/utils/zerodha_app_icons.dart';

class DashboardScreen extends StatefulWidget {
  final Repository appRepository;
  final PreferenceProvider sharePreferenceProvider;

  const DashboardScreen(
      {required this.appRepository, required this.sharePreferenceProvider});

  @override
  DashboardScreenState createState() => DashboardScreenState();
}

class DashboardScreenState extends State<DashboardScreen> {
  late BuildContext mContext;
  int a = 0;
  int _selectedIndex = 2;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late List<Widget> _widgetOptions;

  @override
  void initState() {
    _widgetOptions = <Widget>[
      Container(),
      Container(),
      PortfolioPageTab(
          appRepository: widget.appRepository,
          sharePreferenceProvider: widget.sharePreferenceProvider),
      Container(),
      Container()
    ];
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          return true;
        },
        child: Scaffold(
          //backgroundColor: const Color(0xFFcccccc),
          key: _scaffoldKey,
          bottomNavigationBar: BottomNavigationBar(
            unselectedItemColor: Colors.black,
            selectedFontSize: 12,
            unselectedFontSize: 12,
            elevation: 15.0,
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.bookmark_border),
                label: 'Watchlist',
              ),
              BottomNavigationBarItem(
                icon: Icon(Feather.book),
                label: 'Orders',
              ),
              BottomNavigationBarItem(
                icon: Icon(ZerodhaApp.portfolio, size: 30.0),
                label: 'Portfolio',
              ),
              BottomNavigationBarItem(
                icon: Icon(ZerodhaApp.tools, size: 30.0),
                label: 'Tools',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                label: 'OP0000',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.blue,
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
          body: _widgetOptions.elementAt(_selectedIndex),
        ));
  }
}

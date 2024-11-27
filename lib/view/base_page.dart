import 'package:flutter/material.dart';
import 'package:flutter_lapon/view/history_transaction/history_transaction_page.dart';
import 'package:flutter_lapon/view/marketplace/marketplace_page.dart';
import 'package:flutter_lapon/view/profile/profile_page.dart';

import '../config/app_color.dart';
import '../config/pref.dart';
import 'auth/login_page.dart';
import 'home/home_page.dart';

class BasePage extends StatefulWidget {
  const BasePage({super.key});

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  int _selectedIndex = 0;
  // final Session _session = Session();
  Map<int, GlobalKey<NavigatorState>> navigatorKeys = {
    0: GlobalKey<NavigatorState>(),
    1: GlobalKey<NavigatorState>(),
    2: GlobalKey<NavigatorState>(),
    3: GlobalKey<NavigatorState>(),
    4: GlobalKey<NavigatorState>(),
  };

  static final List<Widget> _widgetOptions = <Widget>[
    const HomePage(),
    const HistoryTransactionPage(),
    const MarketplacePage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Session().getUserToken(),
      builder: (_, snapshot) {
        String? token = snapshot.data;

        if (token == null || token == "") {
          return const LoginPage();
        } else {
          return Scaffold(
            body: Center(
              child: _widgetOptions.elementAt(_selectedIndex),
            ),
            bottomNavigationBar: Theme(
              data: ThemeData(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
              ),
              child: BottomNavigationBar(
                selectedLabelStyle: fontTextStyle.copyWith(
                    color: AppColor.colorPrimaryGreen, fontWeight: FontWeight.w600),
                unselectedLabelStyle: fontTextStyle.copyWith(
                    color: const Color(0xFF878E97), fontWeight: FontWeight.w600),
                selectedItemColor: AppColor.colorPrimaryGreen,
                unselectedItemColor: const Color(0xFF878E97),
                type: BottomNavigationBarType.fixed,
                items: [
                  BottomNavigationBarItem(
                    icon: _selectedIndex == 0
                        ? Image.asset(
                      "assets/ic_home_active.png",
                      width: 20,
                    )
                        : Image.asset(
                      "assets/ic_home.png",
                      width: 20,
                    ),
                    label: "",
                  ),
                  BottomNavigationBarItem(
                    icon: _selectedIndex == 1
                        ? Image.asset(
                      "assets/ic_history_active.png",
                      width: 20,
                    )
                        : Image.asset(
                      "assets/ic_history.png",
                      width: 20,
                    ),
                    label: "",
                  ),
                  BottomNavigationBarItem(
                    icon: _selectedIndex == 2
                        ? Image.asset(
                      "assets/ic_marketplace_active.png",
                      width: 20,
                    )
                        : Image.asset(
                      "assets/ic_marketplace.png",
                      width: 20,
                    ),
                    label: "",
                  ),
                  BottomNavigationBarItem(
                    icon: _selectedIndex == 3
                        ? Image.asset(
                      "assets/ic_profile_active.png",
                      width: 20,
                    )
                        : Image.asset(
                      "assets/ic_profile.png",
                      width: 20,
                    ),
                    label: "",
                  ),
                ],
                onTap: _onItemTapped,
                currentIndex: _selectedIndex,
              ),
            ),
          );
        }
      },
    );

  }

  buildNavigator() {
    return Navigator(
      key: navigatorKeys[_selectedIndex],
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
            builder: (_) => _widgetOptions.elementAt(_selectedIndex));
      },
    );
  }

  void _onItemTapped(int index) {
    // if (index != 2) {
    //   if (index == 0) {
    //     setState(() {
    //       _selectedIndex = index;
    //     });
    //   }
    //   _session.getUserToken().then((value) {
    //     value == null
    //         ? Navigator.push(
    //         context, MaterialPageRoute(builder: (_) => const LoginPage()))
    //         : setState(() {
    //       _selectedIndex = index;
    //       debugPrint(value);
    //     });
    //   });
    // }
    // if (index == 2) {
    //   _session.getUserToken().then((value) {
    //     value == null
    //         ? Navigator.push(
    //             context, MaterialPageRoute(builder: (_) => const LoginPage()))
    //         : setState(() {
    //             _selectedIndex = index;
    //             debugPrint(value);
    //           });
    //   });
    // } else {
    //   setState(() {
    //     _selectedIndex = index;
    //   });
    // }

    setState(() {
      _selectedIndex = index;
    });
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hotelino/core/constants/constants.dart';
import 'package:hotelino/features/booking/booking_page.dart';
import 'package:hotelino/features/favorite/presentation/favorite_page.dart';
import 'package:hotelino/features/home/presentation/home_page.dart';
import 'package:hotelino/routes/test.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class MainBottomNav extends StatefulWidget {
  const MainBottomNav({super.key});

  @override
  State<MainBottomNav> createState() => _MainBottomNavState();
}

class _MainBottomNavState extends State<MainBottomNav> {
  late PersistentTabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  List<Widget> buildScreens() {
    return [HomePage(), FavoritePage(), BookingPage(), profile()];
  }

  List<PersistentBottomNavBarItem> navBarItems() {
    return [
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          'assets/image/nav_home.svg',
          width: 20,
          height: 20,
          colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
        ),
        activeColorPrimary: AppColors.primary,
        inactiveIcon: SvgPicture.asset(
          'assets/image/nav_home.svg',
          width: 20,
          height: 20,
          colorFilter: ColorFilter.mode(Colors.grey, BlendMode.srcIn),
        ),
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          'assets/image/nav_favorite.svg',
          width: 20,
          height: 20,
          colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
        ),
        activeColorPrimary: AppColors.primary,
        inactiveIcon: SvgPicture.asset(
          'assets/image/nav_favorite.svg',
          width: 20,
          height: 20,
          colorFilter: ColorFilter.mode(Colors.grey, BlendMode.srcIn),
        ),
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          'assets/image/nav_booking.svg',
          width: 20,
          height: 20,
          colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
        ),
        activeColorPrimary: AppColors.primary,
        inactiveIcon: SvgPicture.asset(
          'assets/image/nav_booking.svg',
          width: 20,
          height: 20,
          colorFilter: ColorFilter.mode(Colors.grey, BlendMode.srcIn),
        ),
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          'assets/image/nav_profile.svg',
          width: 20,
          height: 20,
          colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
        ),
        activeColorPrimary: AppColors.primary,
        inactiveIcon: SvgPicture.asset(
          'assets/image/nav_profile.svg',
          width: 20,
          height: 20,
          colorFilter: ColorFilter.mode(Colors.grey, BlendMode.srcIn),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      handleAndroidBackButtonPress: false,
      onItemSelected: (value) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      onWillPop: (context) async {
        if (_controller.index != 0) {
          _controller.jumpToTab(0);
          return false;
        }

        await SystemNavigator.pop();
        return false;
      },
      controller: _controller,
      screens: buildScreens(),
      items: navBarItems(),
      backgroundColor: Theme.of(context).colorScheme.surface,
      navBarStyle: NavBarStyle.style7,
      hideNavigationBarWhenKeyboardAppears: true,
      stateManagement: true,
      confineToSafeArea: true,
      animationSettings: NavBarAnimationSettings(
        navBarItemAnimation: ItemAnimationSettings(
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
      ),
    );
  }
}

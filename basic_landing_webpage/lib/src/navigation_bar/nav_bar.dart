import 'package:basic_landing_webpage/src/my_web_page.dart';
import 'package:basic_landing_webpage/src/navigation_bar/nav_bar_button.dart';
import 'package:basic_landing_webpage/src/widgets/responsive_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NavBar extends ResponsiveWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  Widget buildDesktop(BuildContext context) {
    return const DesktopNavBar();
  }

  @override
  Widget buildMobile(BuildContext context) {
    return const MobileNavBar();
  }
}

class DesktopNavBar extends HookConsumerWidget {
  const DesktopNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isScrolled = ref.watch(scrolledProvider);
    final navBarColor = isScrolled ? Colors.blue : Colors.white;

    return Container(
      color: navBarColor,
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Row(
          children: <Widget>[
            Image.asset(
              "assets/images/logo.png",
              height: 40.0,
            ),
            SizedBox(width: 10.0),
            Text(
              "Company Name",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Colors.black87,
                fontSize: 32,
              ),
            ),
            Expanded(child: Container()),
            NavBarButton(
              onTap: () => ref.read(currentPageProvider.state).state = homeKey,
              text: "Home",
            ),
            NavBarButton(
              onTap: () =>
                  ref.read(currentPageProvider.state).state = featureKey,
              text: "Features",
            ),
            NavBarButton(
              onTap: () =>
                  ref.read(currentPageProvider.state).state = screenshotKey,
              text: "Screenshots",
            ),
            NavBarButton(
              onTap: () =>
                  ref.read(currentPageProvider.state).state = contactKey,
              text: "Contact",
            ),
          ],
        ),
      ),
    );
  }
}

class MobileNavBar extends HookConsumerWidget {
  const MobileNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final containerHeight = useState<double>(0.0);
    final isScrolled = ref.watch(scrolledProvider);

    final navBarColor = isScrolled ? Colors.blue : Colors.white;
    return Stack(
      children: [
        AnimatedContainer(
          margin: EdgeInsets.only(top: 70.0),
          duration: Duration(milliseconds: 350),
          curve: Curves.ease,
          height: containerHeight.value,
          child: SingleChildScrollView(
            child: Column(
              children: [
                NavBarButton(
                  text: "Home",
                  onTap: () {
                    ref.read(currentPageProvider.state).state = homeKey;
                    containerHeight.value = 0;
                  },
                ),
                NavBarButton(
                  text: "Features",
                  onTap: () {
                    ref.read(currentPageProvider.state).state = featureKey;
                    containerHeight.value = 0;
                  },
                ),
                NavBarButton(
                  text: "Screenshots",
                  onTap: () {
                    ref.read(currentPageProvider.state).state = screenshotKey;
                    containerHeight.value = 0;
                  },
                ),
                NavBarButton(
                  text: "Contact",
                  onTap: () {
                    ref.read(currentPageProvider.state).state = contactKey;
                    containerHeight.value = 0;
                  },
                ),
              ],
            ),
          ),
        ),
        Container(
          color: navBarColor,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: <Widget>[
                Image.asset(
                  "assets/images/logo.png",
                  height: 30.0,
                ),
                SizedBox(width: 10.0),
                Text(
                  "Company Name",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                      fontSize: 32),
                ),
                Expanded(
                  child: Container(),
                ),
                Material(
                  child: InkWell(
                    splashColor: Colors.white60,
                    onTap: () {
                      final height = containerHeight.value > 0 ? 0.0 : 240.0;
                      containerHeight.value = height;
                    },
                    child: Icon(
                      Icons.menu,
                      color: Colors.black54,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:fliproadmin/core/utilities/logic_helper.dart';
import 'package:fliproadmin/core/view_model/home_provider/home_provider.dart';
import 'package:fliproadmin/core/view_model/user_provider/user_provider.dart';
import 'package:fliproadmin/ui/view/activity_screen/activity_screen.dart';
import 'package:fliproadmin/ui/view/members_screen/members_screen.dart';
import 'package:fliproadmin/ui/view/profile_screen/profile_Screen.dart';
import 'package:fliproadmin/ui/view/project_acceptance_screen/project_acceptance_screen.dart';
import 'package:fliproadmin/ui/widget/custom_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/services/firebase_messaging_service/firebase_messaging_service.dart';
import 'home_nav_bar.dart';
import 'home_page_body.dart';

class home {
  late final bool assigned;
  late final String name;
  late final String loc;
  late final String img;

  home({required this.name, required this.assigned, required this.img, required this.loc});
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const routeName = '/homeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Widget> bodyWidgets = [
    const HomePageBody(),
    const ActivityScreen(),
    const ProjectAcceptanceScreen(),
    const MembersScreen(),
    ProfileScreen(),
    const Text("4"),
  ];

  @override
  void initState() {
    Future.microtask(() => FirebaseMessagingService.setupTerminatedInteractedMessage(context));
    super.initState();
    print("The token is" + Provider.of<UserProvider>(context, listen: false).getAuthToken);
  }

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(LogicHelper.getCustomAppBarHeight),
        child: CustomAppBar(
          bannerText: homeProvider.getSelectedHomeIndex == 4 ? "Profile" : "Admin Panel",
          showBothIcon: true,
          automaticallyImplyLeading: false,
        ),
      ),
      body: bodyWidgets.elementAt(homeProvider.getSelectedHomeIndex),
      bottomNavigationBar: HomeNavBar(homeProvider: homeProvider),
    );
  }
}

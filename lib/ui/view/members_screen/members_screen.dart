import 'package:fliproadmin/core/utilities/logic_helper.dart';
import 'package:fliproadmin/ui/view/members_screen/add_member/add_member_screen.dart';
import 'package:fliproadmin/ui/view/members_screen/member_pages/franchisee_page.dart';
import 'package:fliproadmin/ui/view/members_screen/member_pages/home_owner_page.dart';
import 'package:fliproadmin/ui/view/members_screen/member_pages/valuer_page.dart';
import 'package:flutter/material.dart';
import 'member_pages/builder_page.dart';
import 'member_tab_bar.dart';

class MembersScreen extends StatefulWidget {
  const MembersScreen({Key? key}) : super(key: key);

  @override
  State<MembersScreen> createState() => _MembersScreenState();
}

class _MembersScreenState extends State<MembersScreen> {
  late PageController pageController;

  @override
  void initState() {
    pageController = PageController(initialPage: 0);
    super.initState();
  }

  int _index = 0;

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          MemberTabBar(
            pageController: pageController,
            pageControllerIndex: _index,
          ),
          Expanded(
            child: PageView(
              onPageChanged: (e) {
                setState(() {
                  _index = e;
                });
              },
              controller: pageController,
              children: const <Widget>[
                BuilderPage(),
                ValuerPage(),
                FranchiseePage(),
                HomeOwnerPage(),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(AddMemberScreen.routeName, arguments: {
            "appUsers": getCurrentUser(_index),
            "createAssign": false,
          });
        },
        child: const Icon(
          Icons.person_add_alt_1,
        ),
      ),
    );
  }
}

appUsers getCurrentUser(int index) {
  appUsers _appuser = appUsers.admin;
  switch (index) {
    case 0:
      {
        _appuser = appUsers.builder;
      }
      break;

    case 1:
      {
        _appuser = appUsers.evaluator;
      }
      break;
    case 2:
      {
        _appuser = appUsers.franchise;
      }
      break;
    case 3:
      {
        _appuser = appUsers.homeowner;
      }
      break;
    default:
      {
        //statements;
      }
      break;
  }
  return _appuser;
}

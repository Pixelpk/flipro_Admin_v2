import 'package:fliproadmin/ui/view/project_acceptance_screen/payments/payment_request_tab_screen.dart';
import 'package:fliproadmin/ui/view/project_acceptance_screen/project_acceptance_tab_bar.dart';
import 'package:fliproadmin/ui/view/project_acceptance_screen/projects/project_approval_tab_screen.dart';
import 'package:flutter/material.dart';

class ProjectAcceptanceScreen extends StatefulWidget {
   const ProjectAcceptanceScreen({Key? key}) : super(key: key);

  @override
  State<ProjectAcceptanceScreen> createState() => _ProjectAcceptanceScreenState();
}

class _ProjectAcceptanceScreenState extends State<ProjectAcceptanceScreen> {
  late PageController pageController;
int _index = 0 ;
  @override
  void initState() {
    pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    print("DISPOSING");
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ProjectAcceptanceTabBar(pageController: pageController, index: _index),
          Expanded(
            child: PageView(

              onPageChanged: (i){
                setState(() {
                  _index = i ;
                });
              },
              physics: const NeverScrollableScrollPhysics(),
              controller: pageController,
              children:  const <Widget>[
                ProjectApprovalTabScreen(),
                ProjectPaymentTabScreen()
              ],
            ),
          ),
        ],
      ),
    );
  }
}

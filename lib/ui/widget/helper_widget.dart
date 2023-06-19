import 'package:fliproadmin/core/model/access_control_object.dart';
import 'package:fliproadmin/core/model/project_response/project_response.dart';
import 'package:fliproadmin/core/utilities/logic_helper.dart';
import 'package:fliproadmin/ui/view/access_control_screen/builder_access_control_screen.dart';
import 'package:fliproadmin/ui/view/access_control_screen/franchisee_access_control_screen.dart';
import 'package:fliproadmin/ui/view/access_control_screen/home_owner_access_control.dart';
import 'package:fliproadmin/ui/view/access_control_screen/valuer_access_control_screen.dart';
import 'package:flutter/material.dart';

class HelperWidget {
  static Widget progressIndicator() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  static handleTrademanNavigation(
      {required appUsers user,
      required BuildContext context,
      required UserRoleModel userRoleModel,
      required currentRoute}) {
    switch (user) {
      // case appUsers.admin:
      //   {
      //     Navigator.of(context).pushNamed(
      //         BuilderAccessControlScreen.routeName) ;
      //   }
      //   break;

      case appUsers.homeowner:
        {
          Navigator.of(context).pushNamed(
              HomeOwnerAccessControlScreen.routeName,
              arguments: AccessControlObject(
                  userRoleModel: userRoleModel, routeName: currentRoute));
        }
        break;
      case appUsers.builder:
        {
          Navigator.of(context).pushNamed(BuilderAccessControlScreen.routeName,
              arguments: AccessControlObject(
                  userRoleModel: userRoleModel, routeName: currentRoute));
        }
        break;
      case appUsers.evaluator:
        {
          Navigator.of(context).pushNamed(ValuerAccessControlScreen.routeName,
              arguments: AccessControlObject(
                  userRoleModel: userRoleModel, routeName: currentRoute));
        }
        break;
        case appUsers.franchise:
        {
          Navigator.of(context).pushNamed(FranchiseeAccessControlScreen.routeName,
              arguments: AccessControlObject(
                  userRoleModel: userRoleModel, routeName: currentRoute));
        }
        break;
      default:
        {}
        break;
    }
  }
}

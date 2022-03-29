import 'package:fliproadmin/core/model/access_control_object.dart';
import 'package:fliproadmin/core/model/project_response/project_response.dart';
import 'package:fliproadmin/core/utilities/app_colors.dart';
import 'package:fliproadmin/core/utilities/logic_helper.dart';
import 'package:fliproadmin/ui/view/access_control_screen/builder_access_control_screen.dart';
import 'package:fliproadmin/ui/view/access_control_screen/home_owner_access_control.dart';
import 'package:fliproadmin/ui/view/access_control_screen/valuer_access_control_screen.dart';
import 'package:fliproadmin/ui/view/add_trademan_screen/add_trademan_screen.dart';
import 'package:fliproadmin/ui/view/assigned_trademan_screen/assigned_trademan_view.dart';
import 'package:fliproadmin/ui/widget/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'colored_label.dart';
import 'labeledTextField.dart';

class TradeManSection extends StatelessWidget {
  const TradeManSection(
      {Key? key,
      this.showBuilderRevokeAccess = false,
      this.builder,
      this.homeOwner,
      this.projectId,
        this.showHomeOwnerRevokeAccess = false ,
      this.valuer,
       required this.currentrouteName,
      this.showValuerRevokeAccess = false})
      : super(key: key);
  final String currentrouteName ;
  final bool showBuilderRevokeAccess;
  final bool showHomeOwnerRevokeAccess;
  final bool showValuerRevokeAccess;
  final UserRoleModel? homeOwner;
  final int? projectId;
  final List<UserRoleModel>? builder;
  final List<UserRoleModel>? valuer;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          LabeledTextField(
            label: "Home Owner",
            maxlines: 1,
            readonly: true,
            labelWidget: showHomeOwnerRevokeAccess
                 && homeOwner !=null ? ColoredLabel(
              color: AppColors.lightRed,
              text: 'Revoke Access',
              callback: () {
                Navigator.pushNamed(
                    context, HomeOwnerAccessControlScreen.routeName,
                    arguments: AccessControlObject(userRoleModel: homeOwner!, routeName: currentrouteName));
              },
            )
                : null,
            hintText: homeOwner != null && homeOwner!.name != null
                ? homeOwner!.name
                : "Home Owner Name",
            suffixIcon: homeOwner != null && homeOwner!.name != null
                ? null
                : IconButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed(AddTradeManScreen.routeName, arguments: {
                        "appUser": appUsers.homeowner,
                        "projectId": projectId,
                        "currentRoute":currentrouteName,
                      });
                    },
                    icon: const Icon(
                      Icons.add_circle_outline,
                      color: AppColors.mainThemeBlue,
                    ),
                  ),
          ),
          // LabeledTextField(
          //   label: "Add Builder",
          //   maxlines: 1,
          //   readonly: true,
          //   hintText: builder != null && builder!.isNotEmpty
          //       ? "${builder!.length} Builders Assigned"
          //       : "Builder Name",
          //   labelWidget: builder != null && builder!.length == 1
          //       ? showBuilderRevokeAccess
          //           ? ColoredLabel(
          //               color: AppColors.lightRed,
          //               text: 'Revoke Access',
          //               callback: () {
          //                 Navigator.pushNamed(
          //                     context, BuilderAccessControlScreen.routeName,
          //                     arguments: AccessControlObject(userRoleModel: builder![0], routeName: currentrouteName));
          //               },
          //             )
          //           : null
          //       : ColoredLabel(
          //           color: AppColors.lightRed,
          //           text: 'view all',
          //           callback: () {
          //             Navigator.pushNamed(context, AssignedTrademan.routeName,
          //                 arguments: appUsers.builder);
          //           },
          //         ),
          //   suffixIcon: IconButton(
          //     onPressed: () {
          //       Navigator.of(context).pushNamed(AddTradeManScreen.routeName,
          //           arguments: {
          //             "appUser": appUsers.builder,
          //             "projectId": projectId,
          //             "currentRoute":currentrouteName
          //           });
          //     },
          //     icon: const Icon(
          //       Icons.add_circle_outline,
          //       color: AppColors.mainThemeBlue,
          //     ),
          //   ),
          // ),
          LabeledTextField(
            label: "Add Builder",
            maxlines: 1,
            readonly: true,
            hintText: builder != null && builder!.isNotEmpty
                ? "${builder!.length} Builders Assigned"
                : "Builder Name",
            labelWidget: builder != null ? showValuerRevokeAccess ? builder!.isNotEmpty && builder!.length > 1 ?ColoredLabel(
              color: AppColors.lightRed,
              text: 'view all',
              callback: () {
                ///ALL ASSIGNED Builder
                Navigator.pushNamed(context, AssignedTrademan.routeName,
                    arguments: appUsers.builder);
              },
            ): builder!.isNotEmpty && builder!.length  == 1 ? ColoredLabel(
              color: AppColors.lightRed,
              text: 'Revoke Access',
              callback: () {
                Navigator.pushNamed(
                    context, ValuerAccessControlScreen.routeName,
                    arguments: AccessControlObject(userRoleModel: builder![0], routeName: currentrouteName));
              },
            ):  null:null:null ,

            suffixIcon: IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AddTradeManScreen.routeName,
                    arguments: {
                      "appUser": appUsers.builder,
                      "projectId": projectId,
                      "currentRoute":currentrouteName
                    });
              },
              icon: const Icon(
                Icons.add_circle_outline,
                color: AppColors.mainThemeBlue,
              ),
            ),
          ),
          LabeledTextField(
            label: "Add Valuer",
            maxlines: 1,
            readonly: true,
            hintText: valuer != null && valuer!.isNotEmpty
                ? "${valuer!.length} Valuers Assigned"
                : "Valuer Name",
            labelWidget: valuer != null ? showValuerRevokeAccess ? valuer!.isNotEmpty && valuer!.length > 1 ?ColoredLabel(
              color: AppColors.lightRed,
              text: 'view all',
              callback: () {
                ///ALL ASSIGNED VALUERS
                Navigator.pushNamed(context, AssignedTrademan.routeName,
                    arguments: appUsers.evaluator);
              },
            ): valuer!.isNotEmpty && valuer!.length  == 1 ? ColoredLabel(
              color: AppColors.lightRed,
              text: 'Revoke Access',
              callback: () {
                Navigator.pushNamed(
                    context, ValuerAccessControlScreen.routeName,
                    arguments: AccessControlObject(userRoleModel: valuer![0], routeName: currentrouteName));
              },
            ):  null:null:null ,

            suffixIcon: IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AddTradeManScreen.routeName,
                    arguments: {
                      "appUser": appUsers.evaluator,
                      "projectId": projectId,
                      "currentRoute":currentrouteName
                    });
              },
              icon: const Icon(
                Icons.add_circle_outline,
                color: AppColors.mainThemeBlue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

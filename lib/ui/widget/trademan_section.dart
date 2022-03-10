import 'package:fliproadmin/core/utilities/app_colors.dart';
import 'package:fliproadmin/core/utilities/logic_helper.dart';
import 'package:fliproadmin/ui/view/access_control_screen/builder_access_control_screen.dart';
import 'package:fliproadmin/ui/view/access_control_screen/valuer_access_control_screen.dart';
import 'package:fliproadmin/ui/view/add_trademan_screen/add_trademan_screen.dart';
import 'package:fliproadmin/ui/widget/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'colored_label.dart';
import 'labeledTextField.dart';

class TradeManSection extends StatelessWidget {
  const TradeManSection(
      {Key? key,
      this.showBuilderRevokeAccess = false,
      this.showValuerRevokeAccess = false})
      : super(key: key);
  final bool showBuilderRevokeAccess;
  final bool showValuerRevokeAccess;

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
            readonly: false,
            suffixIcon: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.cancel_outlined,
                color: AppColors.lightRed,
              ),
            ),
          ),
          LabeledTextField(
            label: "Add Builder",
            maxlines: 1,
            readonly: false,
            labelWidget: showBuilderRevokeAccess
                ? ColoredLabel(
                    color: AppColors.lightRed,
                    text: 'Revoke Access',
                    callback: () {
                      Navigator.pushNamed(
                          context, BuilderAccessControlScreen.routeName);
                    },
                  )
                : null,
            suffixIcon: IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AddTradeManScreen.routeName,
                    arguments: appUsers.builder);
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
            readonly: false,
            labelWidget: showValuerRevokeAccess
                ? ColoredLabel(
                    color: AppColors.lightRed,
                    text: 'Revoke Access',
                    callback: () {
                      Navigator.pushNamed(
                          context, ValuerAccessControlScreen.routeName);
                    },
                  )
                : null,
            suffixIcon: IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AddTradeManScreen.routeName,
                    arguments: appUsers.evaluator);
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

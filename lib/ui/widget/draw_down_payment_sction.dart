import 'package:fliproadmin/core/model/generic_model/generic_model.dart';
import 'package:fliproadmin/core/services/payment_service/payment_service.dart';
import 'package:fliproadmin/core/utilities/app_colors.dart';
import 'package:fliproadmin/core/view_model/auth_provider/auth_provider.dart';
import 'package:fliproadmin/core/view_model/loaded_project/loaded_project.dart';
import 'package:fliproadmin/core/view_model/user_provider/user_provider.dart';
import 'package:fliproadmin/ui/view/view_project_screen/view_project_draw_down_payments.dart';
import 'package:fliproadmin/ui/widget/getx_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'colored_label.dart';
import 'helper_widget.dart';
import 'media_section.dart';

class DrawDownPaymentScetion extends StatelessWidget {
  const DrawDownPaymentScetion({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<LoadedProjectProvider>(builder: (ctx, loadedProject, c) {

      if (loadedProject.getLoadingState == loadingState.loading) {
        return const SizedBox();
      }
      if (loadedProject.getLoadedProject == null &&
          loadedProject.getLoadingState == loadingState.loaded) {
        return SizedBox(
          height: 70.h,
          child: const Center(
            child: Text("Encounter an Error ,Please try again later"),
          ),
        );
      }
      if (loadedProject.getLoadedProject!.latestPaymentReq == null ||
          loadedProject.getLoadedProject!.latestPaymentReq!.id == null) {
        // ignore: avoid_unnecessary_containers
        return  Container(
          height: 250,
          child: const Center(
            child:  Text("No draw down payment request from Franchise"),
          ),
        );
      }
      print(loadedProject.getLoadedProject!.latestPaymentReq!.toJson());
      return Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  "Drawdown Payment Request",
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .copyWith(color: AppColors.greyDark),
                ),
              ),
              const Spacer(),
               ColoredLabel(text: 'View All',callback: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (_)=>const ProjectDrwDownPayments()));
              },)
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.w),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: AppColors.blueUnselectedTabColor),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "REQUESTED AMOUNT",
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(color: AppColors.mainThemeBlue),
                    ),
                    Expanded(
                        child: ColoredLabel(
                      text:
                          '${loadedProject.getLoadedProject!.latestPaymentReq!.amount!}\$',
                      height: 6.h,
                    ))
                  ],
                ),
                SizedBox(
                  height: 4.h,
                ),

                ///MEDIA SECTION
                loadedProject.getLoadedProject!.latestPaymentReq!
                                .paymentReqMedia !=
                            null &&
                        (loadedProject.getLoadedProject!.latestPaymentReq!
                                    .paymentReqMedia!.images !=
                                null ||
                            loadedProject.getLoadedProject!.latestPaymentReq!
                                    .paymentReqMedia!.videos !=
                                null)
                    ? MediaSection(
                        media: loadedProject.getLoadedProject!.latestPaymentReq!
                            .paymentReqMedia!,
                      )
                    : Container(),
                SizedBox(
                  height: 2.h,
                ),

                ///APPROVAL REJECTION BUTTONS
                ///
                ///
                if (loadedProject.getLoadedProject!.latestPaymentReq!.status ==
                    "pending")
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ColoredLabel(
                        text: 'Approve',
                        height: 6.h,
                        color: AppColors.green,
                        width: 30.w,

                        ///PAYMENT REQUEST APPROVE CALLBACK
                        callback: () async {
                          GenericModel genericModel =
                              await PaymentService.approveRejectPaymentReq(
                                  accessToken: Provider.of<UserProvider>(
                                          context,
                                          listen: false)
                                      .getAuthToken,
                                  paymentReqId: loadedProject
                                      .getLoadedProject!.latestPaymentReq!.id!,
                                  rejectionReason: ' ',
                                  isRejected: false);
                          GetXDialog.showDialog(
                              title: genericModel.title,
                              message: genericModel.message);
                          if (genericModel.success) {
                            loadedProject.updatePaymentStatus('approved');
                          }
                        },
                      ),
                      ColoredLabel(
                        text: 'Reject',
                        height: 6.h,
                        color: AppColors.lightRed,
                        width: 30.w,

                        ///PAYMENT REQUEST REJECTION CALLBACK
                        callback: () async {
                          GenericModel genericModel =
                              await PaymentService.approveRejectPaymentReq(
                                  accessToken: Provider.of<UserProvider>(
                                          context,
                                          listen: false)
                                      .getAuthToken,
                                  paymentReqId: loadedProject
                                      .getLoadedProject!.latestPaymentReq!.id!,
                                  rejectionReason: ' ',
                                  isRejected: true);

                          GetXDialog.showDialog(
                              title: genericModel.title,
                              message: genericModel.message);
                          if (genericModel.success) {
                            loadedProject.updatePaymentStatus('rejected');
                          }
                        },
                      )
                    ],
                  ),
                if (loadedProject.getLoadedProject!.latestPaymentReq!.status ==
                    "approved")
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "Payment has been approved",
                        style: TextStyle(
                          color: AppColors.green,
                        ),
                      ),
                    ],
                  ),
                if (loadedProject.getLoadedProject!.latestPaymentReq!.status ==
                    "rejected")
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        "Payment request is rejected",
                        style: TextStyle(
                          color: AppColors.darkRed,
                        ),
                      ),
                      const Spacer(),
                      ColoredLabel(
                        text: 'Approve now',
                        height: 6.h,
                        color: AppColors.lightRed,
                        width: 30.w,

                        ///PAYMENT REQUEST REJECTION CALLBACK
                        callback: () async {
                          GenericModel genericModel =
                              await PaymentService.approveRejectPaymentReq(
                                  accessToken: Provider.of<UserProvider>(
                                          context,
                                          listen: false)
                                      .getAuthToken,
                                  paymentReqId: loadedProject
                                      .getLoadedProject!.latestPaymentReq!.id!,
                                  rejectionReason: ' ',
                                  isRejected: false);
                          GetXDialog.showDialog(
                              title: genericModel.title,
                              message: genericModel.message);
                          if (genericModel.success) {
                            loadedProject.updatePaymentStatus('approved');
                          }
                        },
                      )
                    ],
                  ),
              ],
            ),
          )
        ],
      );
    });
  }
}

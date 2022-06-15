import 'package:fliproadmin/core/model/generic_model/generic_model.dart';
import 'package:fliproadmin/core/model/payment_response/draw_down_payment.dart';
import 'package:fliproadmin/core/services/payment_service/payment_service.dart';
import 'package:fliproadmin/core/utilities/app_colors.dart';
import 'package:fliproadmin/core/view_model/auth_provider/auth_provider.dart';
import 'package:fliproadmin/core/view_model/loaded_project/loaded_project.dart';
import 'package:fliproadmin/core/view_model/user_provider/user_provider.dart';
import 'package:fliproadmin/ui/widget/colored_label.dart';
import 'package:fliproadmin/ui/widget/custom_app_bar.dart';
import 'package:fliproadmin/ui/widget/getx_dialogs.dart';
import 'package:fliproadmin/ui/widget/media_section.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class RejectedPaymentScreen extends StatelessWidget {
  const RejectedPaymentScreen({Key? key, required this.payment})
      : super(key: key);
  final DrawDownPayment payment;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(15.h),
          child: const CustomAppBar(
            bannerText: "Rejected Payments",
            automaticallyImplyLeading: true,
            showBothIcon: false,
            bannerColor: AppColors.darkRed,
          )),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
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
                const ColoredLabel(text: 'View All')
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
                        text: '${payment.amount}\$',
                        height: 6.h,
                      ))
                    ],
                  ),
                  SizedBox(
                    height: 4.h,
                  ),

                  ///MEDIA SECTION
                  payment.paymentReqMedia != null &&
                          (payment.paymentReqMedia!.images != null ||
                              payment.paymentReqMedia!.videos != null)
                      ? MediaSection(
                          media: payment.paymentReqMedia!,
                        )
                      : Container(),
                  SizedBox(
                    height: 2.h,
                  ),

                  ///APPROVAL REJECTION BUTTONS
                  ///
                  ///
                  if (payment.status == "pending")
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
                                    paymentReqId: payment.id!,
                                    rejectionReason: ' ',
                                    isRejected: false);
                            GetXDialog.showDialog(
                                title: genericModel.title,
                                message: genericModel.message);
                            if (genericModel.success) {
                              Navigator.pop(context, true);
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
                                    paymentReqId: payment.id!,
                                    rejectionReason: ' ',
                                    isRejected: true);

                            GetXDialog.showDialog(
                                title: genericModel.title,
                                message: genericModel.message);
                            if (genericModel.success) {
                              Navigator.pop(context, true);
                            }
                          },
                        )
                      ],
                    ),
                  if (payment.status == "approvedpaymen")
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
                  if (payment.status == "rejected")
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
                                    paymentReqId: payment.id!,
                                    rejectionReason: ' ',
                                    isRejected: false);
                            GetXDialog.showDialog(
                                title: genericModel.title,
                                message: genericModel.message);
                            if (genericModel.success) {
                              Navigator.pop(context, true);
                            }
                          },
                        )
                      ],
                    ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

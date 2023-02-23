import 'package:fliproadmin/core/model/generic_model/generic_model.dart';
import 'package:fliproadmin/core/model/payment_response/draw_down_payment.dart';
import 'package:fliproadmin/core/services/payment_service/payment_service.dart';
import 'package:fliproadmin/core/utilities/app_colors.dart';
import 'package:fliproadmin/core/view_model/user_provider/user_provider.dart';
import 'package:fliproadmin/ui/widget/colored_label.dart';
import 'package:fliproadmin/ui/widget/custom_app_bar.dart';
import 'package:fliproadmin/ui/widget/getx_dialogs.dart';
import 'package:fliproadmin/ui/widget/labeledTextField.dart';
import 'package:fliproadmin/ui/widget/media_section.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class RejectedPaymentScreen extends StatefulWidget {
  RejectedPaymentScreen({Key? key, required this.payment}) : super(key: key);
  final DrawDownPayment payment;

  @override
  State<RejectedPaymentScreen> createState() => _RejectedPaymentScreenState();
}

class _RejectedPaymentScreenState extends State<RejectedPaymentScreen> {
  late TextEditingController reasonController;
  var formatter = NumberFormat('#,##0.' + "#" * 5);

  @override
  void initState() {
    reasonController = TextEditingController(text: widget.payment.reason ?? '');
    super.initState();
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(15.h),
            child: CustomAppBar(
                bannerText: widget.payment.status == "rejected" ? "Rejected Payments" : "Payment Request",
                automaticallyImplyLeading: true,
                showBothIcon: false,
                bannerColor: widget.payment.status == "rejected"
                    ? AppColors.darkRed
                    : widget.payment.status == "pending"
                        ? AppColors.yellow
                        : AppColors.green)),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              SizedBox(height: 1.h),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      "Draw-down Payment Request",
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(color: AppColors.greyDark),
                    ),
                  ),
                  const Spacer(),
                  const ColoredLabel(text: 'View All')
                ],
              ),
              SizedBox(height: 1.h),
              Container(
                  padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.w),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(5), color: AppColors.blueUnselectedTabColor),
                  child: Column(children: [
                    Row(
                      children: [
                        Text(
                          "REQUESTED AMOUNT",
                          style: Theme.of(context).textTheme.headline6!.copyWith(color: AppColors.mainThemeBlue),
                        ),
                        Expanded(
                            child: ColoredLabel(
                          text:
                              '\$${formatter.format(double.parse(widget.payment.amount.toString().replaceAll(",", "")))}',
                          height: 6.h,
                        ))
                      ],
                    ),
                    SizedBox(
                      height: 4.h,
                    ),

                    ///MEDIA SECTION
                    widget.payment.paymentReqMedia != null &&
                            (widget.payment.paymentReqMedia!.images != null ||
                                widget.payment.paymentReqMedia!.videos != null)
                        ? MediaSection(
                            media: widget.payment.paymentReqMedia!,
                          )
                        : Container(),
                    SizedBox(height: 2.h),

                    LabeledTextField(
                        label: "Reason",
                        maxLines: 2,
                        readonly: false,
                        textEditingController: TextEditingController(text: widget.payment.description ?? "NA")),
                    SizedBox(height: 2.h),

                    ///APPROVAL REJECTION BUTTONS
                    if (widget.payment.status == "pending")
                      isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ColoredLabel(
                                  text: 'Approve',
                                  height: 6.h,
                                  color: AppColors.green,
                                  width: 30.w,

                                  ///PAYMENT REQUEST APPROVE CALLBACK
                                  callback: () async {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    GenericModel genericModel = await PaymentService.approveRejectPaymentReq(
                                        accessToken: Provider.of<UserProvider>(context, listen: false).getAuthToken,
                                        paymentReqId: widget.payment.id!,
                                        rejectionReason: reasonController.text,
                                        isRejected: false);
                                    GetXDialog.showDialog(title: genericModel.title, message: genericModel.message);
                                    setState(() {
                                      isLoading = false;
                                    });
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
                                    setState(() {
                                      isLoading = true;
                                    });
                                    GenericModel genericModel = await PaymentService.approveRejectPaymentReq(
                                        accessToken: Provider.of<UserProvider>(context, listen: false).getAuthToken,
                                        paymentReqId: widget.payment.id!,
                                        rejectionReason: reasonController.text,
                                        isRejected: true);
                                    setState(() {
                                      isLoading = false;
                                    });
                                    GetXDialog.showDialog(title: genericModel.title, message: genericModel.message);
                                    if (genericModel.success) {
                                      Navigator.pop(context, true);
                                    }
                                  },
                                )
                              ],
                            ),
                    if (widget.payment.status == "approvedpaymen")
                      isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
                              Text("Payment has been approved", style: TextStyle(color: AppColors.green))
                            ]),
                    if (widget.payment.status == "rejected")
                      isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                              const Text("Payment request is rejected", style: TextStyle(color: AppColors.darkRed)),
                              const Spacer(),
                              ColoredLabel(
                                  text: 'Approve now',
                                  height: 6.h,
                                  color: AppColors.lightRed,
                                  width: 30.w,

                                  ///PAYMENT REQUEST REJECTION CALLBACK
                                  callback: () async {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    GenericModel genericModel = await PaymentService.approveRejectPaymentReq(
                                        accessToken: Provider.of<UserProvider>(context, listen: false).getAuthToken,
                                        paymentReqId: widget.payment.id!,
                                        rejectionReason: reasonController.text,
                                        isRejected: false);
                                    setState(() {
                                      isLoading = false;
                                    });
                                    GetXDialog.showDialog(title: genericModel.title, message: genericModel.message);
                                    if (genericModel.success) {
                                      Navigator.pop(context, true);
                                    }
                                  })
                            ])
                  ]))
            ])));
  }
}

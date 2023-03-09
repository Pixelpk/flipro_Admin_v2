import 'package:cached_network_image/cached_network_image.dart';
import 'package:fliproadmin/core/model/payment_response/draw_down_payment.dart';
import 'package:fliproadmin/core/utilities/app_colors.dart';
import 'package:fliproadmin/core/utilities/app_constant.dart';
import 'package:fliproadmin/core/view_model/home_provider/home_provider.dart';
import 'package:fliproadmin/core/view_model/loaded_project/loaded_project.dart';
import 'package:fliproadmin/core/view_model/project_provider/project_provider.dart';
import 'package:fliproadmin/core/view_model/projects_provider/projects_provider.dart';
import 'package:fliproadmin/ui/view/project_acceptance_screen/payments/rejected_payment_screen.dart';
import 'package:fliproadmin/ui/view/share_screen/image_sharing.dart';
import 'package:fliproadmin/ui/view/view_project_screen/view_project_screen.dart';
import 'package:fliproadmin/ui/widget/view_project_details.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'custom_cache_network_image.dart';

class PaymentReqListItem extends StatelessWidget {
  const PaymentReqListItem({Key? key, required this.rejected, this.paymentRequest, this.pagingController})
      : super(key: key);
  final PagingController? pagingController;
  final DrawDownPayment? paymentRequest;
  final bool rejected;

  @override
  Widget build(BuildContext context) {
    var formatter = NumberFormat('#,##0.' + "#" * 5);
    return Container(
      height: 110,
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
      padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.w),
      margin: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 50,
            child: InkWell(
              onTap: () async {
                print("The amount is" + paymentRequest!.amount.toString());

                ///OPEN SECOND TAB
                Provider.of<HomeProvider>(context, listen: false).onProjectViewPageChange(1);
                Provider.of<LoadedProjectProvider>(context, listen: false)
                    .fetchLoadedProject(paymentRequest!.projectId!);
                var refresh;
                // if (rejected) {
                refresh = await Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => RejectedPaymentScreen(payment: paymentRequest!)));
                // }
                // if (!rejected) {
                //   refresh = await Navigator.pushNamed(
                //       context, ViewProjectScreen.routeName,
                //       arguments: rejected);
                // }
                if (refresh != null && refresh == true) {
                  pagingController!.refresh();
                }
                print("DO REFRESH $refresh");
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      flex: 20,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CustomCachedImage(
                          imageUrl: paymentRequest!.project!.coverPhoto ?? '',
                          fit: BoxFit.cover,
                        ),
                      )),
                  Expanded(
                      flex: 30,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 4, right: 2),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Text(
                                "Title: ${paymentRequest!.project!.title}",
                                style: Theme.of(context).textTheme.headline6!.copyWith(color: AppColors.mainThemeBlue),
                                maxLines: 2,
                              ),
                            ),
                            Text(
                              "Amount: \$${formatter.format(double.parse(paymentRequest!.amount.toString().replaceAll(",", "")))}",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(color: AppColors.mainThemeBlue, fontSize: 12),
                              maxLines: 2,
                            ),
                            Flexible(
                              child: Text(
                                paymentRequest!.description != null
                                    ? "Reason: ${paymentRequest!.description}"
                                    : "Reason: NA",
                                style: Theme.of(context).textTheme.subtitle1!.copyWith(color: AppColors.greyDark),
                                maxLines: 3,
                              ),
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            ),
          ),
          Expanded(
              flex: rejected ? 15 : 20,
              child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Flexible(
                    child: Text(paymentRequest!.status!.toUpperCase(),
                        style: Theme.of(context).textTheme.subtitle2!.copyWith(
                            color: paymentRequest!.status == "rejected"
                                ? AppColors.lightRed
                                : paymentRequest!.status == "approved"
                                    ? AppColors.green
                                    : AppColors.yellow,
                            overflow: TextOverflow.fade)))
              ])),
        ],
      ),
    );
  }
}

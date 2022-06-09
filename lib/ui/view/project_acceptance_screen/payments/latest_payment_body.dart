import 'package:fliproadmin/core/model/generic_model/generic_model.dart';
import 'package:fliproadmin/core/model/payment_response/draw_down_payment.dart';
import 'package:fliproadmin/core/model/payment_response/payment_response.dart';
import 'package:fliproadmin/core/services/payment_service/payment_service.dart';
import 'package:fliproadmin/core/view_model/home_provider/home_provider.dart';
import 'package:fliproadmin/core/view_model/home_provider/home_provider.dart';
import 'package:fliproadmin/core/view_model/home_provider/home_provider.dart';
import 'package:fliproadmin/core/view_model/user_provider/user_provider.dart';
import 'package:fliproadmin/ui/view/project_overview_screen/project_overview_Screen.dart';
import 'package:fliproadmin/ui/view/view_project_screen/view_project_screen.dart';
import 'package:fliproadmin/ui/widget/approve_list_item.dart';
import 'package:fliproadmin/ui/widget/getx_dialogs.dart';
import 'package:fliproadmin/ui/widget/payment_req_list_item.dart';
import 'package:fliproadmin/ui/widget/view_project_details.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

class LatestPaymentBody extends StatefulWidget {
  const LatestPaymentBody({
    Key? key,
  }) : super(key: key);

  @override
  State<LatestPaymentBody> createState() => _LatestPaymentBodyState();
}

class _LatestPaymentBodyState extends State<LatestPaymentBody> {
  static const _pageSize = 20;

  final PagingController<int, DrawDownPayment> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      GenericModel genericModel = await PaymentService.getAllPayments(
          accessToken:
              Provider.of<UserProvider>(context, listen: false).getAuthToken,
          page: pageKey,
          fetchPending: true,
          fetchapproved: false,
          fetchRejected: false);
      if (genericModel.statusCode == 200) {
        PaymentResponse paymentResponse = genericModel.returnedModel;
        if (paymentResponse != null &&
            paymentResponse.data != null &&
            paymentResponse.data!.drawDownPaymentsReqs != null) {
          final newItems = paymentResponse.data!.drawDownPaymentsReqs ?? [];
          final isLastPage = newItems.length < _pageSize;
          if (isLastPage) {
            _pagingController.appendLastPage(newItems);
          } else {
            final nextPageKey = pageKey + 1;
            _pagingController.appendPage(newItems, nextPageKey);
          }
        }
      } else if (genericModel.statusCode == 400 ||
          genericModel.statusCode == 422 ||
          genericModel.statusCode == 401) {
        GetXDialog.showDialog(
            title: genericModel.title, message: genericModel.message);
      }
    } catch (error) {
      print(error);
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {

    return RefreshIndicator(
      onRefresh: () => Future.sync(
        () => _pagingController.refresh(),
      ),
      child: PagedListView<int, DrawDownPayment>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<DrawDownPayment>(
            itemBuilder: (context, paymentRequest, index) => PaymentReqListItem(
                  paymentRequest: paymentRequest,
                  rejected: false,
                  pagingController: _pagingController,
                )),
      ),
    );

    // ListView.builder(
    //   itemBuilder: (ctx, index) {
    //     return ApproveListItem(
    //       viewProjectCallback: () {
    //         ///ARGS = PROJECT REJECTED?
    //         homeprovider.onProjectViewPageChange(1);
    //         Navigator.pushNamed(context, ViewProjectScreen.routeName,
    //             arguments: false);
    //       },
    //       rejected: false,
    //     );
    //   },
    //   itemCount: 20,
    // );
  }
}

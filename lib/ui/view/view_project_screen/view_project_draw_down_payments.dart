import 'package:fliproadmin/core/model/generic_model/generic_model.dart';
import 'package:fliproadmin/core/model/payment_response/draw_down_payment.dart';
import 'package:fliproadmin/core/model/payment_response/payment_response.dart';
import 'package:fliproadmin/core/services/payment_service/payment_service.dart';
import 'package:fliproadmin/core/utilities/app_colors.dart';
import 'package:fliproadmin/core/utilities/logic_helper.dart';
import 'package:fliproadmin/core/view_model/loaded_project/loaded_project.dart';
import 'package:fliproadmin/core/view_model/user_provider/user_provider.dart';
import 'package:fliproadmin/ui/widget/custom_app_bar.dart';
import 'package:fliproadmin/ui/widget/getx_dialogs.dart';
import 'package:fliproadmin/ui/widget/payment_req_list_item.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

class ProjectDrwDownPayments extends StatefulWidget {
  const ProjectDrwDownPayments({
    Key? key,
  }) : super(key: key);

  @override
  State<ProjectDrwDownPayments> createState() => _ProjectDrwDownPaymentsState();
}

class _ProjectDrwDownPaymentsState extends State<ProjectDrwDownPayments> {
  static const _pageSize = 20;

  final PagingController<int, DrawDownPayment> _pagingController = PagingController(firstPageKey: 1);

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
          accessToken: Provider.of<UserProvider>(context, listen: false).getAuthToken,
          page: pageKey,
          getSingleProject: true,
          projectId: Provider.of<LoadedProjectProvider>(context, listen: false).getLoadedProject!.id,
          fetchPending: false,
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
      } else if (genericModel.statusCode == 400 || genericModel.statusCode == 422 || genericModel.statusCode == 401) {
        GetXDialog.showDialog(title: genericModel.title, message: genericModel.message);
      }
    } catch (error) {
      print(error);
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(LogicHelper.getCustomAppBarHeight),
        child: const CustomAppBar(
          automaticallyImplyLeading: true,
          bannerText: "Payment Request",
          bannerColor: AppColors.mainThemeBlue,
          showBothIcon: false,
          showNoteIcon: true,
          showShareIcon: true,
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () => Future.sync(
          () => _pagingController.refresh(),
        ),
        child: PagedListView<int, DrawDownPayment>(
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<DrawDownPayment>(
              itemBuilder: (context, paymentRequest, index) => PaymentReqListItem(
                    paymentRequest: paymentRequest,
                    rejected: paymentRequest.status == "rejected" ? true : false,
                    pagingController: _pagingController,
                  )),
        ),
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

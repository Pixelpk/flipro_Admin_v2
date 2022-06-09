import 'package:fliproadmin/core/model/generic_model/generic_model.dart';
import 'package:fliproadmin/core/model/project_response/project_response.dart';
import 'package:fliproadmin/core/model/users_model/users_model.dart';
import 'package:fliproadmin/core/services/db_service/db_service.dart';
import 'package:fliproadmin/core/services/users_service/user_service.dart';
import 'package:fliproadmin/core/view_model/user_provider/user_provider.dart';
import 'package:fliproadmin/ui/view/view_trademan_profile/view_trademan_profile.dart';
import 'package:fliproadmin/ui/widget/trade_man_list_item.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

class ValuerPage extends StatefulWidget {
  const ValuerPage({Key? key}) : super(key: key);

  @override
  _ValuerPageState createState() => _ValuerPageState();
}

class _ValuerPageState extends State<ValuerPage> {
  static const _pageSize = 20;

  final PagingController<int, UserRoleModel> _pagingController =
  PagingController(firstPageKey: 0);

  @override
  void initState() {

    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }
  @override
  void dispose() {
    _pagingController.dispose();    super.dispose();
  }
  Future<void> _fetchPage(int pageKey) async {
    try {
      GenericModel genericModel = await UsersService.getUsers(
          page: pageKey,
          type: 'evaluator',
          token:
          Provider.of<UserProvider>(context, listen: false).getAuthToken);
      if (genericModel.statusCode == 200) {
        UsersModel usersModel = genericModel.returnedModel;

        if (usersModel != null &&
            usersModel.data != null &&
            usersModel.data!.users != null) {
          final newItems = usersModel.data!.users;
          final isLastPage = newItems.length < _pageSize;
          if (isLastPage) {
            _pagingController.appendLastPage(newItems);
          } else {
            final nextPageKey = pageKey + 1;
            _pagingController.appendPage(newItems, nextPageKey);
          }
        }
      }
    } catch (error) {
      print(error);
      _pagingController.error = error;
    }
  }
  @override
  Widget build(BuildContext context) =>
      PagedListView<int, UserRoleModel>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<UserRoleModel>(
            itemBuilder: (context, user, index) => InkWell(
              onTap: () {
                Navigator.pushNamed(context, ViewTradeManProfile.routeName,
                    arguments: user);
              },
              child:  TrademanListItem(
                userRoleModel: user,

              ),
            )
        ),
      );

}
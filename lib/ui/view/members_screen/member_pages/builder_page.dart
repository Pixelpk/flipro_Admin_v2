import 'package:fliproadmin/core/model/users_model/users_model.dart';
import 'package:fliproadmin/core/services/db_service/db_service.dart';
import 'package:fliproadmin/core/services/users_service/user_service.dart';
import 'package:fliproadmin/core/view_model/user_provider/user_provider.dart';
import 'package:fliproadmin/ui/view/view_trademan_profile/view_trademan_profile.dart';
import 'package:fliproadmin/ui/widget/trade_man_list_item.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

class BuilderPage extends StatefulWidget {
  const BuilderPage({Key? key}) : super(key: key);

  @override
  _BuilderPageState createState() => _BuilderPageState();
}

class _BuilderPageState extends State<BuilderPage> {
  static const _pageSize = 10;

  final PagingController<int, Member> _pagingController =
  PagingController(firstPageKey: 1);

  @override
  void initState() {

    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await UsersService.getUsers(page:pageKey, type: 'builder',token: Provider.of<UserProvider>(context,listen: false).getAuthToken);
      print(newItems.length);
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      print(error);
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) =>
  PagedListView<int, Member>(
    pagingController: _pagingController,
    builderDelegate: PagedChildBuilderDelegate<Member>(
        itemBuilder: (context, member, index) => InkWell(
          onTap: () {
            Navigator.pushNamed(context, ViewTradeManProfile.routeName,
                arguments: member);
          },
          child:  TrademanListItem(
            title: 'Builder',
            member: member,
          ),
        )
    ),
  );

  @override
  void dispose() {
    print("BUILDER PAGE DISPOSING");
    _pagingController.dispose();
    super.dispose();
  }
}
import 'package:fliproadmin/core/view_model/user_provider/user_provider.dart';
import 'package:fliproadmin/ui/view/home_screen/home_screen.dart';
import 'package:fliproadmin/ui/widget/helper_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MiddleWareLoading extends StatefulWidget {
  const MiddleWareLoading({Key? key}) : super(key: key);
  static const routeName = '/MiddleWareLoading';
  @override
  _MiddleWareLoadingState createState() => _MiddleWareLoadingState();
}

class _MiddleWareLoadingState extends State<MiddleWareLoading> {
  @override
  void initState() {
    Future.microtask(()
    {Provider.of<UserProvider>(context, listen: false).loadCurrentUser().then((value) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil(HomeScreen.routeName, (route) => false);
    });

    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HelperWidget.progressIndicator(),
    );
  }
}

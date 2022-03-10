import 'package:fliproadmin/core/services/firebase_messaging_service/firebase_messaging_service.dart';
import 'package:fliproadmin/core/utilities/app_colors.dart';
import 'package:fliproadmin/core/utilities/app_constant.dart';
import 'package:fliproadmin/ui/view/login_screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  FirebaseMessagingService? firebaseMessagingServiceHandler;
  @override
  void initState() {
    ///HANDLING FIREBASE NOTIFICATION
    firebaseMessagingServiceHandler = FirebaseMessagingService();
    // firebaseMessagingServiceHandler!.notificationOnMessageOpened();
    firebaseMessagingServiceHandler!.iOSNotificationHandler();
    firebaseMessagingServiceHandler!.notificationOnMessageHandler();
    // FirebaseMessagingService().fcmOnMessageListeners();
    super.initState();
    Future.delayed(Duration(seconds: 4),(){
     Navigator.of(context).pushNamed(LoginScreen.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.mainThemeBlue,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(23.h),
          child: Container(
            padding: EdgeInsets.only(top: 3.h, bottom: 3.h),
            color: AppColors.blueWithOpacity,
            child: SafeArea(child: SvgPicture.asset(AppConstant.homeLogo)),
          ),
        ),
        body: SizedBox(
          height: 78.h,
          width: 100.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(flex: 8, child: Container()),
              SvgPicture.asset(
                AppConstant.logoSimpleWhite,
                height: 6.h,
              ),
              Expanded(flex: 10, child: Container()),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "RENOVATE NOW",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Text("PAY WHEN YOU SELL",
                      style: Theme.of(context).textTheme.headline6)
                ],
              ),
              Expanded(flex: 2, child: Container()),
            ],
          ),
        ));
  }
}

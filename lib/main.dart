import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fliproadmin/core/services/assets_provider/assets_provider.dart';
import 'package:fliproadmin/core/view_model/access_control_provider/access_control_provider.dart';
import 'package:fliproadmin/core/view_model/auth_provider/auth_provider.dart';
import 'package:fliproadmin/core/view_model/home_provider/home_provider.dart';
import 'package:fliproadmin/core/view_model/loaded_project/loaded_project.dart';
import 'package:fliproadmin/core/view_model/projects_provider/projects_provider.dart';
import 'package:fliproadmin/core/view_model/share_provider/share_provider.dart';
import 'package:fliproadmin/core/view_model/user_provider/user_provider.dart';
import 'package:fliproadmin/core/view_model/users_provider/users_provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'core/services/firebase_messaging_service/firebase_messaging_service.dart';
import 'core/utilities/app_colors.dart';
import 'core/utilities/routes.dart';
import 'firebase_options.dart';
import 'global_data/global_data.dart';
import 'package:sizer/sizer.dart';
import 'package:provider/provider.dart';
import 'package:device_preview/device_preview.dart';
import 'ui/view/splash_screen/splash_screen.dart';

///FIREBASE INTEGRATED USING FLUTTER FIRE CLI SO ,
///GOOGLE-SERVICES,JSON FILES IS NOT REQUIRED

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  print("TOKEN${await FirebaseMessaging.instance.getToken()}");
  await initServices();
  runApp(DevicePreview(
      enabled: false,
      builder: (context) {
        return const FliproAdminApp();
      }));
}

class FliproAdminApp extends StatelessWidget {
  const FliproAdminApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_)=>AuthProvider(),),
          ChangeNotifierProvider(create: (_)=>UserProvider(),),
          ChangeNotifierProvider(create: (_)=>HomeProvider(),),
          ChangeNotifierProvider(create: (_)=>ShareProvider(),),
          ChangeNotifierProvider(create: (_)=>AssetProvider(),),
          ChangeNotifierProxyProvider<UserProvider, UsersProvider>(
              create: (context) => UsersProvider(null),
              update: (context, userProvider, usersProvider) =>UsersProvider(userProvider.getAuthToken),
          ),
          ChangeNotifierProxyProvider<UserProvider, ProjectsProvider>(
              create: (context) => ProjectsProvider(null),
              update: (context, userProvider, projectsProvider) => ProjectsProvider(userProvider.getAuthToken),
          ),
          ChangeNotifierProxyProvider<UserProvider, LoadedProjectProvider>(
            create: (context) => LoadedProjectProvider(null),
            update: (context, loadedProvider, projectsProvider) => LoadedProjectProvider(loadedProvider.getAuthToken),
          ),


        ],
        child: GetMaterialApp(
          navigatorKey: navigatorKey,
          title: 'Flipro Admin',
          onInit: (){
            FirebaseMessagingService.setupBackgroundInteractedMessage();
          },
          theme: ThemeData(
            primarySwatch: AppColors.primaryBlueSwatch,
            scaffoldBackgroundColor: AppColors.blueScaffoldBackground,
            fontFamily: "SF-Pro-Display",
            textTheme: const TextTheme(
                headline6: TextStyle(
                    color: AppColors.greyBlue,
                    fontWeight: FontWeight.bold,
                    fontFamily: "SF-Pro-Display-Bold",
                    overflow: TextOverflow.ellipsis,
                    fontSize: 16),
                headline5: TextStyle(
                    fontFamily: "SF-Pro-Display-Semibold",
                    fontSize: 18,
                    color: Colors.white,
                    overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.w600),
                bodyText1: TextStyle(
                    color: AppColors.mainThemeBlue,
                    fontSize: 14,
                    fontFamily: "SF-Pro-Display-Bold",
                    overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.w800),
                caption: TextStyle(
                  fontSize: 12,
                  fontFamily: "SF-Pro-Display-Regular",
                  color: Colors.white,
                  overflow: TextOverflow.ellipsis,
                ),
                button: TextStyle(fontFamily: "SF-Pro-Display-Semibold", fontSize: 18, color: Colors.white, overflow: TextOverflow.ellipsis),
                subtitle1: TextStyle(
                  fontSize: 12,
                  fontFamily: "SF-Pro-Display-Regular",
                  color: Colors.black,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle2: TextStyle(
                  fontSize: 10,
                  fontFamily: "SF-Pro-Display-Regular",
                  color: AppColors.mainThemeBlue,
                  overflow: TextOverflow.ellipsis,
                )),
          ),
          routes: Routes.appRoutes,
          home: const SplashScreen(),
        ),
      );
    });
  }
}

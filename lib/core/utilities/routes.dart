import 'package:fliproadmin/ui/view/access_control_screen/builder_access_control_screen.dart';
import 'package:fliproadmin/ui/view/access_control_screen/franchisee_access_control_screen.dart';
import 'package:fliproadmin/ui/view/access_control_screen/home_owner_access_control.dart';
import 'package:fliproadmin/ui/view/access_control_screen/valuer_access_control_screen.dart';
import 'package:fliproadmin/ui/view/add_project_screen/add_project_media_screen.dart';
import 'package:fliproadmin/ui/view/add_trademan_screen/add_trademan_screen.dart';
import 'package:fliproadmin/ui/view/assigned_trademan_screen/assigned_trademan_view.dart';
import 'package:fliproadmin/ui/view/forgot_password_screen/forgot_password_otp_screen.dart';
import 'package:fliproadmin/ui/view/forgot_password_screen/forgot_password_screen.dart';
import 'package:fliproadmin/ui/view/forgot_password_screen/update_password_screen.dart';
import 'package:fliproadmin/ui/view/home_screen/home_screen.dart';
import 'package:fliproadmin/ui/view/image_gridview_screen/image_grid_view_screen.dart';
import 'package:fliproadmin/ui/view/login_screen/login_screen.dart';
import 'package:fliproadmin/ui/view/members_screen/add_member/add_member_screen.dart';
import 'package:fliproadmin/ui/view/middleware_loading/middleware_loading.dart';
import 'package:fliproadmin/ui/view/notes_screen/note_view_screen.dart';
import 'package:fliproadmin/ui/view/notes_screen/notes_screen.dart';
import 'package:fliproadmin/ui/view/profile_screen/update_password.dart';
import 'package:fliproadmin/ui/view/project_overview_screen/project_overview_Screen.dart';
import 'package:fliproadmin/ui/view/project_progress_timeline_screen/project_progress_timeline_screen.dart';
import 'package:fliproadmin/ui/view/single_progress_screen/single_progress_screen.dart';
import 'package:fliproadmin/ui/view/view_project_screen/view_project_screen.dart';
import 'package:fliproadmin/ui/view/view_trademan_profile/view_trademan_profile.dart';
import 'package:fliproadmin/ui/view/view_unassigned_project/view_unassigned_project.dart';
import 'package:fliproadmin/ui/widget/view_project_details.dart';
import 'package:flutter/material.dart';
class Routes {
  static Map<String, Widget Function(BuildContext)> appRoutes = {
    LoginScreen.routeName: (_) => const LoginScreen(),
    ForgotPasswordScreen.routeName: (_) =>  const ForgotPasswordScreen(),
    ForgotPasswordOtpScreen.routeName: (_) =>  const ForgotPasswordOtpScreen(),
    UpdatePasswordScreen.routeName: (_) =>  const UpdatePasswordScreen(),
    MiddleWareLoading.routeName: (_) => const MiddleWareLoading(),
    UpdatePassword.routeName: (_) => const UpdatePassword(),
    HomeScreen.routeName: (_) => const HomeScreen(),
    ViewUnassignedProject.routeName: (_) => const ViewUnassignedProject(),
    MediaViewAll.routeName: (_) => const MediaViewAll(),
    NotesScreen.routeName: (_) =>  NotesScreen(),
    NoteViewScreen.routeName: (_) => NoteViewScreen(),
    ViewProjectScreen.routeName: (_) => const ViewProjectScreen(),
    ProjectOverviewScreen.routeName: (_) => const ProjectOverviewScreen(),
    ProjectProgressTimeLineScreen.routeName: (_) =>
        const ProjectProgressTimeLineScreen(),
    SingleProgressScreen.routeName: (_) => const SingleProgressScreen(),
    AddTradeManScreen.routeName: (_) => const AddTradeManScreen(),
    BuilderAccessControlScreen.routeName: (_) =>
        const BuilderAccessControlScreen(),
    ValuerAccessControlScreen.routeName: (_) =>
        const ValuerAccessControlScreen(),
    FranchiseeAccessControlScreen.routeName: (_) =>
        const FranchiseeAccessControlScreen(),
    ViewProjectDetails.routeName: (_) => const ViewProjectDetails(),
    ViewTradeManProfile.routeName: (_) => ViewTradeManProfile(),
    AddMemberScreen.routeName: (_) => AddMemberScreen(),
    AddProjectMediaScreen.routeName: (_) => const AddProjectMediaScreen(),
    AssignedTrademan.routeName: (_) => const AssignedTrademan(),
    HomeOwnerAccessControlScreen.routeName:(_)=>const HomeOwnerAccessControlScreen()
  };
}

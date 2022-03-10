import 'package:fliproadmin/core/utilities/app_colors.dart';
import 'package:fliproadmin/core/utilities/app_constant.dart';
import 'package:fliproadmin/ui/view/notes_screen/notes_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key? key,
    required this.bannerText,
    this.showNoteIcon = false,
    this.showShareIcon = false,
    this.showBothIcon = false,
    this.customWidget,
  required   this.automaticallyImplyLeading  ,
    this.bannerColor,
    this.notesCallback,
    this.shareCallback,
  }) : super(key: key);
  final String bannerText;
  final bool showShareIcon;
  final bool showNoteIcon;
  final bool showBothIcon;
  final bool? automaticallyImplyLeading;
  final Color? bannerColor;
  final VoidCallback? notesCallback;
  final VoidCallback? shareCallback;
  final Widget? customWidget ;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          centerTitle: true,
          elevation: 0,

          leading: automaticallyImplyLeading! ? IconButton(icon: const Icon(Icons.arrow_back_ios ,color: Colors.black,),onPressed: (){
            Navigator.pop(context);
          },):null,
          automaticallyImplyLeading: automaticallyImplyLeading!,
          backgroundColor: AppColors.blueScaffoldBackground,
          title: SvgPicture.asset(AppConstant.logoBlack),
        ),
        Container(
          width: 100.w,
          height: 40,
          color: bannerColor?? AppColors.mainThemeBlue,
          child: showBothIcon
              ? Row(
                  children: [
                    Expanded(flex: 30, child: Container()),
                    Text(
                      bannerText,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    Expanded(flex: 10, child: Container()),
                    Expanded(
                      flex: 20,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          showShareIcon
                              ? InkWell(
                                  onTap: shareCallback,
                                  child:
                                      SvgPicture.asset(AppConstant.shareIcon))
                              : Container(),
                          showNoteIcon
                              ? customWidget ?? InkWell(
                                  onTap: notesCallback ??() {
                                    Navigator.of(context).pushNamed(NotesScreen.routeName);
                                  },
                                  child:
                                      SvgPicture.asset(AppConstant.notesIcon))
                              : Container(),
                        ],
                      ),
                    )
                  ],
                )
              : Center(
                  child: Text(
                  bannerText,
                  style: Theme.of(context).textTheme.headline5,
                )),
        )
      ],
    );
  }
}

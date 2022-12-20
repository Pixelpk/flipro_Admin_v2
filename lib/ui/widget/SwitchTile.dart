import 'package:fliproadmin/core/utilities/app_colors.dart';
import 'package:fliproadmin/core/view_model/access_control_provider/access_control_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class SwitchTile extends StatefulWidget {
  SwitchTile({
    Key? key,
    this.width,
    this.heigth,
    this.callback,
    required this.private,
    this.tileTitle,
  }) : super(key: key);
  bool? private = false;
  final double? heigth;
  final String? tileTitle;
  final double? width;
  final ValueChanged<bool>? callback;
  @override
  State<SwitchTile> createState() => _SwitchTileState();
}

class _SwitchTileState extends State<SwitchTile> {
  bool private = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width ?? 90.w,
      height: widget.heigth ?? 8.h,
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      decoration: BoxDecoration(
          color: AppColors.mainThemeBlue,
          borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          Container(
            width: 200,
            child: Text(

              widget.tileTitle ?? "Private",
              style: Theme.of(context).textTheme.headline5,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const Spacer(),
          FlutterSwitch(
            width: 55,
            height: 25,
            valueFontSize: 10.0,
            activeTextColor: AppColors.mainThemeBlue,
            inactiveTextColor: AppColors.mainThemeBlue,
            toggleSize: 16.0,
            value: widget.private!,
            borderRadius: 30.0,
            padding: 6,
            showOnOff: true,
            activeColor: AppColors.blueScaffoldBackground,
            inactiveColor: Colors.white,
            toggleColor: AppColors.mainThemeBlue,
            onToggle: widget.callback!
          ),
        ],
      ),
    );
  }
}

import 'package:fliproadmin/core/utilities/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class MainButton extends StatelessWidget {
  final double? height, width;
  final String? buttonText;
  final VoidCallback? callback;
  final Color? buttonColor;
  final bool userArrow ;
  final double radius ;
  final TextStyle? buttonStyle;
  final bool startALignment ;
  final Widget? child ;
  final bool isloading ;
  const MainButton({
    Key? key,
    this.buttonText,
    this.buttonStyle,
    this.child ,
    this.isloading = false ,
    this.buttonColor,
    this.startALignment = false ,
    this.radius = 13 ,
    this.userArrow = true,
    this.callback,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: buttonColor ?? AppColors.mainThemeBlue,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: MaterialButton(
        minWidth: width, //100.w,
        height: height, // 8.8.h,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
        onPressed: isloading ? null : callback,
        child: isloading  ?  const Padding(
          padding: EdgeInsets.all(12),
          child: CircularProgressIndicator(
            backgroundColor: Colors.white,
          ),
        ) :  userArrow ? Row(
          children: [
            startALignment ? Container(): Expanded(flex: 18, child: Container()),
            Text(buttonText!,
                style: buttonStyle ?? Theme.of(context).textTheme.button),
            Expanded(flex: 12, child: Container()),
            const Icon(
              Icons.arrow_forward,
              color: AppColors.lightBlueGrey,
            ),
          ],
        ): Text(buttonText!,
            style: buttonStyle ?? Theme.of(context).textTheme.button),
      ),
    );
  }
}

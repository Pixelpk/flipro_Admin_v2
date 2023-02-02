import 'package:fliproadmin/core/utilities/app_colors.dart';
import 'package:flutter/material.dart';

class ColoredLabel extends StatelessWidget {
  const ColoredLabel(
      {Key? key,
      this.color,
      required this.text,
      this.callback,
      this.textStyle,
      this.height,
      this.margin,
      this.pading,
      this.width})
      : super(key: key);
  final String text;
  final Color? color;
  final double? margin;
  final TextStyle? textStyle;
  final EdgeInsets? pading;
  final VoidCallback? callback;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: callback,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(color: color ?? AppColors.mainThemeBlue, borderRadius: BorderRadius.circular(8)),
        margin: EdgeInsets.symmetric(horizontal: margin ?? 8),
        padding: pading ?? const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
        child: Center(
          child: Text(text, style: textStyle ?? Theme.of(context).textTheme.subtitle1!.copyWith(color: Colors.white)),
        ),
      ),
    );
  }
}

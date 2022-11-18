
import 'package:fliproadmin/core/utilities/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'custom_input_decoration.dart';
import 'package:flutter/services.dart';

class LabeledTextField extends StatelessWidget {
  const LabeledTextField(
      {Key? key,
        this.textEditingController,
        required this.label,
        required this.maxlines,
        this.keyboardType,
        required this.readonly,
        this.suffixIcon,
        this.fillColor,
        this.labelStyle,
        this.preffixIcon,
        this.inputFormatter,
        this.focusNode,
        this.prefixText,
        this.onTab,
        this.prefixColor,
        this.width,
        this.onChange,
        this.height,
        this.labelWidget,
        this.hintText,
        this.validation})
      : super(key: key);
  final bool readonly;
  final String label;
  final int? maxlines;
  final TextStyle? labelStyle;
  final TextInputType? keyboardType;
  final Widget? labelWidget;
  final FocusNode? focusNode;
  final Widget? suffixIcon;
  final String? preffixIcon;
  final String? prefixText;
  final String? hintText;
  final Color? fillColor ;
  final double? height;
  final double? width;
  final Color? prefixColor;
  final ValueChanged<String>? onChange;

  final VoidCallback? onTab ;
  final List<TextInputFormatter>? inputFormatter ;
  final TextEditingController? textEditingController;
  final FormFieldValidator<String>? validation;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 90.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                label,
                style: labelStyle ??
                    Theme.of(context)
                        .textTheme
                        .subtitle1!
                        .copyWith(color: AppColors.greyFontColor),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 7),
                child: labelWidget ?? Container(),
              )
            ],
          ),
          const SizedBox(height: 8,),
          TextFormField(

            onChanged: onChange,

            controller: textEditingController,
            maxLines: maxlines,
            focusNode: focusNode,
            keyboardType: keyboardType,
            validator: validation,
            readOnly: readonly,
           onTap: onTab,
           inputFormatters: inputFormatter ,
            style: Theme.of(context).textTheme.bodyText1,
            decoration: customInputDecoration(
              prefixColor: prefixColor,
              prefixText: prefixText,
              width: width,
                height: height,
                usePrefixIcon: preffixIcon !=null ? true:false,
                suffixIcon: suffixIcon,
                context: context,
                hintText: hintText??'',
                fillColor: fillColor ?? Colors.white,
                prefixicon: preffixIcon ?? ''),
          ),
        ],
      ),
    );
  }
}

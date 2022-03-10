
import 'package:fliproadmin/core/utilities/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'custom_input_decoration.dart';

class LabeledTextField extends StatelessWidget {
  const LabeledTextField(
      {Key? key,
        this.textEditingController,
        required this.label,
        required this.maxlines,
        this.keyboardType,
        required this.readonly,
        this.suffixIcon,
        this.labelStyle,
        this.preffixIcon,
        this.focusNode,
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
  final String? hintText;

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
          TextFormField(
            controller: textEditingController,
            maxLines: maxlines,
            focusNode: focusNode,
            keyboardType: keyboardType,
            validator: validation,
            readOnly: readonly,
            style: Theme.of(context).textTheme.bodyText1,
            decoration: customInputDecoration(
                usePrefixIcon: preffixIcon !=null ? true:false,
                suffixIcon: suffixIcon,
                context: context,
                hintText: hintText??'',
                prefixicon: preffixIcon ?? ''),
          ),
        ],
      ),
    );
  }
}

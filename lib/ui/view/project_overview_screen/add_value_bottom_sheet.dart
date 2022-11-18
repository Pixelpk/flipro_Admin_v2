import 'package:fliproadmin/core/view_model/auth_provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/utilities/app_colors.dart';
import '../../../core/view_model/loaded_project/loaded_project.dart';
import '../../widget/labeledTextField.dart';
import '../../widget/main_button.dart';

addValueBottomSheet({
  String? value,
}) {
  TextEditingController controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  return showModalBottomSheet(
      isScrollControlled: true,
      context: Get.context!,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return SingleChildScrollView(
            child: Container(
                // height: 300,
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                child: Container(
                    padding: const EdgeInsets.all(8),
                    child: Form(
                      key: _formKey,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Center(
                                child: LabeledTextField(
                                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                              label: value ?? 'Add Value',
                              maxlines: 1,

                              textEditingController: controller,
                              validation: (e) {
                                if (e == null || e.trim().isEmpty) {
                                  return "Please add Value";
                                }
                                return null;
                              },
                              readonly: false,
                              fillColor: Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.4),
                            )),
                            const SizedBox(
                              height: 10,
                            ),
                            MainButton(
                              height: 6.h,
                              buttonText: "Add",
                              callback: () {
                                if (_formKey.currentState!.validate()) {
                                  Provider.of<LoadedProjectProvider>(context,
                                          listen: false)
                                      .addProjectValue(controller.text.trim().toString());
                                }
                              },
                              isloading:
                                  Provider.of<LoadedProjectProvider>(context)
                                          .getLoadingState ==
                                      loadingState.loading,
                              userArrow: false,
                              width: 70.w,
                            )
                          ]),
                    ))));
      });
}

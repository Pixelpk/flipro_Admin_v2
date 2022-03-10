
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'labeledTextField.dart';

class ProjectInfoSection extends StatelessWidget {
  const ProjectInfoSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: const [
          LabeledTextField(
            label: "Project Title:",
            maxlines: null,
            readonly: false,
          ),
          LabeledTextField(
            label: "Area:",
            maxlines: null,
            readonly: false,
          ),
          LabeledTextField(
            label: "Description",
            maxlines: 6,
            readonly: false,
          ),
        ],
      ),
    );
  }
}

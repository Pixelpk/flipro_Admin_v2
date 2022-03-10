import 'package:fliproadmin/core/utilities/app_colors.dart';
import 'package:fliproadmin/core/utilities/app_constant.dart';
import 'package:fliproadmin/core/utilities/logic_helper.dart';
import 'package:fliproadmin/ui/view/view_unassigned_project/view_unassigned_project.dart';
import 'package:fliproadmin/ui/widget/SwitchTile.dart';
import 'package:fliproadmin/ui/widget/colored_label.dart';
import 'package:fliproadmin/ui/widget/custom_app_bar.dart';
import 'package:fliproadmin/ui/widget/labeledTextField.dart';
import 'package:fliproadmin/ui/widget/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:sizer/sizer.dart';

class NoteViewScreen extends StatefulWidget {
  NoteViewScreen({Key? key}) : super(key: key);
  static const routeName = '/noteViewScreen';

  @override
  State<NoteViewScreen> createState() => _NoteViewScreenState();
}

class _NoteViewScreenState extends State<NoteViewScreen> {
  final TextEditingController notesController =
      TextEditingController();
  late FocusNode notesFocusNode;

  bool private = false;
  bool readOnly = true;
  @override
  void initState() {
    notesFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    notesFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final editAble = ModalRoute.of(context)!.settings.arguments as bool;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(LogicHelper.getCustomAppBarHeight),
        child: CustomAppBar(
          automaticallyImplyLeading: true,

          bannerText: "View Note",
          showBothIcon: true,
          showNoteIcon: editAble,
          customWidget: InkWell(
            onTap: () {
              setState(() {
                readOnly = false;
              });
              notesFocusNode.requestFocus();
            },
            child: SvgPicture.asset(
              AppConstant.editIcon,
              height: 20,
            ),
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 5.w),
        child: ListView(
          children: [
            SizedBox(
              height: 3.h,
            ),
            LabeledTextField(
              label: "Franchisee",
              keyboardType: TextInputType.multiline,
              labelStyle: Theme.of(context)
                  .textTheme
                  .subtitle1!
                  .copyWith(color: Colors.black),
              maxlines: 10,
              focusNode: notesFocusNode,
              textEditingController: notesController,
              readonly: readOnly,
            ),
            SizedBox(
              height: 3.h,
            ),

            ///TODO: PENDING
            Text(
              "Note Status",
              style: Theme.of(context)
                  .textTheme
                  .subtitle1!
                  .copyWith(color: Colors.black),
            ),
            SwitchTile(
              private: private,
            ),
            SizedBox(
              height: 20.h,
            ),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 12.w),
                child: MainButton(
                  height: 7.h,
                  buttonText: editAble ? "Update" : "Add Note",
                  radius: 8,
                  width: 59.w,
                  callback: () {
                    if (editAble) {
                      ///CALL NOTE UPDATE API
                      setState(() {
                        readOnly = true;
                      });
                    } else {
                      ///CALL CREATE NOTE API
                    }
                  },
                ))
          ],
        ),
      ),
    );
  }
}

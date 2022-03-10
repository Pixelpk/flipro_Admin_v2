import 'package:fliproadmin/core/utilities/app_colors.dart';
import 'package:fliproadmin/core/utilities/logic_helper.dart';
import 'package:fliproadmin/ui/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'note_item.dart';
import 'note_view_screen.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({Key? key}) : super(key: key);
  static const routeName = '/notesScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blueScaffoldBackground,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(LogicHelper.getCustomAppBarHeight),
        child: const CustomAppBar(
          automaticallyImplyLeading: true,

          bannerText: "Notes",
          showBothIcon: false,
        ),
      ),
      body: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return const NoteItem();
          }),
      floatingActionButton: FloatingActionButton(
          mini: true,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.of(context)
                .pushNamed(NoteViewScreen.routeName, arguments: false);
          }),
    );
  }
}

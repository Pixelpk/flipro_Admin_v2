import 'package:fliproadmin/core/model/generic_model/generic_model.dart';
import 'package:fliproadmin/core/model/note_model/note_model.dart';
import 'package:fliproadmin/core/services/notes_service/notes_service.dart';
import 'package:fliproadmin/core/utilities/app_colors.dart';
import 'package:fliproadmin/core/utilities/app_constant.dart';
import 'package:fliproadmin/core/view_model/user_provider/user_provider.dart';
import 'package:fliproadmin/ui/view/notes_screen/note_view_screen.dart';
import 'package:fliproadmin/ui/widget/getx_dialogs.dart';
import 'package:fliproadmin/ui/widget/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class NoteItem extends StatelessWidget {
  const NoteItem({Key? key, this.note, required this.pagingController})
      : super(key: key);
  final Note? note;
  final PagingController pagingController;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 2.w),
      color: Colors.white,
      height: 9.h,
      width: 90.w,
      child: InkWell(
        onTap: () async {
          ///SETTING EDITABLE TRUE SO WE CAN EDIT THIS NOTE
          note!.isEditAble = true;
          print(note!.toJson());
          final isSucess = await Navigator.of(context)
              .pushNamed(NoteViewScreen.routeName, arguments: note);
          print("is CISSS ${isSucess}");
          if (isSucess != null && isSucess == true) {
            print("sdsf$isSucess");
            pagingController.refresh();
          }
        },
        child: Row(
          children: [
            SvgPicture.asset(
              AppConstant.notesIcon,
              color: AppColors.mainThemeBlue,
              height: 3.3.h,
            ),
            Container(
              width: 1,
              height: 6.5.h,
              color: AppColors.greyFontColor.withOpacity(0.5),
              margin: EdgeInsets.symmetric(
                horizontal: 2.w,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 60.w,
                  child: Text(
                    "${note!.notes}",
                    style: Theme.of(context).textTheme.bodyText1,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text("${note!.timeago}",
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2!
                        .copyWith(color: AppColors.greyFontColor)),
              ],
            ),
            const Spacer(),
            IconButton(
                onPressed: () {
                  UIHelper.deleteDialog("Are you sure to delete this note?",
                      () async {
                    GenericModel genericModel = await NotesService.deleteNote(
                        accessToken:
                            Provider.of<UserProvider>(context, listen: false)
                                .getAuthToken,
                        nodeId: note!.id);
                    if (genericModel.success) {
                      GetXDialog.showDialog(
                          message: genericModel.message,
                          title: genericModel.title);
                      pagingController.refresh();
                      Navigator.of(context).pop();
                    }
                  }, context);
                },
                icon: const Icon(
                  Icons.delete,
                  color: AppColors.mainThemeBlue,
                ))
          ],
        ),
      ),
    );
  }
}

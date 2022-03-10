import 'package:fliproadmin/core/utilities/app_colors.dart';
import 'package:fliproadmin/core/utilities/app_constant.dart';
import 'package:fliproadmin/ui/view/notes_screen/note_view_screen.dart';
import 'package:fliproadmin/ui/widget/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class NoteItem extends StatelessWidget {
  const NoteItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 2.w),
      color: Colors.white,
      height: 9.h,
      width: 90.w,
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(NoteViewScreen.routeName,arguments: true);
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
                    "Note Title hti si ishdi sdkfns kdmn vksdn vvk smdvk mskdvm ksdmvksdmvk msd vksmdvksmdkv smkdvmskdvmskdvmskmdvskjdkjvsdkj",
                    style: Theme.of(context).textTheme.bodyText1,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text("1 week ago",
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2!
                        .copyWith(color: AppColors.greyFontColor)),
              ],
            ),
            const Spacer(),
            IconButton(
                onPressed: () {
                 UIHelper.deleteDialog("Are you sure to delete this note?", () { }, context);
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

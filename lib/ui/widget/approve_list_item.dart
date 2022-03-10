import 'package:fliproadmin/core/utilities/app_colors.dart';
import 'package:fliproadmin/core/utilities/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ApproveListItem extends StatelessWidget {
  const ApproveListItem({
    Key? key,
    this.acceptCallback,this.rejectCallback,this.viewProjectCallback ,this.rejected =true ,
  }) : super(key: key);
  final VoidCallback? viewProjectCallback;
  final VoidCallback? acceptCallback;
  final VoidCallback? rejectCallback;
final bool rejected ;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.w),
      margin: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.w),
      child: Row(
        children: [
          Expanded(
            flex: 50,
            child: InkWell(
              onTap: viewProjectCallback,
              child: Row(
                children: [
                  Expanded(
                      flex: 20,
                      child: Image.asset(AppConstant.defaultProjectImage)),
                  Expanded(
                      flex: 30,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 4, right: 2),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Classify Projects",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(color: AppColors.mainThemeBlue),
                              maxLines: 1,
                            ),
                            Text(
                              "Str 123 , Lahore Pakistan ,Punjan ,South asia , Earth , Milkyway Galaxy tr 123 , Lahore Pakistan ,Punjan ,South asia , Earth , Milkyway Galaxytr 123 , Lahore Pakistan ,Punjan ,South asia , Earth , Milkyway Galaxy ",
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(color: AppColors.greyDark),
                              maxLines: 3,
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            ),
          ),
          Expanded(
              flex: rejected ? 15: 20,
              child: Column(
                children: [
                  rejected ? Text("Rejected",style: Theme.of(context).textTheme.subtitle2!.copyWith(color: AppColors.lightRed),) : Row(
                    children: [
                      IconButton(
                          onPressed: acceptCallback,
                          icon: Column(
                            children: const [
                              Icon(
                                Icons.check_circle,
                                color: AppColors.green,
                              ),
                              Text("Accept", style: TextStyle(fontSize: 8))
                            ],
                          )),
                      IconButton(
                          onPressed: rejectCallback,
                          icon: Column(
                            children: const [
                              Icon(
                                Icons.cancel,
                                color: AppColors.lightRed,
                              ),
                              Text("Reject", style: TextStyle(fontSize: 8))
                            ],
                          ))
                    ],
                  )
                ],
              ))
        ],
      ),
    );
  }
}

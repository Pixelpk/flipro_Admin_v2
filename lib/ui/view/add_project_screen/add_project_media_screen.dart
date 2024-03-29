import 'dart:io';

import 'package:fliproadmin/core/model/project_response/project_response.dart';
import 'package:fliproadmin/core/services/assets_provider/assets_provider.dart';
import 'package:fliproadmin/core/utilities/app_colors.dart';
import 'package:fliproadmin/core/utilities/logic_helper.dart';
import 'package:fliproadmin/core/view_model/auth_provider/auth_provider.dart';
import 'package:fliproadmin/core/view_model/projects_provider/projects_provider.dart';
import 'package:fliproadmin/ui/view/media_player/file_media_player.dart';
import 'package:fliproadmin/ui/widget/custom_app_bar.dart';
import 'package:fliproadmin/ui/widget/getx_dialogs.dart';
import 'package:fliproadmin/ui/widget/labeledTextField.dart';
import 'package:fliproadmin/ui/widget/main_button.dart';
import 'package:fliproadmin/ui/widget/media_picker_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

  import '../../../core/helper/number_formatter.dart';

class AddProjectMediaScreen extends StatefulWidget {
  const AddProjectMediaScreen({Key? key}) : super(key: key);
  static const routeName = '/AddProjectMediaScreen';

  @override
  State<AddProjectMediaScreen> createState() => _AddProjectMediaScreenState();
}

class _AddProjectMediaScreenState extends State<AddProjectMediaScreen> {
  late Project project;
  bool isNewProject = true;
  TextEditingController? areaController;

  // TextEditingController? titleController;
  TextEditingController? anticipatedBudgetController;
  TextEditingController? projectAddressController;
  TextEditingController? subStateController;
  TextEditingController? description;
  bool existingQuriesYes = true;
  bool existingQueriesNo = false;
  bool crossCollaterizedYes = false;
  bool crossCollaterizedNo = false;
  String crossCollaterized = "";

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    Future.microtask(() => initControllers());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(LogicHelper.getCustomAppBarHeight),
        child: const CustomAppBar(
            automaticallyImplyLeading: true,
            bannerText: "Add Project",
            showBothIcon: false,
            showNoteIcon: false,
            showShareIcon: false),
      ),
      body: ListView(children: [
        SizedBox(
            width: 90.w,
            child: Form(
                key: _formKey,
                child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                  Container(
                      margin: EdgeInsets.symmetric(vertical: 2.h, horizontal: 5.w),
                      child:
                          Row(children: [Text("Project Information", style: Theme.of(context).textTheme.bodyText1)])),
                  LabeledTextField(
                    label: "",
                    maxLines: null,
                    hintText: "Project Address ",
                    readonly: false,
                    keyboardType: TextInputType.text,
                    textEditingController: projectAddressController,
                    validation: (e) {
                      if (e == null || e.isEmpty) {
                        return "Please add project Address";
                      } else {
                        return null;
                      }
                    },
                  ),
                  LabeledTextField(
                    label: "",
                    maxLines: null,
                    hintText: "Area (Square Metre)",
                    readonly: false,
                    textEditingController: areaController,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    onChange: (input) {
                      if (input.isNotEmpty) {
                        String string = formatter.format(double.parse(input.replaceAll(",", "")));
                        areaController?.value = TextEditingValue(
                          text: string,
                          selection: TextSelection.collapsed(offset: string.length),
                        );
                      }
                    },
                    validation: (e) {
                      if (e == null || e.isEmpty) {
                        areaController?.text = "0";
                        return null;
                      } else {
                        return null;
                      }
                    },
                  ),
                  LabeledTextField(
                    prefixText: "\$",
                    height: 18,
                    width: 18,
                    label: "",
                    maxLines: 1,
                    hintText: 'Anticipated Budget',
                    readonly: false,
                    textEditingController: anticipatedBudgetController,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    onChange: (input) {
                      if (input.isNotEmpty) {
                        String string = formatter.format(double.parse(input.replaceAll(",", "")));
                        anticipatedBudgetController?.value = TextEditingValue(
                          text: string,
                          selection: TextSelection.collapsed(offset: string.length),
                        );
                      }
                    },
                    validation: (e) {
                      if (e == null || e.isEmpty) {
                        anticipatedBudgetController?.text = "0";
                        return null;
                      } else {
                        return null;
                      }
                    },
                  ),
                  // LabeledTextField(
                  //   label: "",
                  //   maxLines: 1,
                  //   hintText: 'Project title',
                  //   readonly: false,
                  //   textEditingController: projectAddressController,
                  //   keyboardType: TextInputType.streetAddress,
                  //   validation: (e) {
                  //     if (e == null || e.isEmpty) {
                  //       return "Please add project title";
                  //     } else {
                  //       return null;
                  //     }
                  //   },
                  // ),
                  LabeledTextField(
                    label: "",
                    maxLines: 1,
                    hintText: 'Suburb, State and Postcode',
                    readonly: false,
                    textEditingController: subStateController,
                    validation: (e) {
                      if (e == null || e.isEmpty) {
                        return "Please Suburb,State and Postcode";
                      } else {
                        return null;
                      }
                    },
                  ),
                  Container(
                    margin: const EdgeInsets.all(8),
                    width: 90.w,
                    height: 8.h,
                    padding: EdgeInsets.symmetric(horizontal: 3.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Row(
                      children: [
                        Text(
                          "Existing Queries",
                          style: Theme.of(context).textTheme.subtitle1!.copyWith(color: AppColors.greyFontColor),
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            Checkbox(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(60)),
                                value: existingQuriesYes,
                                onChanged: (c) {
                                  setState(() {
                                    existingQuriesYes = c!;
                                    existingQueriesNo = false;
                                  });
                                }),
                            Text(
                              "YES",
                              style: Theme.of(context).textTheme.subtitle1!.copyWith(color: AppColors.greyFontColor),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(60)),
                                value: existingQueriesNo,
                                onChanged: (c) {
                                  setState(() {
                                    existingQuriesYes = false;
                                    existingQueriesNo = c!;
                                  });
                                }),
                            Text(
                              "NO",
                              style: Theme.of(context).textTheme.subtitle1!.copyWith(color: AppColors.greyFontColor),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  LabeledTextField(
                    label: "",
                    maxLines: 6,
                    readonly: false,
                    hintText: "Description",
                    textEditingController: description,
                    keyboardType: TextInputType.multiline,
                    validation: (e) {
                      if (e == null || e.isEmpty) {
                        return "Please add project description";
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  SizedBox(width: 94.w, child: const MediaPickedTile()),
                  const PickedImagesGrid(),
                  const VideoGridView(),
                  SizedBox(height: 5.h),
                  Consumer<ProjectsProvider>(builder: (ctx, pProvider, c) {
                    return MainButton(
                        height: 7.h,
                        isloading: pProvider.getLoadingState == LoadingState.loading,
                        callback: () {
                          if (isNewProject) {
                            createProject();
                          }
                          if (!isNewProject) {
                            updateProjectProject();
                          }
                        },
                        buttonText: "Submit Project",
                        width: 60.w);
                  }),
                  SizedBox(height: 5.h)
                ])))
      ]),
    );
  }

  initControllers() {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    final _passedProject = args['project'];
    project = _passedProject;

    if (_passedProject.area != null &&
        _passedProject.anticipatedBudget != null &&
        _passedProject.projectAddress != null &&
        _passedProject.contractorSupplierDetails != null &&
        _passedProject.projectState != null &&
        _passedProject.description != null) {
      if (project.crossCollaterized == 0) {
        crossCollaterizedYes = false;
        crossCollaterizedNo = true;
      }
      if (project.crossCollaterized == 1) {
        crossCollaterizedYes = true;
        crossCollaterizedNo = false;
      }
      areaController = TextEditingController(text: project.area!.trim());
      anticipatedBudgetController = TextEditingController(
        text: formatter.format(
          double.parse(
            project.propertyDebt!.toString().replaceAll(",", ""),
          ),
        ),
      );
      // titleController = TextEditingController(text: project.projectAddress!);
      projectAddressController = TextEditingController(text: project.title!);
      subStateController = TextEditingController(text: project.projectState!);
      description = TextEditingController(text: project.description.toString());
      if (project.contractorSupplierDetails == "1") {
        existingQuriesYes = true;
        existingQueriesNo = false;
      }
      if (project.contractorSupplierDetails == "0") {
        existingQuriesYes = false;
        existingQueriesNo = true;
      }
    } else {
      // titleController = TextEditingController();
      areaController = TextEditingController(text: "0");
      anticipatedBudgetController = TextEditingController(text: "0");
      projectAddressController = TextEditingController();
      subStateController = TextEditingController();
      existingQuriesYes ? 1 : 0;
      description = TextEditingController();
      // Provider.of<AssetProvider>(context,listen: ).clearAllMedia();
    }
    isNewProject = args['newProject'];
    setState(() {});
  }

  createProject() async {
    if (Provider.of<AssetProvider>(context, listen: false).getPickedImages.isEmpty) {
      GetXDialog.showDialog(title: "Project Images", message: "Please add project images");
    }
    if (_formKey.currentState!.validate() &&
        Provider.of<AssetProvider>(context, listen: false).getPickedImages.isNotEmpty) {
      project.title = projectAddressController!.text.trim();
      project.area = areaController!.text.trim();
      project.anticipatedBudget = int.tryParse(anticipatedBudgetController!.text.replaceAll(",", ""));
      project.projectAddress = projectAddressController!.text.trim();
      project.projectState = subStateController!.text.trim();
      project.contractorSupplierDetails = existingQuriesYes ? '1' : '0';
      project.description = description!.text.trim();

      bool isSuccess = await Provider.of<ProjectsProvider>(context, listen: false).addProject(
          project: project,
          images: Provider.of<AssetProvider>(context, listen: false).getPickedImages,
          media: Provider.of<AssetProvider>(context, listen: false).getCompressedVidoesWithThumbnail);

      if (isSuccess) {
        Provider.of<AssetProvider>(context, listen: false).clearAllMedia();
      }
    }
  }

  updateProjectProject() async {
    if (_formKey.currentState!.validate()) {
      project.title = projectAddressController!.text.trim();
      project.area = areaController!.text;
      project.anticipatedBudget = int.tryParse(anticipatedBudgetController!.text.replaceAll(",", ""));
      project.projectAddress = projectAddressController!.text.trim();
      project.projectState = subStateController!.text.trim();
      project.contractorSupplierDetails = existingQuriesYes ? '1' : '0';
      project.description = description!.text;

      bool isSuccess = await Provider.of<ProjectsProvider>(context, listen: false).updateProject(
          project: project,
          images: Provider.of<AssetProvider>(context, listen: false).getPickedImages,
          media: Provider.of<AssetProvider>(context, listen: false).getCompressedVidoesWithThumbnail);

      if (isSuccess) {
        Provider.of<AssetProvider>(context, listen: false).clearAllMedia();
      }
    }
  }
}

class PickedImagesGrid extends StatelessWidget {
  const PickedImagesGrid({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final assetProvider = Provider.of<AssetProvider>(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            assetProvider.getPickedImages.isNotEmpty
                ? Padding(
                    padding: EdgeInsets.only(left: 5.w, top: 5.w),
                    child: Text("Picked Images",
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(color: AppColors.mainThemeBlue)),
                  )
                : Container()
          ],
        ),
        Wrap(
            crossAxisAlignment: WrapCrossAlignment.end,
            children: assetProvider.getPickedImages.map((e) {
              return Padding(
                padding: const EdgeInsets.all(4.0),
                child: InkWell(
                  onTap: () {
                    assetProvider.removedImage(e);
                    /*  print("the total images are" +  assetProvider.getPickedImages.length.toString());*/
                  },
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Stack(alignment: Alignment.topRight, children: [
                        Image.file(e, height: 16.h, width: 25.w, fit: BoxFit.cover),
                        Positioned(
                            top: 1.h,
                            right: 1.h,
                            child: const CircleAvatar(
                                radius: 10,
                                backgroundColor: Colors.red,
                                child: Center(child: Icon(Icons.remove, color: Colors.white, size: 16))))
                      ])),
                ),
              );
            }).toList()),
      ],
    );
  }
}

class VideoGridView extends StatelessWidget {
  const VideoGridView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final assetProvider = Provider.of<AssetProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            assetProvider.getCompressedVidoesWithThumbnail.isNotEmpty
                ? Padding(
                    padding: EdgeInsets.only(left: 5.w, top: 5.w),
                    child: Text("Picked Videos",
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(color: AppColors.mainThemeBlue)))
                : Container()
          ],
        ),
        Wrap(
            crossAxisAlignment: WrapCrossAlignment.end,
            children: assetProvider.getCompressedVidoesWithThumbnail.map((e) {
              return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => FileMediaPlayer(video: File(e.compressedVideoPath))));
                      },
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Stack(alignment: Alignment.center, children: [
                            Image.file(File(e.thumbnailPath), height: 16.h, width: 25.w, fit: BoxFit.cover),
                            Positioned(
                                top: 1.h,
                                right: 1.h,
                                child: InkWell(
                                    onTap: () {
                                      assetProvider.removedVideo(e);
                                    },
                                    child: const CircleAvatar(
                                        radius: 10,
                                        backgroundColor: Colors.red,
                                        child: Center(child: Icon(Icons.remove, color: Colors.white, size: 16))))),
                            const Icon(Icons.play_circle_filled_outlined, color: AppColors.mainThemeBlue)
                          ]))));
            }).toList()),
      ],
    );
  }
}

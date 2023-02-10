import 'package:fliproadmin/core/model/generic_model/generic_model.dart';
import 'package:fliproadmin/core/model/note_model/note_model.dart';
import 'package:fliproadmin/core/services/notes_service/notes_service.dart';
import 'package:fliproadmin/core/utilities/app_constant.dart';
import 'package:fliproadmin/core/utilities/logic_helper.dart';
import 'package:fliproadmin/core/view_model/user_provider/user_provider.dart';
import 'package:fliproadmin/ui/widget/SwitchTile.dart';
import 'package:fliproadmin/ui/widget/custom_app_bar.dart';
import 'package:fliproadmin/ui/widget/getx_dialogs.dart';
import 'package:fliproadmin/ui/widget/labeledTextField.dart';
import 'package:fliproadmin/ui/widget/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class NoteViewScreen extends StatefulWidget {
  NoteViewScreen({Key? key}) : super(key: key);
  static const routeName = '/noteViewScreen';

  @override
  State<NoteViewScreen> createState() => _NoteViewScreenState();
}

class _NoteViewScreenState extends State<NoteViewScreen> {
  final TextEditingController notesController = TextEditingController();
  late FocusNode notesFocusNode;
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  Note? note;
  bool private = false;
  bool readOnly = true;
  bool isNewNote = true;

  @override
  void initState() {
    notesFocusNode = FocusNode();

    Future.microtask(() {
      setState(() {
        note = ModalRoute.of(context)!.settings.arguments as Note;
        if (note!.id == null) {
          readOnly = false;
        }
        if (note!.notes != null) {
          notesController.text = note!.notes!;
          isNewNote = false;
        }
        print(note!.toJson());
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    notesFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(LogicHelper.getCustomAppBarHeight),
        child: CustomAppBar(
            automaticallyImplyLeading: true,
            bannerText: note?.id == null
                ? "Add Note"
                : !readOnly
                    ? "Edit Note"
                    : "View Note",
            showBothIcon: true,
            showNoteIcon:
                note == null || note!.userId != Provider.of<UserProvider>(context, listen: false).getCurrentUser.id
                    ? false
                    : note!.isEditAble!,
            customWidget: InkWell(
                onTap: () {
                  setState(() {
                    readOnly = false;
                  });
                  notesFocusNode.requestFocus();
                },
                child: SvgPicture.asset(AppConstant.editIcon, height: 20))),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 5.w),
        child: ListView(
          children: [
            SizedBox(
              height: 3.h,
            ),
            Form(
              key: _formKey,
              child: LabeledTextField(
                label: "Note",
                keyboardType: TextInputType.multiline,
                validation: (e) {
                  if (e == null || e.trim().isEmpty) {
                    return "Please write note";
                  } else {
                    return null;
                  }
                },
                labelStyle: Theme.of(context).textTheme.subtitle1!.copyWith(color: Colors.black),
                maxlines: 10,
                hintText: notesController.text,
                focusNode: notesFocusNode,
                textEditingController: notesController,
                readonly: readOnly,
              ),
            ),
            SizedBox(
              height: 3.h,
            ),

            ///TODO: PENDING
            if (note == null || note!.userId != Provider.of<UserProvider>(context, listen: false).getCurrentUser.id
                ? false
                : note!.isEditAble!)
              Text(
                "Note Status",
                style: Theme.of(context).textTheme.subtitle1!.copyWith(color: Colors.black),
              ),
            if (note == null || note!.userId != Provider.of<UserProvider>(context, listen: false).getCurrentUser.id
                ? false
                : note!.isEditAble!)
              SwitchTile(
                private: note == null ? false : note!.private!,
                callback: (c) {
                  setState(() {
                    note!.private = c;
                  });
                },
                tileTitle: 'Private',
              ),
            if (isNewNote)
              SwitchTile(
                private: note == null ? false : note!.private!,
                callback: (c) {
                  setState(() {
                    note!.private = c;
                  });
                },
                tileTitle: 'Private',
              ),
            SizedBox(
              height: 20.h,
            ),
            if (note == null || note!.userId != Provider.of<UserProvider>(context, listen: false).getCurrentUser.id
                ? false
                : note!.isEditAble!)
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 12.w),
                  child: MainButton(
                    height: 7.h,
                    isloading: isLoading,
                    buttonText: note == null
                        ? ''
                        : note!.isEditAble!
                            ? "Update"
                            : "Add Note",
                    radius: 8,
                    width: 59.w,
                    callback: () async {
                      if (_formKey.currentState!.validate()) {
                        GenericModel genericModel;
                        note!.notes = notesController.text.trim();
                        setState(() {
                          isLoading = true;
                        });
                        if (note!.isEditAble!) {
                          genericModel = await NotesService.updateNote(
                              accessToken: Provider.of<UserProvider>(context, listen: false).getAuthToken, note: note);
                        } else {
                          ///CALL CREATE NOTE API

                          genericModel = await NotesService.createNote(
                              accessToken: Provider.of<UserProvider>(context, listen: false).getAuthToken, note: note);
                        }
                        GetXDialog.showDialog(message: genericModel.message, title: genericModel.title);
                        setState(() {
                          isLoading = false;
                        });
                        if (genericModel.success) {
                          print("adjcsc d");
                          Navigator.pop(context, true);
                        }
                      }
                    },
                  )),
            if (isNewNote)
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 12.w),
                  child: MainButton(
                    height: 7.h,
                    isloading: isLoading,
                    buttonText: note == null
                        ? ''
                        : note!.isEditAble!
                            ? "Update"
                            : "Add Note",
                    radius: 8,
                    width: 59.w,
                    callback: () async {
                      if (_formKey.currentState!.validate()) {
                        GenericModel genericModel;
                        note!.notes = notesController.text.trim();
                        setState(() {
                          isLoading = true;
                        });
                        if (note!.isEditAble!) {
                          genericModel = await NotesService.updateNote(
                              accessToken: Provider.of<UserProvider>(context, listen: false).getAuthToken, note: note);
                        } else {
                          ///CALL CREATE NOTE API

                          genericModel = await NotesService.createNote(
                              accessToken: Provider.of<UserProvider>(context, listen: false).getAuthToken, note: note);
                        }
                        GetXDialog.showDialog(message: genericModel.message, title: genericModel.title);
                        setState(() {
                          isLoading = false;
                        });
                        if (genericModel.success) {
                          print("adjcsc d");
                          Navigator.pop(context, true);
                        }
                      }
                    },
                  )),
          ],
        ),
      ),
    );
  }
}

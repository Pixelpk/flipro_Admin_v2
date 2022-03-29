import 'package:fliproadmin/core/model/generic_model/generic_model.dart';
import 'package:fliproadmin/core/model/note_model/note_model.dart';
import 'package:fliproadmin/core/services/notes_service/notes_service.dart';
import 'package:fliproadmin/core/utilities/app_colors.dart';
import 'package:fliproadmin/core/utilities/logic_helper.dart';
import 'package:fliproadmin/core/view_model/loaded_project/loaded_project.dart';
import 'package:fliproadmin/core/view_model/user_provider/user_provider.dart';
import 'package:fliproadmin/ui/widget/custom_app_bar.dart';
import 'package:fliproadmin/ui/widget/getx_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'note_item.dart';
import 'note_view_screen.dart';

class NotesScreen extends StatefulWidget {
  NotesScreen({Key? key}) : super(key: key);
  static const routeName = '/notesScreen';


  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
   final _pageSize = 20;
  final PagingController<int, Note> _pagingController =
      PagingController(firstPageKey: 1);

  Future<void> _fetchPage(int pageKey) async {
    try {
      GenericModel genericModel = await NotesService.getAllPrjectNotes(
          accessToken:
              Provider.of<UserProvider>(context, listen: false).getAuthToken,
          page: pageKey,
          projectId: Provider.of<LoadedProjectProvider>(context, listen: false)
              .getLoadedProject!
              .id);
      if (genericModel.statusCode == 200) {
        NotesResponse notesResponse = genericModel.returnedModel;
        if (notesResponse != null &&
            notesResponse.data != null &&
            notesResponse.data!.notes != null) {
          final newItems = notesResponse.data!.notes ?? [];
          final isLastPage = newItems.length < _pageSize;
          if (isLastPage) {
            _pagingController.appendLastPage(newItems);
          } else {
            final nextPageKey = pageKey + 1;
            _pagingController.appendPage(newItems, nextPageKey);
          }
        }
      } else if (genericModel.statusCode == 400 ||
          genericModel.statusCode == 422 ||
          genericModel.statusCode == 401) {
        GetXDialog.showDialog(
            title: genericModel.title, message: genericModel.message);
      }
    } catch (error) {
      print(error);
      _pagingController.error = error;
    }
  }

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

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
      body: RefreshIndicator(
        onRefresh: () => Future.sync(
          () => _pagingController.refresh(),
        ),
        child: PagedListView<int, Note>(
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<Note>(
              itemBuilder: (context, note, index) => NoteItem(
                pagingController: _pagingController,
                    key: ValueKey(note.notes),
                    note: note,
                  )),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          mini: true,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: const Icon(Icons.add),
          onPressed: () async {
            ///create new note ,not edit able initially
            final isSucess = await   Navigator.of(context).pushNamed(NoteViewScreen.routeName,
                arguments: Note(
                    isEditAble: false,
                    projectId: Provider.of<LoadedProjectProvider>(context,
                            listen: false)
                        .getLoadedProject!
                        .id));
            if (isSucess != null && isSucess == true) {
              print("sdsf$isSucess");
              _pagingController.refresh();
            }



          }),
    );
  }
}

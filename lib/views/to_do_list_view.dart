import 'package:build_todo/configs/conts.dart';
import 'package:build_todo/configs/theme.dart';
import 'package:build_todo/utils/text_style_util.dart';
import 'package:build_todo/views/to_do_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ToDoListPage extends StatefulWidget {
  const ToDoListPage({Key key, @required this.title}) : super(key: key);

  final String title;

  @override
  State<ToDoListPage> createState() => _ToDoListPageState();
}

class _ToDoListPageState extends State<ToDoListPage> {
  /// Declare
  bool isLoading = false;
  List todoList = [];

  /// Get data from firebase service. Massage data with document id.
  void _getToDoListDataProcess() async {
    List array = [];
    var index = 0;

    var collection = Const.FirestoreInstance.collection(Const.CollectionName);
    var querySnapshots = await collection.get();
    for (var snapshot in querySnapshots.docs) {
      var documentID = snapshot.id; // <-- Document ID
      array.add({'uid': documentID, 'data': querySnapshots.docs[index].data()});
      index++;
    }

    if (!_areListsEqual(todoList, array)) {
      setState(() {
        todoList = array;
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  /// Update data to firebase service.
  void _updateDataService({@required String collection, @required String uid, @required var json}) {
    Const.FirestoreInstance.collection(collection).doc(uid).update(json).then((value) {
      debugPrint('Data updated successfully');
    });
  }

  /// Tick or untick status update process.
  Future<void> _tickStatusUpdateProcess({@required int index, @required bool value}) async {
    setState(() {
      isLoading = true;
    });
    _showLoadingDialog(action: 'open', isLoading: isLoading);
    todoList[index]['data']['status'] = value;
    _updateDataService(collection: Const.CollectionName, uid: todoList[index]['uid'], json: todoList[index]['data']);
    await _getToDoListDataProcess();
    _showLoadingDialog(action: 'close', isLoading: isLoading);
    _showUpdateDialog(message: Const.Msg_Update_Success);
  }

  /// Compare 2 list is equal or not.
  bool _areListsEqual(List list1, List list2) {
    // If list1.length = 0.
    if ((list1.length == 0 && list2.length > 0) || (list2.length == 0 && list1.length > 0) || (list1.length > 0 && list2.length > 0 && list1.length != list2.length)) {
      return false;
    } else {
      // check if elements are equal
      for (int i = 0; i < list1.length; i++) {
        if (list1[i] != list2[i]) {
          return false;
        }
      }
    }

    return true;
  }

  /// Calculate the time between 2 datetime.
  static String _calculateTimeDifferenceBetween({@required DateTime startDate, @required DateTime endDate}) {
    int days = endDate.difference(startDate).inDays.abs();
    int hours = endDate.difference(startDate).inHours.abs() % 24;
    int minutes = endDate.difference(startDate).inMinutes.abs() % 60;

    var value = '';

    if (days > 0) {
      value = '$days days';
    }
    if (hours > 0 || (hours == 0 && minutes > 0)) {
      value += (value != '') ? ' $hours hrs' : '$hours hrs';
    }
    if (minutes > 0) {
      value += (value != '') ? ' $minutes min' : '$minutes min';
    }
    return value;
  }

  /// Show loading dialog.
  Future<void> _showLoadingDialog({@required String action, @required bool isLoading}) async {
    if (action == 'open') {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.transparent,
            // title: const Text('AlertDialog Title'),
            content: Center(
              child: Opacity(
                opacity: isLoading ? 1.0 : 0,
                child: CircularProgressIndicator(),
              ),
            ),
          );
        },
      );
    } else {
      Navigator.of(context).pop();
    }
  }

  /// Show message dialog.
  Future<void> _showUpdateDialog({@required message}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          alignment: Alignment.center,
          title: Text('${message}', textAlign: TextAlign.center, style: TextStyleUtil.dialogTitle()),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getToDoListDataProcess();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(widget.title, style: TextStyle(color: COLOR_BLACK)),
          backgroundColor: COLOR_MAIN_DEFAULT,
        ),
        body: Container(
          color: COLOR_BG_DEFAULT,
          child: RefreshIndicator(
            onRefresh: () async {
              await _getToDoListDataProcess();
            },
            child: Stack(children: <Widget>[
              (todoList.length > 0)
                  ? Container(
                      margin: const EdgeInsets.all(0.0),
                      child: ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 2.0),
                          itemCount: todoList.length,
                          itemBuilder: (BuildContext context, int index) {
                            var selectedObj = todoList[index];
                            var data = selectedObj['data'];

                            final startDateStr =
                                DateFormat('dd MMM yyyy').format(DateTime.fromMillisecondsSinceEpoch(num.parse(data['startDate'].toString().substring(0, 10)) * 1000)).toString();
                            final endDateStr =
                                DateFormat('dd MMM yyyy').format(DateTime.fromMillisecondsSinceEpoch(num.parse(data['endDate'].toString().substring(0, 10)) * 1000)).toString();

                            final endDate = DateTime.fromMillisecondsSinceEpoch(num.parse(data['endDate'].toString().substring(0, 10)) * 1000);
                            final currentTime = DateTime.now();
                            final leftTime = _calculateTimeDifferenceBetween(startDate: endDate, endDate: currentTime);
                            final status = (data['status'] == true) ? Const.Label_Status_Completed : Const.Label_Status_Incomplete;
                            return Center(
                              child: Container(
                                margin: EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
                                padding: EdgeInsets.zero,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: COLOR_WHITE,
                                  boxShadow: [
                                    BoxShadow(color: Colors.grey, offset: Offset(0.0, 1.0), blurRadius: 13.0),
                                  ],
                                ),
                                child: SizedBox(
                                  child: ListTile(
                                    minVerticalPadding: 0,
                                    contentPadding: EdgeInsets.zero,
                                    title: InkWell(
                                      onTap: () {
                                        // Edit process and navigate to detail.
                                        Navigator.of(context)
                                            .push(new MaterialPageRoute(builder: (context) => ToDoDetailPage(title: 'Edit To-Do List', action: 'edit', data: selectedObj)))
                                            .whenComplete(_getToDoListDataProcess);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 10.0, right: 10.0),
                                        child: Text('${data['name']}', style: TextStyleUtil.dialogTitle()),
                                      ),
                                    ),
                                    subtitle: Column(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            // Edit process and navigate to detail.
                                            Navigator.of(context)
                                                .push(new MaterialPageRoute(builder: (context) => ToDoDetailPage(title: 'Edit To-Do List', action: 'edit', data: selectedObj)))
                                                .whenComplete(_getToDoListDataProcess);
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(bottom: 15.0, left: 10.0, right: 10.0),
                                            child: Row(
                                              children: <Widget>[
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: <Widget>[
                                                      Text(Const.Label_Start_Date, style: TextStyleUtil.listTitle(fontWeight: FONT_300)),
                                                      Text(startDateStr, style: TextStyleUtil.listTitle()),
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: <Widget>[
                                                      Text(Const.Label_End_Date, style: TextStyleUtil.listTitle(fontWeight: FONT_300)),
                                                      Text(endDateStr, style: TextStyleUtil.listTitle()),
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: <Widget>[
                                                      Text(Const.Label_Time_Left, style: TextStyleUtil.listTitle(fontWeight: FONT_300)),
                                                      Text(leftTime, style: TextStyleUtil.listTitle()),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Color(0XFFE7E3D0),
                                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10.0), bottomRight: Radius.circular(10.0)),
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: <Widget>[
                                                  Container(
                                                    margin: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 10.0),
                                                    child: Wrap(children: <Widget>[
                                                      Text(Const.Label_Status, style: TextStyleUtil.listTitle(fontWeight: FONT_300)),
                                                      SizedBox(width: 5),
                                                      Text('${status}', style: TextStyleUtil.listTitle()),
                                                    ]),
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(top: 5.0, bottom: 5.0, right: 10.0),
                                                child: Wrap(
                                                  crossAxisAlignment: WrapCrossAlignment.center,
                                                  children: <Widget>[
                                                    Container(
                                                      margin: const EdgeInsets.only(top: 0.0),
                                                      child: Text(Const.Label_Tick_Completed, style: TextStyleUtil.listTitle(fontWeight: FONT_300)),
                                                    ),
                                                    // SizedBox(width: 5),
                                                    SizedBox(
                                                      height: 24.0,
                                                      width: 24.0,
                                                      child: Checkbox(
                                                        checkColor: Colors.white,
                                                        fillColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                                                          if (states.contains(MaterialState.disabled)) {
                                                            return Color(0XFFFFBE23).withOpacity(.32);
                                                          }
                                                          return Color(0XFFFFBE23);
                                                        }),
                                                        value: data['status'],
                                                        onChanged: (bool value) async {
                                                          await _tickStatusUpdateProcess(index: index, value: value);
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                    )
                  : Center(
                      child: Text(Const.Msg_ToDo_Not_Found),
                    ),
            ]),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          foregroundColor: COLOR_WHITE,
          backgroundColor: Color(0XFFF55824),
          onPressed: () {
            // Create process and navigate to detail.
            Navigator.of(context)
                .push(new MaterialPageRoute(builder: (context) => ToDoDetailPage(title: Const.Label_Add_New_To_Do_List, action: 'create', data: {})))
                .whenComplete(_getToDoListDataProcess);
          },
          child: const Icon(Icons.add),
        ), // This trailing comma makes auto-formatting nicer for build methods.
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}

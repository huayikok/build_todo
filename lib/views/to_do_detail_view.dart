import 'package:build_todo/configs/conts.dart';
import 'package:build_todo/configs/theme.dart';
import 'package:build_todo/utils/text_style_util.dart';
import 'package:build_todo/widgets/TopLabelInput.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ToDoDetailPage extends StatefulWidget {
  // action = 'create' / 'edit' process.
  const ToDoDetailPage({Key key, @required this.title, @required this.action, @required this.data}) : super(key: key);

  final String title;
  final String action;
  final data;

  @override
  State<ToDoDetailPage> createState() => _ToDoDetailPageState();
}

class _ToDoDetailPageState extends State<ToDoDetailPage> {
  bool isLoading = false;
  List todoList = [];
  var todoDetail = {};
  bool isDisabled = true;
  int year = DateTime.now().year;
  DateTime startDate, endDate; //, selectedStartDate = DateTime.now(), selectedEndDate = DateTime.now();

  TextEditingController titleFieldController = TextEditingController();
  TextEditingController startDateFieldController = TextEditingController();
  TextEditingController endDateFieldController = TextEditingController();

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

  /// Create new data to firebase service.
  void _addDataService({@required json}) {
    Const.FirestoreInstance.collection(Const.CollectionName).add(json).then((value) {
      debugPrint('Data added successfully');
    });
  }

  /// Update data to firebase service.
  void _updateDataService({@required String collection, @required String uid, @required var json}) {
    Const.FirestoreInstance.collection(collection).doc(uid).update(json).then((value) {
      debugPrint('Data updated successfully');
    });
  }

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

  _selectDate(BuildContext context, TextEditingController dateTimeFieldController, DateTime selectedDate, DateTime dateTime) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1970),
      lastDate: DateTime(year + 2),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dateTime = selectedDate;
        dateTimeFieldController.text = DateFormat('yyyy-MM-dd').format(picked).toString();
      });
    }
  }

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

    if (widget.action == Const.Label_Process_Edit) {
      titleFieldController.text = widget.data['data']['name'];
      String startDateStr =
          DateFormat('yyyy-MM-dd').format(DateTime.fromMillisecondsSinceEpoch(num.parse(widget.data['data']['startDate'].toString().substring(0, 10)) * 1000)).toString();
      String endDateStr =
          DateFormat('yyyy-MM-dd').format(DateTime.fromMillisecondsSinceEpoch(num.parse(widget.data['data']['endDate'].toString().substring(0, 10)) * 1000)).toString();
      startDateFieldController.text = startDateStr;
      endDateFieldController.text = endDateStr;
    }
    setState(() {
      todoDetail = widget.data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: COLOR_WHITE,
        appBar: AppBar(title: Text(widget.title, style: TextStyle(color: COLOR_BLACK)), backgroundColor: COLOR_MAIN_DEFAULT),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 15.0),
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 15.0),
              child: Column(children: <Widget>[
                TopLabelInput(
                  height: 100,
                  margin: EdgeInsets.only(top: 30, bottom: 0),
                  inputName: Const.Label_To_Do_Title,
                  hintText: Const.Msg_Placeholder_Title,
                  // isPassword. True = Password Input, False = Normal Input
                  isPassword: false,
                  // isEnabled. True = Enabled, False = Disabled
                  isEnabled: isDisabled,
                  controller: titleFieldController,
                  minLines: 6,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  onChanged: (value) {},
                ),
                Stack(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 10.0),
                      child: TopLabelInput(
                        margin: EdgeInsets.only(top: 30, bottom: 0),
                        inputName: Const.Label_Start_Date,
                        hintText: Const.Msg_Placeholder_Date,
                        // isPassword. True = Password Input, False = Normal Input
                        isPassword: false,
                        // isEnabled. True = Enabled, False = Disabled
                        isEnabled: isDisabled,
                        controller: startDateFieldController,
                        onChanged: (value) {},
                      ),
                    ),
                    (isDisabled)
                        ? Container(
                            margin: EdgeInsets.only(top: 10.0),
                            // Pick Date Button
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.fromLTRB(40.0, 27.5, 0.0, 0.0),
                            child: IconButton(
                              icon: const Icon(Icons.arrow_drop_down),
                              onPressed: () {
                                // Get current datetime.
                                DateTime selectedStartDate = (widget.action == Const.Label_Process_Edit)
                                    ? DateTime.fromMillisecondsSinceEpoch(num.parse(widget.data['data']['startDate'].toString().substring(0, 10)) * 1000)
                                    : DateTime.now();

                                _selectDate(context, startDateFieldController, selectedStartDate, startDate);
                              },
                            ),
                          )
                        : Container(),
                  ],
                ),
                Stack(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 10.0),
                      child: TopLabelInput(
                        margin: EdgeInsets.only(top: 30, bottom: 0),
                        inputName: Const.Label_Estimate_End_Date,
                        hintText: Const.Msg_Placeholder_Date,
                        // isPassword. True = Password Input, False = Normal Input
                        isPassword: false,
                        // isEnabled. True = Enabled, False = Disabled
                        isEnabled: isDisabled,
                        controller: endDateFieldController,
                        onChanged: (value) {},
                      ),
                    ),
                    (isDisabled)
                        ? Container(
                            margin: EdgeInsets.only(top: 10.0),
                            // Pick Date Button
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.fromLTRB(40.0, 27.5, 0.0, 0.0),
                            child: IconButton(
                              icon: const Icon(Icons.arrow_drop_down),
                              onPressed: () {
                                // Get current datetime.
                                DateTime selectedEndDate = (widget.action == Const.Label_Process_Edit)
                                    ? DateTime.fromMillisecondsSinceEpoch(num.parse(widget.data['data']['endDate'].toString().substring(0, 10)) * 1000)
                                    : DateTime.now();

                                _selectDate(context, endDateFieldController, selectedEndDate, endDate);
                              },
                            ),
                          )
                        : Container(),
                  ],
                ),
              ]),
            ),
          ),
        ),
        bottomNavigationBar: Container(
          color: COLOR_TEXT_DEFAULT,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.0),
            child: ElevatedButton(
              onPressed: () async {
                if (titleFieldController.text == '' || startDateFieldController.text == '' || endDateFieldController.text == '') {
                  _showUpdateDialog(message: Const.Msg_Fill_In_Completely);
                } else {
                  var startDateMillisecond = DateTime.parse("${startDateFieldController.text} 00:00:00").millisecondsSinceEpoch;
                  var endDateMillisecond = DateTime.parse("${endDateFieldController.text} 23:59:59").millisecondsSinceEpoch;

                  if (startDateMillisecond > endDateMillisecond) {
                    // Compare startDate and endDate.
                    _showUpdateDialog(message: Const.Msg_Select_Date_Correctly);
                  } else {
                    setState(() {
                      isLoading = true;
                    });
                    _showLoadingDialog(action: 'open', isLoading: isLoading);

                    // Create process.
                    if (widget.action == Const.Label_Process_Create) {
                      _addDataService(json: {
                        'name': titleFieldController.text,
                        'startDate': startDateMillisecond,
                        'endDate': endDateMillisecond,
                        'status': false,
                      });
                    }
                    // Update process.
                    else if (widget.action == Const.Label_Process_Edit) {
                      todoDetail['data']['name'] = titleFieldController.text;
                      todoDetail['data']['startDate'] = startDateMillisecond;
                      todoDetail['data']['endDate'] = endDateMillisecond;

                      _updateDataService(collection: Const.CollectionName, uid: todoDetail['uid'], json: todoDetail['data']);
                    }
                    await _getToDoListDataProcess();
                    _showLoadingDialog(action: 'close', isLoading: isLoading);
                    Navigator.pop(context);
                    _showUpdateDialog(message: (widget.action == Const.Label_Process_Edit) ? Const.Msg_Update_Success : Const.Msg_Create_Success);
                  }
                }
              },
              style: ElevatedButton.styleFrom(primary: COLOR_TEXT_DEFAULT, onPrimary: COLOR_WHITE),
              child: Text((widget.action == Const.Label_Process_Create) ? Const.Btn_Create_Now : Const.Btn_Save),
            ),
          ),
        ),
      ),
    );
  }
}

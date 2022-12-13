import 'package:cloud_firestore/cloud_firestore.dart';

class Const {
  /// FIREBASE
  static final FirestoreInstance = FirebaseFirestore.instance;
  static const String CollectionName = 'todo';

  /// LABEL
  static const String Label_To_Do_App = 'To Do App';
  static const String Label_To_Do_List = 'To-Do List';
  static const String Label_Add_New_To_Do_List = 'Add new To-Do List';
  static const String Label_Start_Date = 'Start Date';
  static const String Label_End_Date = 'End Date';
  static const String Label_Estimate_End_Date = 'Estimate End Date';
  static const String Label_Time_Left = 'Time left';
  static const String Label_Status = 'Status';
  static const String Label_Tick_Completed = 'Tick if completed';
  static const String Label_Status_Completed = 'Completed';
  static const String Label_Status_Incomplete = 'Incomplete';
  static const String Label_Process_Create = 'create';
  static const String Label_Process_Edit = 'edit';
  static const String Label_To_Do_Title = 'To-Do Title';

  /// MESSAGE
  static const String Msg_Firebase_Initialize_Success = 'Firebase has been initialized.';
  static const String Msg_Update_Success = 'Update successfully.';
  static const String Msg_Create_Success = 'Create successfully.';
  static const String Msg_Fill_In_Completely = 'Please fill in completely.';
  static const String Msg_Placeholder_Title = 'Please key in your To-Do title here';
  static const String Msg_Placeholder_Date = 'Select a date';
  static const String Msg_ToDo_Not_Found = 'To-Do list Not Found';
  static const String Msg_Select_Date_Correctly = 'Please select date correctly.';

  /// BUTTON
  static const String Btn_Create_Now = 'Create Now';
  static const String Btn_Save = 'Save';
}

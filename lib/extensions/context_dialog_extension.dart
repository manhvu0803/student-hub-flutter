import 'package:flutter/material.dart';
import 'package:student_hub_flutter/screens/dialog_view/schedule_interview_view.dart';

extension ContextDialogExtension on BuildContext {
  void pushRoute(Widget Function(BuildContext context) builder) {
    Navigator.push(this, MaterialPageRoute(builder: builder));
  }

  Future<T?> showScheduleInterviewDialog<T>() {
    return showDialog<T>(
      context: this,
      builder: (context) => _buildDialog(const ScheduleInterviewView())
    );
  }

  showLoadingDialog() {
    showDialog(
      barrierDismissible: false,
      context: this,
      builder: (BuildContext context) => const AlertDialog(
        content: SizedBox(
          height: 100,
          child: Column(
            children: [
              SizedBox(height: 20),
              CircularProgressIndicator(),
              SizedBox(height: 20),
              Text("Loading..." ),
            ],
          ),
        ),
      ),
    );
  }

  void showTextSnackBar(String text) {
    showSnackBar(Text(
      text,
      textAlign: TextAlign.center
    ));
  }

  void showSnackBar(Widget content) {
    ScaffoldMessenger
      .of(this)
      .showSnackBar(SnackBar(content: content));
  }

  Dialog _buildDialog(Widget child, {double insetPadding = 16, double childPadding = 24}) {
    return Dialog(
      insetPadding: EdgeInsets.all(insetPadding),
      child: Padding(
        padding: EdgeInsets.all(childPadding),
        child: child,
      ),
    );
  }
}
import 'package:flutter/material.dart';

extension ContextDialogExtension on BuildContext {
  void pushRoute(
    Widget Function(BuildContext context) builder,
    {void Function()? onPop}
  ) async {
    await Navigator.push(this, MaterialPageRoute(builder: builder));
    onPop?.call();
  }

  void pushReplacement(Widget Function(BuildContext context) builder) {
    Navigator.pushReplacement(this, MaterialPageRoute(builder: builder));
  }

  Future<void> showRequestLoad<T>({
    required Future<T> Function() request,
    void Function()? onRequestDone
  }) async {
    try {
      showLoadingDialog();
      await request();

      if (mounted) {
        Navigator.pop(this);
        onRequestDone?.call();
      }
    }
    on Exception catch (e) {
      if (mounted) {
        Navigator.pop(this);
        showTextSnackBar(e.toString());
      }
    }
  }

  void showLoadingDialog() {
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

  Future<void> loadWithDialog<T>(Future<T> future, {void Function(T)? onDone, void Function(dynamic)? onError}) async {
    showLoadingDialog();

    try {
      var data = await future;
      Navigator.pop(this);
      onDone?.call(data);
    }
    catch (e) {
      if (mounted) {
        Navigator.pop(this);
        showTextSnackBar(e.toString());
      }

      onError?.call(e);
    }
  }

  void showTextSnackBar(String text, {Duration? duration}) {
    showSnackBar(
      Text(
        text,
        textAlign: TextAlign.center
      ),
      duration: duration
    );
  }

  void showSnackBar(Widget content, {Duration? duration}) {
    ScaffoldMessenger
      .of(this)
      .showSnackBar(SnackBar(
        content: content,
        duration: duration ?? const Duration(seconds: 4),
      ));
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
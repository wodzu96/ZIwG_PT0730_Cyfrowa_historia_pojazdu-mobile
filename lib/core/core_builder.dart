import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract class CoreBuilder {
  Widget buildLoadingLayout(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildErrorLayout(BuildContext context, String text) {
    return Center(
      child: Column(
        children: <Widget>[Icon(Icons.error), Text(text)],
      ),
    );
  }

  Widget buildRefreshableErrorLayout(
      BuildContext context, String text, Function refresh) {
    return Center(
      child: RefreshIndicator(
          onRefresh: refresh,
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: buildErrorLayout(context, text),
          )),
    );
  }

  void showErrorDialog(BuildContext context, String body, Function onClose) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Błąd!"),
          content: new Text(body),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Zamknij"),
              onPressed: () {
                Navigator.of(context).pop();
                onClose();
              },
            ),
          ],
        );
      },
    );
  }

  void showSuccessDialog(BuildContext context, String body, Function onClose) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Sukces!"),
          content: new Text(body),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Zamknij"),
              onPressed: () {
                Navigator.of(context).pop();
                onClose();
              },
            ),
          ],
        );
      },
    );
  }

  void showExitDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Wyjście"),
          content: new Text("Czy na pewno chcesz opuścić aplikację?"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Anuluj"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text("Zamknij"),
              onPressed: () {
                SystemChannels.platform.invokeMethod('SystemNavigator.pop');
              },
            ),
          ],
        );
      },
    );
  }
}

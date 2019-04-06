import 'package:flutter/material.dart';
import 'package:progress_hud/progress_hud.dart';

abstract class CoreBuilder {

  Widget buildLoadingLayout(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildErrorLayout(BuildContext context, String text) {
    return Center(
      child: Column(
        children: <Widget>[
          Icon(Icons.error),
          Text(text)
        ],
      ),
    );
  }

  Widget buildRefreshableErrorLayout(BuildContext context, String text,
      Function refresh) {
    return Center(
      child: RefreshIndicator(
          onRefresh: refresh,
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: buildErrorLayout(context, text),
          )),
    );
  }

  ProgressHUD buildLoadingHUD() {
    return ProgressHUD(
      color: Colors.white,
      containerColor: Colors.grey,
      borderRadius: 5.0,
      text: 'Ładowanie...',
    );
  }
}

import 'package:cyfrowa_historia_pojazdu/common/dateTimeFormatter.dart';
import 'package:cyfrowa_historia_pojazdu/communication/model/Car.dart';
import 'package:cyfrowa_historia_pojazdu/communication/model/Demage.dart';
import 'package:cyfrowa_historia_pojazdu/core/core_builder.dart';
import 'package:flutter/material.dart';

class DamagesPageBuilder with CoreBuilder {
  final Car car;

  DamagesPageBuilder(this.car);

  Widget buildRootLayout(BuildContext context, List<Damage> damages,
      Error error, Function refresh) {
    if (error != null)
      return buildRefreshableErrorLayout(context, error.toString(), refresh);
    else if (damages == null || car == null)
      return buildLoadingLayout(context);
    else
      return buildLayout(context, damages, refresh);
  }

  Widget buildLayout(
      BuildContext context, List<Damage> damages, Function refresh) {
    return RefreshIndicator(
        onRefresh: refresh,
        child: ConstrainedBox(
          constraints: BoxConstraints.expand(),
          child: ListView(
              physics: AlwaysScrollableScrollPhysics(),
              children: getWidgetsInList(damages, car)),
        ));
  }

  List<Widget> getWidgetsInList(List<Damage> damages, Car car) {
    List<Widget> widgets = [_buildCarCard(car)];
    widgets.addAll(damages.map((damage) => _buildFixCard(damage)).toList());
    return widgets;
  }

  Widget _buildFixCard(Damage damage) {
    return Card(
        margin: EdgeInsets.only(left: 8, right: 8, top: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildCardHeader(Icons.accessible, damage.course.toString() + "km",
                dateTimeToString(damage.damageDate)),
            _buildCardBody(damage.name),
            Padding(
              padding: EdgeInsets.only(bottom: 16),
            )
          ],
        ));
  }

  Widget _buildCarCard(Car car) {
    return Card(
        margin: EdgeInsets.only(left: 8, right: 8, top: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildCardHeader(Icons.directions_car, car.registerNumber, car.VIN),
            _buildCardBody(car.name),
            Padding(
              padding: EdgeInsets.only(bottom: 16),
            )
          ],
        ));
  }

  ListTile _buildCardHeader(IconData iconData, String title, String subtitle) {
    return ListTile(
      leading: Icon(
        iconData,
        size: 48,
      ),
      title: Text(title),
      subtitle: Text(subtitle),
    );
  }

  Text _buildCardBody(String text) {
    return Text(text, textAlign: TextAlign.center, style: _cardBodyTextStyle());
  }

  TextStyle _cardBodyTextStyle() {
    return TextStyle(fontSize: 38, color: Colors.white);
  }
}

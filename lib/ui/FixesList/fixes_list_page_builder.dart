import 'package:cyfrowa_historia_pojazdu/common/dateTimeFormatter.dart';
import 'package:cyfrowa_historia_pojazdu/communication/model/Car.dart';
import 'package:cyfrowa_historia_pojazdu/communication/model/CarFix.dart';
import 'package:cyfrowa_historia_pojazdu/core/core_builder.dart';
import 'package:cyfrowa_historia_pojazdu/ui/CarFixCreate/car_fix_create_page.dart';
import 'package:cyfrowa_historia_pojazdu/ui/CarFixDetails/car_fix_details_page.dart';
import 'package:flutter/material.dart';

class FixesPageBuilder with CoreBuilder {
  final Car car;

  FixesPageBuilder(this.car);

  Widget buildRootLayout(
      BuildContext context, List<CarFix> fixes, Error error, Function refresh) {
    if (error != null)
      return buildRefreshableErrorLayout(context, error.toString(), refresh);
    else if (fixes == null || car == null)
      return buildLoadingLayout(context);
    else
      return buildLayout(context, fixes, car, refresh);
  }

  Widget buildLayout(
      BuildContext context, List<CarFix> fixes, Car car, Function refresh) {
    return RefreshIndicator(
        onRefresh: refresh,
        child: ConstrainedBox(
          constraints: BoxConstraints.expand(),
          child: ListView(
              physics: AlwaysScrollableScrollPhysics(),
              children: getWidgetsInList(fixes, car, context)),
        ));
  }

  List<Widget> getWidgetsInList(
      List<CarFix> fixes, Car car, BuildContext context) {
    List<Widget> widgets = [_buildCarCard(car)];
    widgets.addAll(fixes.map((fix) => _buildFixCard(context, fix)).toList());
    widgets.add(_buildAddCard(context, car.name));
    return widgets;
  }

  Widget _buildAddCard(context, String carName) {
    return Card(
      margin: EdgeInsets.only(left: 8, right: 8, top: 8),
      child: new InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => CarFixCreateScreen(carName: carName)));
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 16),
              ),
              _buildAddBody(),
              Padding(
                padding: EdgeInsets.only(bottom: 16),
              )
            ],
          )),
    );
  }

  Widget _buildFixCard(BuildContext context, CarFix fix) {
    return Card(
      margin: EdgeInsets.only(left: 8, right: 8, top: 8),
      child: new InkWell(
          onTap: () {
            Navigator.of(context).push(new MaterialPageRoute(
                builder: (context) =>
                    CarFixDetailsScreen(carFix: fix, carName: car.name)));
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _buildCardHeader(Icons.adjust, fix.course.toString() + " km",
                  dateTimeToString(fix.fixDate)),
              _buildCardBody(fix.name),
              Padding(
                padding: EdgeInsets.only(bottom: 16),
              )
            ],
          )),
    );
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

  Icon _buildAddBody() {
    return Icon(Icons.add, size: 48);
  }

  TextStyle _cardBodyTextStyle() {
    return TextStyle(fontSize: 38, color: Colors.white);
  }
}

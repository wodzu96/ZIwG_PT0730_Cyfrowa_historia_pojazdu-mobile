import 'package:cyfrowa_historia_pojazdu/communication/model/Car.dart';
import 'package:cyfrowa_historia_pojazdu/communication/model/userdata.dart';
import 'package:cyfrowa_historia_pojazdu/core/core_builder.dart';
import 'package:cyfrowa_historia_pojazdu/ui/Car/car_page.dart';
import 'package:flutter/material.dart';

class HomePageBuilder with CoreBuilder {
  Widget buildRootLayout(BuildContext context, List<Car> cars,
      UserData userData, Error error, Function refresh) {
    if (error != null)
      return buildRefreshableErrorLayout(context, error.toString(), refresh);
    else if (userData == null || cars == null)
      return buildLoadingLayout(context);
    else
      return buildLayout(context, cars, userData, refresh);
  }

  Widget buildLayout(BuildContext context, List<Car> cars, UserData userData,
      Function refresh) {
    return RefreshIndicator(
        onRefresh: refresh,
        child: ConstrainedBox(
          constraints: BoxConstraints.expand(),
          child: ListView(
              physics: AlwaysScrollableScrollPhysics(),
              children: getWidgetsInList(context, cars, userData)),
        ));
  }

  List<Widget> getWidgetsInList(
      BuildContext context, List<Car> cars, UserData userData) {
    List<Widget> widgets = [_buildUserDataCard(userData)];
    widgets.addAll(cars.map((car) => _buildCarCard(context, car)).toList());
    widgets.add(_buildAddCard(context));
    return widgets;
  }

  Widget _buildAddCard(context) {
    return Card(
      margin: EdgeInsets.only(left: 8, right: 8, top: 8),
      child: new InkWell(
          onTap: () {
            // TODO: Igor masz context nak...
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

  Widget _buildUserDataCard(UserData userData) {
    return Card(
        margin: EdgeInsets.only(left: 8, right: 8, top: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildCardHeader(Icons.account_circle, userData.email, ""),
            _buildCardBody(userData.name),
            Padding(
              padding: EdgeInsets.only(bottom: 16),
            )
          ],
        ));
  }

  Widget _buildCarCard(BuildContext context, Car car) {
    return Card(
      margin: EdgeInsets.only(left: 8, right: 8, top: 8),
      child: new InkWell(
        onTap: () {
          Navigator.of(context).push(
              new MaterialPageRoute(builder: (context) => CarPage(car: car)));
        },
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _buildCardHeader(
                  Icons.directions_car, car.registerNumber, car.VIN),
              _buildCardBody(car.name),
              Padding(
                padding: EdgeInsets.only(bottom: 16),
              )
            ]),
      ),
    );
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

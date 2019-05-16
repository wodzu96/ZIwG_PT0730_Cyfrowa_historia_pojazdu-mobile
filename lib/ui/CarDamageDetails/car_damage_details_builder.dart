import 'package:cyfrowa_historia_pojazdu/communication/model/CarDamage.dart';
import 'package:cyfrowa_historia_pojazdu/communication/validations.dart';
import 'package:cyfrowa_historia_pojazdu/core/core_builder.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CarDamageDetailsBuilder with CoreBuilder, Validations {
  Widget buildRootLayout(
      context, bool isLoading, Function refresh, CarDamage carDamage) {
    if (isLoading)
      return buildLoadingLayout(context);
    else
      return buildDefaultLayout(context, refresh, carDamage);
  }

  Widget buildDefaultLayout(
      BuildContext context, Function refresh, CarDamage carDamage) {
    return RefreshIndicator(
        onRefresh: refresh,
        child: ConstrainedBox(
          constraints: BoxConstraints.expand(),
          child: ListView(
            children: <Widget>[
              _buildNameCard(carDamage),
              _buildEntryTimeCard(carDamage),
              _buildCourseCard(carDamage),
              _buildDescriptionCard(carDamage),
              Padding(
                padding: EdgeInsets.only(bottom: 8.0),
              )
            ],
          ),
        ));
  }

  Widget _buildNameCard(CarDamage carDamage) {
    return Card(
        margin: EdgeInsets.only(left: 8, right: 8, top: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildCardHeader(
                Icons.create, "Nazwa", "Serwisowy identyfikator naprawy"),
            _buildCardSeparator(),
            _buildCardBody(carDamage.name)
          ],
        ));
  }

  Widget _buildDescriptionCard(CarDamage carDamage) {
    return Card(
        margin: EdgeInsets.only(left: 8, right: 8, top: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildCardHeader(
                Icons.description, "Opis", "Szczegółowe informacje o naprawie"),
            _buildCardSeparator(),
            _buildCardBody(carDamage.description)
          ],
        ));
  }

  Widget _buildCourseCard(CarDamage carDamage) {
    return Card(
        margin: EdgeInsets.only(left: 8, right: 8, top: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildCardHeader(
                Icons.near_me, "Przebieg", "Aktualny w momencie wykonania"),
            _buildCardSeparator(),
            _buildCardBody(carDamage.course.toString())
          ],
        ));
  }

  Widget _buildEntryTimeCard(CarDamage carDamage) {
    return Card(
        margin: EdgeInsets.only(left: 8, right: 8, top: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildCardHeader(Icons.today, "Data", "Termin zgłoszenia usterki"),
            _buildCardSeparator(),
            _buildCardBody(DateFormat("dd.MM.yyyy, hh:mm:ss")
                .format(carDamage.damageDate)),
          ],
        ));
  }

  ListTile _buildCardHeader(IconData iconData, String title, String subtitle) {
    return ListTile(
      leading: Icon(
        iconData,
        size: 36,
      ),
      title: Text(title),
      subtitle: Text(subtitle),
    );
  }

  Widget _buildCardBody(String text) {
    return Padding(
        padding: EdgeInsets.only(left: 16.0, right: 16, top: 8.0, bottom: 8.0),
        child: Text(text,
            textAlign: TextAlign.center, style: _cardBodyTextStyle()));
  }

  TextStyle _cardBodyTextStyle() {
    return TextStyle(fontSize: 24, color: Colors.white);
  }

  Widget _buildCardSeparator() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Divider(
          height: 2.0,
          color: Colors.black54,
        ));
  }
}

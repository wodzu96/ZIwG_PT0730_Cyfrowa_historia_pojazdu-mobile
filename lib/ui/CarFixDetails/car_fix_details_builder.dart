import 'package:cyfrowa_historia_pojazdu/communication/FirebaseDatabaseService.dart';
import 'package:cyfrowa_historia_pojazdu/communication/model/CarFix.dart';
import 'package:cyfrowa_historia_pojazdu/communication/validations.dart';
import 'package:cyfrowa_historia_pojazdu/core/core_builder.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CarFixDetailsBuilder with CoreBuilder, Validations {
  Widget buildRootLayout(
      FirebaseDatabaseService service, String carName,
      context, bool isLoading, Function refresh, CarFix carFix) {
    if (isLoading)
      return buildLoadingLayout(context);
    else
      return buildDefaultLayout(service, carName, context, refresh, carFix);
  }

  Widget buildDefaultLayout(
      FirebaseDatabaseService service, String carName,
      BuildContext context, Function refresh, CarFix carFix) {
    return RefreshIndicator(
        onRefresh: refresh,
        child: ConstrainedBox(
          constraints: BoxConstraints.expand(),
          child: ListView(
            children: <Widget>[
              _buildNameCard(carFix),
              _buildEntryTimeCard(carFix),
              _buildCategoryCard(carFix),
              _buildCourseCard(carFix),
              _buildDescriptionCard(carFix),
              _buildDeleteCard(context, service, carFix.name, carName),
              Padding(
                padding: EdgeInsets.only(bottom: 8.0),
              )
            ],
          ),
        ));
  }

  Widget _buildNameCard(CarFix carFix) {
    return Card(
        margin: EdgeInsets.only(left: 8, right: 8, top: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildCardHeader(
                Icons.create, "Nazwa", "Serwisowy identyfikator naprawy"),
            _buildCardSeparator(),
            _buildCardBody(carFix.name)
          ],
        ));
  }

  Widget _buildDescriptionCard(CarFix carFix) {
    return Card(
        margin: EdgeInsets.only(left: 8, right: 8, top: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildCardHeader(
                Icons.description, "Opis", "Szczegółowe informacje o naprawie"),
            _buildCardSeparator(),
            _buildCardBody(carFix.description)
          ],
        ));
  }

  Widget _buildCourseCard(CarFix carFix) {
    return Card(
        margin: EdgeInsets.only(left: 8, right: 8, top: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildCardHeader(
                Icons.near_me, "Przebieg", "Aktualny w momencie wykonania"),
            _buildCardSeparator(),
            _buildCardBody(carFix.course.toString())
          ],
        ));
  }

  Widget _buildCategoryCard(CarFix carFix) {
    return Card(
        margin: EdgeInsets.only(left: 8, right: 8, top: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildCardHeader(
                Icons.category, "Kategoria", "Określa przynależność naprawy"),
            _buildCardSeparator(),
            _buildCardBody(carFix.fixCategoryName)
          ],
        ));
  }

  Widget _buildEntryTimeCard(CarFix carFix) {
    return Card(
        margin: EdgeInsets.only(left: 8, right: 8, top: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildCardHeader(
                Icons.today, "Data", "Termin przeprowadzonej naprawy"),
            _buildCardSeparator(),
            _buildCardBody(
                DateFormat("dd.MM.yyyy, hh:mm:ss").format(carFix.fixDate)),
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

  Widget _buildDeleteCard(context, FirebaseDatabaseService service, String fixName, String carName) {
    return Card(
      margin: EdgeInsets.only(left: 8, right: 8, top: 8),
      child: new InkWell(
          onTap: () {
            _removeFix(service, fixName, carName);
            Navigator.of(context).pop();
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[_buildCardBody("Usuń")],
          )),
    );
  }

  Future<dynamic> _removeFix(FirebaseDatabaseService service, String fixName, String carName) async{
    try{
      await service.removeFixFromCar(fixName, carName);
    }
    catch(error){

    }
  }
}

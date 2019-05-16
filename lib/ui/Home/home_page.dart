import 'package:cyfrowa_historia_pojazdu/communication/FirebaseDatabaseService.dart';
import 'package:cyfrowa_historia_pojazdu/communication/model/Car.dart';
import 'package:cyfrowa_historia_pojazdu/communication/model/CarDamage.dart';
import 'package:cyfrowa_historia_pojazdu/communication/model/CarFix.dart';
import 'package:cyfrowa_historia_pojazdu/communication/model/userdata.dart';
import 'package:cyfrowa_historia_pojazdu/core/core_page.dart';
import 'package:cyfrowa_historia_pojazdu/ui/Home/home_page_builder.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget
    implements CorePage<HomePageBuilder, FirebaseDatabaseService> {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();

  @override
  get builder => HomePageBuilder();

  @override
  get service => FirebaseDatabaseService();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin<HomePage> {
  List<Car> _cars;
  UserData _userData;
  Error _error;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    _refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder.buildRootLayout(context, _cars, _userData, _error, _refresh);
  }

  Future<dynamic> _refresh() async {
    try{
      UserData userData = await widget.service.getCurrentUser();
      List<Car> cars = await widget.service.getCars();
      setState(() {
        _userData = userData;
        _cars = cars;
        _error = null;
      });
    }
    catch(error){
      setState(() {
        _error = error;
      });
    }
  }
}

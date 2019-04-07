import 'package:cyfrowa_historia_pojazdu/communication/FirebaseDatabaseService.dart';
import 'package:cyfrowa_historia_pojazdu/communication/model/Car.dart';
import 'package:cyfrowa_historia_pojazdu/communication/model/CarFix.dart';
import 'package:cyfrowa_historia_pojazdu/communication/model/Demage.dart';
import 'package:cyfrowa_historia_pojazdu/core/core_page.dart';
import 'package:cyfrowa_historia_pojazdu/ui/DamagesList/damages_list_page_builder.dart';
import 'package:cyfrowa_historia_pojazdu/ui/Home/home_page_builder.dart';
import 'package:flutter/material.dart';

class DamagesPage extends StatefulWidget
    implements CorePage<HomePageBuilder, FirebaseDatabaseService> {
  final Car car;

  DamagesPage({Key, key, @required this.car}):super(key: key);

  @override
  _DamagesPageState createState() => _DamagesPageState(car);

  @override
  get builder => DamagesPageBuilder(car);

  @override
  get service => FirebaseDatabaseService();
}

class _DamagesPageState extends State<DamagesPage>
    with AutomaticKeepAliveClientMixin<DamagesPage> {
  Car car;

  _DamagesPageState(this.car);

  List<Damage> _damages;
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
    return widget.builder
        .buildRootLayout(context, _damages, _error, _refresh);
  }

  Future<dynamic> _refresh() async {
    try {
      List<Damage> damages = await widget.service.getCarDamages(car.name);
      setState(() {
        _damages = damages;
        _error = null;
      });
    } catch (error) {
      setState(() {
        _error = error;
      });
    }
  }
}

import 'package:cyfrowa_historia_pojazdu/communication/FirebaseDatabaseService.dart';
import 'package:cyfrowa_historia_pojazdu/communication/model/Car.dart';
import 'package:cyfrowa_historia_pojazdu/core/core_page.dart';
import 'package:cyfrowa_historia_pojazdu/ui/Car/car_page_builder.dart';
import 'package:cyfrowa_historia_pojazdu/ui/DamagesList/damages_list_page.dart';
import 'package:cyfrowa_historia_pojazdu/ui/FixesList/fixes_list_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CarPage extends StatefulWidget
    implements CorePage<CarPageBuilder, FirebaseDatabaseService> {
  CarPage({Key, key, @required this.car}) :super(key: key);
  Car car;


  final List<String> tabTitles = ["Zmiany", "Uszkodzenia"];
  final List<Widget> tabButtons = [
    Tab(icon: Icon(Icons.adjust), text: "Zmiany",),
    Tab(icon: Icon(Icons.today), text: "Uszkodzenia",)
  ];

  @override
  _CarPageState createState() => _CarPageState(car);

  @override
  get builder => CarPageBuilder();

  @override
  get service => FirebaseDatabaseService();
}

class _CarPageState extends State<CarPage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin<CarPage> {
  Car car;

  _CarPageState(this.car);

  int _currentTabSelected = 0;
  TabController _tabController;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    _tabController = TabController(
        initialIndex: 0, length: widget.tabButtons.length, vsync: this);
    _tabController.addListener(() => _onTabChanged());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    List<Widget> tabViews = [FixesPage(car: car), DamagesPage(car: car)];
    return Scaffold(
      appBar: widget.builder
          .buildHomePageAppBar(widget.tabTitles[_currentTabSelected]),
      body: TabBarView(controller: _tabController, children: tabViews),
      bottomNavigationBar: TabBar(
          controller: _tabController, tabs: widget.tabButtons),
    );
  }

  void _onTabChanged() {
    setState(() {
      _currentTabSelected = _tabController.index;
    });
    debugPrint('Selected tab: $_currentTabSelected');
  }
}

import 'dart:math';

import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:learn_stacked/app/app.locator.dart';
import 'package:learn_stacked/app/app.router.dart';
import 'package:learn_stacked/provider/firebaseProvider.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final String _title = 'Home View';
  String get title => '$_title $_counter';

  Widget? _iniwidget;
  Widget? get widgetnya => _iniwidget;

  int _counter = 0;
  int get counter => _counter;

  void updateCounter() {
    // _counter++;
    // notifyListeners();
    _navigationService.navigateTo(Routes.startUpView);
  }

  void gantiWidget() async {
    // wait for 4 sec
    await Future.delayed(Duration(seconds: 3));

    // create a random number between 1 and 10
    final random = Random().nextInt(10) + 1;
    _iniwidget = Container(
      child: Text('ini widget $random'),
    );
    notifyListeners();
  }

  cekStat(BuildContext context) async {
    final provider = Provider.of<FirebaseProvider>(context, listen: false);
    provider.checkVerificationEmail();
  }

  logout(BuildContext context) async {
    final provider = Provider.of<FirebaseProvider>(context, listen: false);

    bool _res = await provider.logout();

    dev.log(_res.toString() + "ini logout");

    if (_res) _navigationService.navigateTo(Routes.startUpView);
  }
}

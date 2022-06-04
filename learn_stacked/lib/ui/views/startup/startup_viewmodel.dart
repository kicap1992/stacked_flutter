import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:learn_stacked/app/app.locator.dart';
import 'package:learn_stacked/app/app.router.dart';
import 'package:learn_stacked/provider/firebaseProvider.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class StartUpViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final emailRegisterController = TextEditingController();
  final passwordRegisterController = TextEditingController();
  final confirmPasswordRegisterController = TextEditingController();
  final formKeyRegister = GlobalKey<FormState>();

  final String _title = 'Start Up View';
  String get title => _title;

  doSomething(BuildContext context) async {
    final provider = Provider.of<FirebaseProvider>(context, listen: false);

    // provider.logout();

    bool _res = await provider.googleLogin();

    if (_res) _navigationService.clearStackAndShow(Routes.homeView);
    // log("sini berlaku dia");
    // _navigationService.navigateTo(Routes.homeView);
  }

  loginWithEmail(BuildContext context, String email, String password) async {
    // log(email.toString() + " ini email");
    // log(password.toString() + " ini password");
    final provider = Provider.of<FirebaseProvider>(context, listen: false);
    bool _res = await provider.signInWithEmail(email, password);
    if (_res) _navigationService.clearStackAndShow(Routes.homeView);
  }

  signUpWithEmail(BuildContext context, String email, String password) async {
    // log(email.toString() + " ini email");
    // log(password.toString() + " ini password");
    final provider = Provider.of<FirebaseProvider>(context, listen: false);
    await provider.signUpWithEmail(email, password);
    // if (_res) _navigationService.clearStackAndShow(Routes.homeView);
  }

  signInWithFacebook(BuildContext context) async {
    final provider = Provider.of<FirebaseProvider>(context, listen: false);
    await provider.signInWithFacebook();
    // if (_res) _navigationService.clearStackAndShow(Routes.homeView);
  }

  initFirst(BuildContext context) async {
    final provider = Provider.of<FirebaseProvider>(context, listen: false);

    bool _res = await provider.checkUser();

    if (_res) _navigationService.navigateTo(Routes.homeView);

    // provider.user;
    log("jalankan pertama");
  }
}

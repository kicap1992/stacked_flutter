import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stacked/stacked.dart';

import 'startup_viewmodel.dart';

class StartUpView extends StatelessWidget {
  const StartUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StartUpViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Form(
                  key: model.formKey,
                  child: Column(
                    children: [
                      Text(model.title),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: model.emailController,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          prefixIcon: Icon(FontAwesomeIcons.envelope),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: model.passwordController,
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          prefixIcon: Icon(FontAwesomeIcons.lock),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      RaisedButton(
                        child: const Text('Login'),
                        onPressed: () {
                          if (model.formKey.currentState!.validate()) {
                            dev.log("jalankan");
                            model.loginWithEmail(
                                context,
                                model.emailController.text,
                                model.passwordController.text);
                          }
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Form(
                  key: model.formKeyRegister,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: model.emailRegisterController,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          prefixIcon: Icon(FontAwesomeIcons.envelope),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: model.passwordRegisterController,
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          prefixIcon: Icon(FontAwesomeIcons.lock),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: model.confirmPasswordRegisterController,
                        decoration: const InputDecoration(
                          labelText: 'Confirm Password',
                          prefixIcon: Icon(FontAwesomeIcons.lock),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      RaisedButton(
                        child: const Text('Register'),
                        onPressed: () {
                          if (model.formKeyRegister.currentState!.validate()) {
                            dev.log("jalankan");
                            model.signUpWithEmail(
                                context,
                                model.emailRegisterController.text,
                                model.passwordRegisterController.text);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // model.doSomething(context);
            model.signInWithFacebook(context);
          },
          tooltip: 'Increment',
          child: const FaIcon(FontAwesomeIcons.google),
        ),
      ),
      viewModelBuilder: () => StartUpViewModel(),
      onModelReady: (model) => model.initFirst(context),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'home_viewmodel.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      builder: (content, model, child) => Scaffold(
        body: Center(
          child: Column(
            children: [
              Text(model.title),
              const SizedBox(height: 20),
              model.widgetnya ??
                  Container(
                    child: const CircularProgressIndicator(),
                  ),
              const SizedBox(height: 20),
              RaisedButton(
                child: Text('Navigate to HomeView'),
                onPressed: () => model.gantiWidget(),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            model.logout(context);
            // model.cekStat(context);
          },
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      ),
      viewModelBuilder: () => HomeViewModel(),
      onModelReady: (model) => model.cekStat(context),
    );
  }
}

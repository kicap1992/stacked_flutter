import 'package:learn_stacked/ui/views/home/home_view.dart';
import 'package:learn_stacked/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

@StackedApp(routes: [
  MaterialRoute(
    page: StartUpView,
    initial: true,
  ),
  CupertinoRoute(page: HomeView)
], dependencies: [
  LazySingleton(classType: NavigationService),
])
class AppSetup {}

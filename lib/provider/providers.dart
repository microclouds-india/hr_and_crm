import 'package:hr_and_crm/repository/login/notifier/login.notifier.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [

  ChangeNotifierProvider<LoginNotifier>(create: (context) => LoginNotifier()),

];

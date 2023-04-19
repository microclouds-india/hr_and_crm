import 'package:hr_and_crm/repository/branches/notifier/branches.notifier.dart';
import 'package:hr_and_crm/repository/employees/notifier/employee.notifier.dart';
import 'package:hr_and_crm/repository/leaveTypes/notifier/leaveTypes.notifier.dart';
import 'package:hr_and_crm/repository/login/notifier/login.notifier.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../repository/employeeDetails/notifier/employeeDetails.notifier.dart';

List<SingleChildWidget> providers = [

  ChangeNotifierProvider<LoginNotifier>(create: (context) => LoginNotifier()),
  ChangeNotifierProvider<EmployeeNotifier>(create: (context) => EmployeeNotifier()),
  ChangeNotifierProvider<EmployeeDetailsNotifier>(create: (context) => EmployeeDetailsNotifier()),
  ChangeNotifierProvider<LeaveTypesNotifier>(create: (context) => LeaveTypesNotifier()),
  ChangeNotifierProvider<BranchesNotifier>(create: (context) => BranchesNotifier()),

];

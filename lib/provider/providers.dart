import 'package:hr_and_crm/repository/Leave%20Requests/notifier/leaveRequestsNotifier.dart';
import 'package:hr_and_crm/repository/branches/notifier/branches.notifier.dart';
import 'package:hr_and_crm/repository/clock_in/clock_in_notifier/clock_IN_notifier.dart';
import 'package:hr_and_crm/repository/documents/notifier/upload_document_notifier.dart';
import 'package:hr_and_crm/repository/dropDownServices/dropDownServices.notifier.dart';
import 'package:hr_and_crm/repository/employees/notifier/employee.notifier.dart';
import 'package:hr_and_crm/repository/leaveTypes/notifier/leaveTypes.notifier.dart';
import 'package:hr_and_crm/repository/log%20out/notifier/logout_notifier.dart';
import 'package:hr_and_crm/repository/login/notifier/login.notifier.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../repository/addHoliday/notifier/add_holiday_notifier.dart';
import '../repository/attendance report/notifier.dart';
import '../repository/clock_out/notifier/clock_OUT_notifier.dart';
import '../repository/employeeDetails/notifier/employeeDetails.notifier.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider<LoginNotifier>(create: (context) => LoginNotifier()),
  ChangeNotifierProvider<EmployeeNotifier>(create: (context) => EmployeeNotifier()),
  ChangeNotifierProvider<EmployeeDetailsNotifier>(create: (context) => EmployeeDetailsNotifier()),
  ChangeNotifierProvider<LeaveTypesNotifier>(create: (context) => LeaveTypesNotifier()),
  ChangeNotifierProvider<BranchesNotifier>(create: (context) => BranchesNotifier()),
  ChangeNotifierProvider<DropDownServiceNotifier>(create: (context) => DropDownServiceNotifier()),
  ChangeNotifierProvider<leaveRequestNotifier>(create: (context) => leaveRequestNotifier(),),  ChangeNotifierProvider<UploadDocumentsNotier>(create: (context) => UploadDocumentsNotier(),),
  ChangeNotifierProvider<ClockINNotifier>(create: (context) => ClockINNotifier(),),
  ChangeNotifierProvider<ClockOUTNotifier>(create: (context) => ClockOUTNotifier(),),
  ChangeNotifierProvider<AddHolidayNotifier>(create: (context) => AddHolidayNotifier(),),
  ChangeNotifierProvider<AttendanceReportNotifier>(create: (context) => AttendanceReportNotifier(),),
  ChangeNotifierProvider<LogoutNotifier>(create: (context) => LogoutNotifier(),),
];

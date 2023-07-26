import 'package:hr_and_crm/repository/Leave%20Requests/notifier/leaveRequestsNotifier.dart';
import 'package:hr_and_crm/repository/absent_all/notifier/absent_all_notifier.dart';
import 'package:hr_and_crm/repository/add%20expense%20category/notifier/notifier.dart';
import 'package:hr_and_crm/repository/add_branch/notifier/add_branch_notifier.dart';
import 'package:hr_and_crm/repository/branches/notifier/branches.notifier.dart';
import 'package:hr_and_crm/repository/clock_in/clock_in_notifier/clock_IN_notifier.dart';
import 'package:hr_and_crm/repository/clockin_view/notifier/notifier.dart';
import 'package:hr_and_crm/repository/dropDownServices/dropDownServices.notifier.dart';
import 'package:hr_and_crm/repository/edit%20and%20delete%20leavetypes/add/notifier.dart';
import 'package:hr_and_crm/repository/edit%20and%20delete%20leavetypes/delete%20leavetypes/notifier/notifier.dart';
import 'package:hr_and_crm/repository/edit%20and%20delete%20leavetypes/edit%20leave%20types/notifier/notifier.dart';
import 'package:hr_and_crm/repository/edit%20workreport/notifier.dart';
import 'package:hr_and_crm/repository/employee%20assigned%20workshift/notifier/notifier.dart';
import 'package:hr_and_crm/repository/employee%20leave%20requisets/notifier/notifier.dart';
import 'package:hr_and_crm/repository/employees/notifier/employee.notifier.dart';
import 'package:hr_and_crm/repository/hr%20workreports/notifier/notifier.dart';
import 'package:hr_and_crm/repository/jobroles/notifier/notifier.dart';
import 'package:hr_and_crm/repository/leaveTypes/notifier/leaveTypes.notifier.dart';
import 'package:hr_and_crm/repository/login/notifier/login.notifier.dart';
import 'package:hr_and_crm/repository/remove%20workreport/remove%20workreport.dart';
import 'package:hr_and_crm/ui/add%20expense/notifier/notifier.dart';
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
  ChangeNotifierProvider<leaveRequestNotifier>(create: (context) => leaveRequestNotifier(),),  
  ChangeNotifierProvider<ClockINNotifier>(create: (context) => ClockINNotifier(),),
  ChangeNotifierProvider<ClockOUTNotifier>(create: (context) => ClockOUTNotifier(),),
  ChangeNotifierProvider<AddHolidayNotifier>(create: (context) => AddHolidayNotifier(),),
  ChangeNotifierProvider<AttendanceReportNotifier>(create: (context) => AttendanceReportNotifier(),),
  ChangeNotifierProvider<AbsentAllNotifier>(create: (context) => AbsentAllNotifier(),),
  ChangeNotifierProvider<AddBranchersNotifier>(create: (context) => AddBranchersNotifier(),),
  ChangeNotifierProvider<ClockInViewNotifier>(create: (context)=> ClockInViewNotifier()),
  ChangeNotifierProvider<EditLeaveTyesNotifier>(create: (context) => EditLeaveTyesNotifier(),),
  ChangeNotifierProvider<LeaveTypeRemoveNotifier>(create: (context) => LeaveTypeRemoveNotifier(),),
  ChangeNotifierProvider<AddLeaveTypeNotifier>(create: (context) => AddLeaveTypeNotifier(),),
  ChangeNotifierProvider<HrWorkReportsNotifier>(create: (context) => HrWorkReportsNotifier(),),
  ChangeNotifierProvider<EmployeeLeaveRequistsNotifier>(create: (context) => EmployeeLeaveRequistsNotifier(),),
  ChangeNotifierProvider<JobRolesNotifier>(create: (context) => JobRolesNotifier(),),
  ChangeNotifierProvider<AddEmployeeExpenseNotifier>(create: (context) => AddEmployeeExpenseNotifier(),),
  ChangeNotifierProvider<EditWorkreportNotifier>(create: (context) => EditWorkreportNotifier(),),
  ChangeNotifierProvider<AddExpenseNotifier>(create: (context) => AddExpenseNotifier(),),
  ChangeNotifierProvider<RemoveWorkreportNotifier>(create: (context) => RemoveWorkreportNotifier(),),
  ChangeNotifierProvider<EmployeeAssignedWorkShiftNotier>(create: (context) => EmployeeAssignedWorkShiftNotier(),)
];
import 'package:flutter/material.dart';

import '../network/add_branch_networking.dart';

class AddBranchersNotifier extends ChangeNotifier {
  addBranch(
      {required String branchname,
      required String address,
      required BuildContext context}) async {
    AddBranchNetworking()
        .addBranch(branchName: branchname, address: address, context: context);
  }
}

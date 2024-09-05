import 'package:admin_grocery/utils/app-constant.dart';
import 'package:flutter/material.dart';

import '../widget/admin-drawer-widget.dart';
class AdminMainScreen extends StatefulWidget {
  const AdminMainScreen({super.key});

  @override
  State<AdminMainScreen> createState() => _AdminMainScreenState();
}

class _AdminMainScreenState extends State<AdminMainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Screen'),
        backgroundColor: AppConstant.appMainColor,
      ),
      drawer: const DrawerWidget(),
      body: Text('data'),
    );
  }
}

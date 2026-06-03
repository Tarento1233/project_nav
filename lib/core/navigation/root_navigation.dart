import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/store_provider.dart';
import 'user_tab_navigation.dart';
import 'admin_navigation.dart';

class RootNavigation extends StatelessWidget {
  const RootNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<StoreProvider>(context);
    return store.isAdmin ? const AdminNavigation() : const UserTabNavigation();
  }
}


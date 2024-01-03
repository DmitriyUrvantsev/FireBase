import 'package:firebase_2/domain/entity/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screen/auth/auth.dart';
import 'screen/home/home.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserApp?>(context);

    if (user?.uid == null) {
      return const Authenticate();
    } else {
      return const Home();
    }
  }
}

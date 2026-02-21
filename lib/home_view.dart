import 'package:flutter/material.dart';

import 'components/home_view_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: ListView(
            children: [
              const Text(
                "Employee Information",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              const HomeViewBody(),
            ],
          ),
        ),
      ),
    );
  }
}

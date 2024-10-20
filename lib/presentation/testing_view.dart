import 'package:bac_files_admin/core/resources/styles/decoration_resources.dart';
import 'package:bac_files_admin/core/resources/styles/sizes_resources.dart';
import 'package:flutter/material.dart';
import '../core/resources/styles/padding_resources.dart';

class TestingView extends StatefulWidget {
  const TestingView({super.key});

  @override
  State<TestingView> createState() => _TestingViewState();
}

class _TestingViewState extends State<TestingView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [],
        ),
      ),
    );
  }
}

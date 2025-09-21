import 'package:elevate_tracking_app/presentation/auth/apply/views/widgets/application_approved_view_body.dart';
import 'package:flutter/material.dart';

class ApplicationApprovedScreen extends StatelessWidget {
  const ApplicationApprovedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: SafeArea(child: ApplicationApprovedViewBody()));
  }
}

import 'package:bac_files/core/resources/styles/font_styles_manager.dart';
import 'package:bac_files/core/resources/styles/padding_resources.dart';
import 'package:bac_files/core/services/router/index.dart';
import 'package:bac_files/core/widgets/dialogs/conform_dialog.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/injector/app_injection.dart';
import '../../../core/services/router/app_routes.dart';
import '../../auth/state/bloc/auth_bloc.dart';
import '../../home/widgets/switch_theme_widget.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [
          SwitchThemeWidget(),
        ],
      ),
      body: Column(
        children: [
          SettingsTouchableTileWidget(
            title: "تغيير بيانات الحساب",
            icon: Icons.edit,
            onPressed: () {
              context.pushReplacement(AppRoutes.updateUserData.path);
            },
          ),
          SettingsTouchableTileWidget(
            title: "تقارير الأخطاء",
            icon: Icons.bug_report,
            onPressed: () {
              context.pushReplacement(AppRoutes.debugs.path);
            },
          ),
          SettingsTouchableTileWidget(
            title: "تسجيل الخروج",
            icon: Icons.logout,
            onPressed: () {
              showConformDialog(
                context: context,
                title: "تسجيل الخروج",
                body: "هل انت متاكد من انك تريد تسجيل الخروج؟",
                action: "تسجيل الخروج",
                onConform: () {
                  sl<AuthBloc>().add(const AuthSignOutEvent());
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class SettingsTouchableTileWidget extends StatelessWidget {
  const SettingsTouchableTileWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.onPressed,
  });
  final String title;
  final IconData icon;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).colorScheme.outlineVariant,
          ),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          child: Padding(
            padding: PaddingResources.customPadding(6, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //
                Text(
                  title,
                  style: FontStylesResources.buttonStyle,
                ),
                //
                Icon(icon, size: 18),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

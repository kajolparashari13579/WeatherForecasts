import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterdemo/about_us.dart';
import 'package:flutterdemo/theme/theme_bloc.dart';
import 'package:flutterdemo/theme/theme_state.dart';
import 'package:flutterdemo/utils/enum_to_string.dart';
import 'package:flutterdemo/utils/route_util.dart';
import 'package:flutterdemo/webview_screen.dart';

import 'temp_settings/temp_settings_cubit.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(centerTitle: true, title: const Text('Settings')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _itemBuilder(context),
          _itemBuilderTheme(context),
          Padding(
            padding: const EdgeInsets.only(left: 18, top: 10),
            child: new GestureDetector(
              onTap: () {
               RouteUtil.navigateTo(context, const WebViewScreen());
              },
              child: const Text(
                "About Us",
                style: TextStyle(fontSize: 16),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _itemBuilder(BuildContext context) {
    return BlocBuilder<TempSettingsCubit, TempSettingsState>(
      builder: (context, state) {
        return ListTile(
          title: Text('Temparature Unit: ${state.tempUnit.enumToString()}'),
          subtitle: const Text('Celsius/Fahrenheit (Default: Celsius)'),
          trailing: Switch(
            activeColor: Theme.of(context).colorScheme.primary,
            inactiveTrackColor:
                Theme.of(context).colorScheme.onPrimaryContainer,
            inactiveThumbColor: Theme.of(context).colorScheme.primaryContainer,
            value: state.tempUnit == TempUnit.Celsius,
            onChanged: (_) {
              context.read<TempSettingsCubit>().toggleTempUnit();
            },
          ),
        );
      },
    );
  }

  Widget _itemBuilderTheme(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        return ListTile(
          title: const Text('Dark Mode'),
          trailing: Switch(
            activeColor: Theme.of(context).colorScheme.primary,
            inactiveTrackColor:
                Theme.of(context).colorScheme.onPrimaryContainer,
            inactiveThumbColor: Theme.of(context).colorScheme.primaryContainer,
            value: isDark,
            onChanged: (value) {
              if (value) {
                context.read<ThemeBloc>().add(ThemeEvent.toggleDark);
              } else {
                context.read<ThemeBloc>().add(ThemeEvent.toggleLight);
              }
            },
          ),
        );
      },
    );
  }
}

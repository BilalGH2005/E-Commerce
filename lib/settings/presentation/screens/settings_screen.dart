import 'package:e_commerce/core/constants/app_links.dart';
import 'package:e_commerce/core/models/webview_page_args.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/shortcuts.dart';

import 'package:e_commerce/core/constants/app_breakpoints.dart';
import 'package:e_commerce/core/widgets/app_dropdown_button.dart';
import 'package:e_commerce/settings/presentation/controllers/settings_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_routes.dart';
import '../../../core/constants/assets.gen.dart';
import '../../../core/controllers/app_cubit.dart';
import '../../../core/utils/snackbar_util.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  Widget _sectionLabel(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 10),
      child: Text(
        text,
        style: textTheme(context).bodyMedium?.copyWith(
          letterSpacing: 0.5,
          color: colorScheme(context).onSurfaceVariant,
        ),
      ),
    );
  }

  Widget _opaqueCard(BuildContext context, Widget child) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        color: colorScheme(context).surfaceContainerHighest.withAlpha(127),
        border: Border.all(color: colorScheme(context).tertiary),
        boxShadow: [
          BoxShadow(
            color: colorScheme(context).shadow.withAlpha(30),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _settingRow(
    BuildContext context, {
    required String text,
    Widget? icon,
    Widget? trailing,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 22),
        child: Row(
          children: [
            ?icon,
            if (icon != null) const SizedBox(width: 16),
            Expanded(
              child: Text(text, style: textTheme(context).displayMedium),
            ),
            ?trailing,
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocListener<SettingsCubit, SettingsState>(
          listenWhen: (_, state) =>
              state is SettingsSignOutSuccess ||
              state is SettingsSignOutFailure,
          listener: (context, state) {
            if (state is SettingsSignOutSuccess) {
              context.goNamed(AppRoutes.auth.name);
            } else if (state is SettingsSignOutFailure) {
              SnackBarUtil.showError(
                localization(context).authError(state.errorCode),
              );
            }
          },
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: AppBreakpoints.kTabletWidth,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 28,
                    ),
                    child: BlocBuilder<AppCubit, AppState>(
                      builder: (context, _) {
                        final cubit = context.read<AppCubit>();
                        final locale = Localizations.localeOf(
                          context,
                        ).languageCode;
                        return SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(24),
                                decoration: BoxDecoration(
                                  color: colorScheme(context).primary,
                                  borderRadius: BorderRadius.circular(30),
                                  boxShadow: [
                                    BoxShadow(
                                      color: colorScheme(
                                        context,
                                      ).primary.withAlpha(100),
                                      blurRadius: 40,
                                      offset: const Offset(0, 20),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          Assets.icons.settings,
                                          colorFilter: ColorFilter.mode(
                                            colorScheme(context).onPrimary,
                                            BlendMode.srcIn,
                                          ),
                                          height: 30,
                                        ),
                                        const SizedBox(width: 12),
                                        Text(
                                          localization(context).settings,
                                          style: textTheme(context).displaySmall
                                              ?.copyWith(
                                                color: colorScheme(
                                                  context,
                                                ).onPrimary,
                                                fontWeight: FontWeight.w700,
                                              ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      localization(context).settings,
                                      style: textTheme(context).bodyLarge
                                          ?.copyWith(
                                            color: colorScheme(
                                              context,
                                            ).onPrimary.withAlpha(228),
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                              _sectionLabel(
                                context,
                                localization(context).generalSettings,
                              ),
                              _opaqueCard(
                                context,
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    _settingRow(
                                      context,
                                      icon: SvgPicture.asset(
                                        Assets.icons.theme,
                                        colorFilter: ColorFilter.mode(
                                          colorScheme(context).primary,
                                          BlendMode.srcIn,
                                        ),
                                        height: 26,
                                      ),
                                      text: localization(context).theme,
                                      trailing: Transform.scale(
                                        scale: 0.8,
                                        child: Switch(
                                          value: cubit.isDarkTheme,
                                          onChanged: (newValue) =>
                                              cubit.toggleTheme(newValue),
                                        ),
                                      ),
                                      onTap: () =>
                                          cubit.toggleTheme(!cubit.isDarkTheme),
                                    ),
                                    Divider(height: 1),
                                    _settingRow(
                                      context,
                                      icon: SvgPicture.asset(
                                        Assets.icons.globe,
                                        colorFilter: ColorFilter.mode(
                                          colorScheme(context).primary,
                                          BlendMode.srcIn,
                                        ),
                                        height: 26,
                                      ),
                                      text: localization(context).language,
                                      trailing: SizedBox(
                                        width: 140,
                                        child: AppDropdownButton(
                                          items: ['English', 'عربي'],
                                          value: cubit.isArabic
                                              ? 'عربي'
                                              : 'English',
                                          onChanged: (newValue) async =>
                                              await cubit.localeValue(newValue),
                                        ),
                                      ),
                                      onTap: () {},
                                    ),
                                  ],
                                ),
                              ),
                              _sectionLabel(
                                context,
                                localization(context).others,
                              ),
                              _opaqueCard(
                                context,
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    _settingRow(
                                      context,
                                      icon: SvgPicture.asset(
                                        Assets.icons.info,
                                        colorFilter: ColorFilter.mode(
                                          colorScheme(context).primary,
                                          BlendMode.srcIn,
                                        ),
                                        height: 26,
                                      ),
                                      text: localization(
                                        context,
                                      ).termsOfService,
                                      onTap: () {
                                        context.pushNamed(
                                          AppRoutes.webview.name,
                                          extra: WebViewPageArgs(
                                            url: AppLinks.termsOfServiceLink(
                                              locale,
                                            ),
                                            title: localization(
                                              context,
                                            ).termsOfService,
                                          ),
                                        );
                                      },
                                    ),
                                    const Divider(height: 1),
                                    _settingRow(
                                      context,
                                      icon: SvgPicture.asset(
                                        Assets.icons.info,
                                        colorFilter: ColorFilter.mode(
                                          colorScheme(context).primary,
                                          BlendMode.srcIn,
                                        ),
                                        height: 26,
                                      ),
                                      text: localization(context).privacyPolicy,
                                      onTap: () {
                                        context.pushNamed(
                                          AppRoutes.webview.name,
                                          extra: WebViewPageArgs(
                                            url: AppLinks.privacyPolicyLink(
                                              locale,
                                            ),
                                            title: localization(
                                              context,
                                            ).privacyPolicy,
                                          ),
                                        );
                                      },
                                    ),
                                    const Divider(height: 1),
                                    _settingRow(
                                      context,
                                      icon: SvgPicture.asset(
                                        Assets.icons.signOut,
                                        colorFilter: ColorFilter.mode(
                                          colorScheme(context).primary,
                                          BlendMode.srcIn,
                                        ),
                                        height: 26,
                                      ),
                                      text: localization(context).signOut,
                                      onTap: () {
                                        context.read<SettingsCubit>().signOut();
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),
                              Center(
                                child: SizedBox(
                                  width: constraints.maxWidth > 480
                                      ? 320
                                      : double.infinity,
                                ),
                              ),
                              const SizedBox(height: 40),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

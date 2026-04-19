import 'package:e_commerce/core/constants/app_links.dart';
import 'package:e_commerce/core/models/webview_page_args.dart';
import 'package:e_commerce/settings/presentation/widgets/profile_card.dart';
import 'package:e_commerce/settings/presentation/widgets/settings_opaque_card.dart';
import 'package:e_commerce/settings/presentation/widgets/settings_row.dart';
import 'package:e_commerce/settings/presentation/widgets/settings_section_label.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocListener<SettingsCubit, SettingsState>(
          listenWhen: (_, state) =>
          state is SettingsSignOutSuccess ||
              state is SettingsSignOutFailure ||
              state is AccountDeletionIsFailed ||
              state is AccountIsDeletedSuccessfully,
          listener: (context, state) {
            if (state is SettingsSignOutSuccess) {
              context.goNamed(AppRoutes.auth.name);
            } else if (state is SettingsSignOutFailure) {
              SnackBarUtil.showError(
                localization(context).authError(state.errorCode),
              );
            } else if (state is AccountDeletionIsFailed) {
              SnackBarUtil.showError(
                localization(context).accountDeletionIsFailed,
              );
            } else if (state is AccountIsDeletedSuccessfully) {
              context.goNamed(AppRoutes.auth.name);
            }
          },
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: AppBreakpoints.kTabletWidth,
                    minHeight: double.infinity,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 28,
                    ),
                    child: BlocBuilder<AppCubit, AppState>(
                      builder: (context, _) {
                        final cubit = context.read<AppCubit>();
                        final locale = Localizations
                            .localeOf(
                          context,
                        )
                            .languageCode;
                        final themeLabels = locale == 'ar'
                            ? {
                          'system': 'افتراضي النظام',
                          'light': 'فاتح',
                          'dark': 'داكن',
                        }
                            : {
                          'system': 'System default',
                          'light': 'Light',
                          'dark': 'Dark',
                        };
                        final selectedTheme = switch (cubit.themeMode) {
                          ThemeMode.light => 'light',
                          ThemeMode.dark => 'dark',
                          ThemeMode.system => 'system',
                        };
                        final selectedLocale =
                            cubit.locale?.languageCode ?? 'system';
                        final localeLabels = locale == 'ar'
                            ? {
                          'system': 'افتراضي النظام',
                          'en': 'الإنجليزية',
                          'ar': 'العربية',
                        }
                            : {
                          'system': 'System default',
                          'en': 'English',
                          'ar': 'Arabic',
                        };
                        return SingleChildScrollView(
                          child: StreamBuilder(
                            stream:
                            Supabase.instance.client.auth.onAuthStateChange,
                            builder: (context, snapshot) {
                              final user =
                                  snapshot.data?.session?.user ??
                                      Supabase.instance.client.auth.currentUser;
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ProfileCard(user: user),
                                  SettingsSectionLabel(
                                    text: localization(context).profile,
                                  ),
                                  SettingsOpaqueCard(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SettingsRow(
                                          icon: SvgPicture.asset(
                                            Assets.icons.person,
                                            colorFilter: ColorFilter.mode(
                                              colorScheme(context).primary,
                                              BlendMode.srcIn,
                                            ),
                                            height: 26,
                                          ),
                                          text: localization(
                                            context,
                                          ).editProfile,
                                          onTap: () {
                                            context.pushNamed(
                                              AppRoutes.profile.name,
                                            );
                                          },
                                        ),
                                        const Divider(height: 1),
                                        SettingsRow(
                                          icon: SvgPicture.asset(
                                            Assets.icons.trash,
                                            colorFilter: ColorFilter.mode(
                                              colorScheme(context).primary,
                                              BlendMode.srcIn,
                                            ),
                                            height: 26,
                                          ),
                                          text: localization(
                                            context,
                                          ).deleteAccount,
                                          onTap: () async {
                                            await context
                                                .read<SettingsCubit>()
                                                .showDeleteAccountDialog(
                                                context: context,
                                                userId: user!.id);
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  SettingsSectionLabel(
                                    text: localization(context).appearance,
                                  ),
                                  SettingsOpaqueCard(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SettingsRow(
                                          icon: SvgPicture.asset(
                                            Assets.icons.theme,
                                            colorFilter: ColorFilter.mode(
                                              colorScheme(context).primary,
                                              BlendMode.srcIn,
                                            ),
                                            height: 26,
                                          ),
                                          text: localization(context).theme,
                                          trailing: SizedBox(
                                            width: 170,
                                            child: AppDropdownButton(
                                              items: themeLabels.keys.toList(),
                                              itemLabels: themeLabels,
                                              value: selectedTheme,
                                              onChanged: (newValue) async =>
                                              await cubit.setThemeMode(
                                                newValue,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const Divider(height: 1),
                                        SettingsRow(
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
                                            width: 170,
                                            child: AppDropdownButton(
                                              items: localeLabels.keys.toList(),
                                              itemLabels: localeLabels,
                                              value: selectedLocale,
                                              onChanged: (newValue) async =>
                                              await cubit.setLocale(
                                                newValue,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SettingsSectionLabel(
                                    text: localization(context).others,
                                  ),
                                  SettingsOpaqueCard(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SettingsRow(
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
                                                url:
                                                AppLinks.termsOfServiceLink(
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
                                        SettingsRow(
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
                                          ).privacyPolicy,
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
                                        SettingsRow(
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
                                            context
                                                .read<SettingsCubit>()
                                                .signOut();
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
                              );
                            },
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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../l10n.dart';
import '../../core/utils/display_util.dart';
import '../../routes/pages.dart';
import 'controller.dart';

class SettingsPage extends GetView<SettingsController> {
  const SettingsPage({super.key});

  Widget _buildLanguageSetting(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            L10n.of(context).language,
            style: const TextStyle(fontSize: 17.5),
          ),
        ),
        PopupMenuButton(
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Theme.of(context).cardColor),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Row(
              children: [
                Obx(
                  () => Text(
                    controller.getCurrentLanguageName(),
                    style: const TextStyle(fontSize: 15, color: Colors.grey),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                const FaIcon(
                  FontAwesomeIcons.chevronDown,
                  size: 15,
                  color: Colors.grey,
                )
              ],
            ),
          ),
          itemBuilder: (context) {
            return L10n.languageMap.keys
                .map((e) => PopupMenuItem(
                      value: e,
                      child: Text(
                        L10n.languageMap[e]!,
                      ),
                    ))
                .toList();
          },
          onSelected: (value) {
            controller.configService.localeCode = value;
          },
        )
      ],
    );
  }

  Widget _buildThemeSetting(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            L10n.of(context).theme,
            style: const TextStyle(fontSize: 17.5),
          ),
        ),
        PopupMenuButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Theme.of(context).cardColor,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Row(
                children: [
                  Obx(
                    () => Text(
                      controller.getCurrentThemeName(context),
                      style: const TextStyle(fontSize: 15, color: Colors.grey),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const FaIcon(
                    FontAwesomeIcons.chevronDown,
                    size: 15,
                    color: Colors.grey,
                  )
                ],
              )),
          itemBuilder: (context) {
            return [
              PopupMenuItem(
                value: ThemeMode.system,
                child: Text(
                  L10n.of(context).theme_system,
                ),
              ),
              PopupMenuItem(
                value: ThemeMode.light,
                child: Text(
                  L10n.of(context).theme_light_mode,
                ),
              ),
              PopupMenuItem(
                value: ThemeMode.dark,
                child: Text(
                  L10n.of(context).theme_dark_mode,
                ),
              ),
            ];
          },
          onSelected: (value) {
            controller.configService.themeMode = value;
          },
        )
      ],
    );
  }

  Widget _buildEnableAdultCoverBlur(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            L10n.of(context).setting_cover_blur,
            style: const TextStyle(fontSize: 17.5),
          ),
        ),
        Obx(
          () => Container(
            height: 20,
            margin: const EdgeInsets.only(left: 10),
            child: CupertinoSwitch(
              value: controller.configService.adultCoverBlur,
              activeColor: Theme.of(context).primaryColor,
              onChanged: (value) {
                controller.configService.adultCoverBlur = value;
              },
            ),
          ),
        )
      ],
    );
  }

  Widget _buildEnableAutoPlay(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            L10n.of(context).setting_auto_play,
            style: const TextStyle(fontSize: 17.5),
          ),
        ),
        Obx(
          () => Container(
            height: 20,
            margin: const EdgeInsets.only(left: 10),
            child: CupertinoSwitch(
              value: controller.configService.autoPlay,
              activeColor: Theme.of(context).primaryColor,
              onChanged: (value) {
                controller.configService.autoPlay = value;
              },
            ),
          ),
        )
      ],
    );
  }

  Widget _buildEnableNotificationPlayer(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            L10n.of(context).setting_notification_player,
            style: const TextStyle(fontSize: 17.5),
          ),
        ),
        Obx(
          () => Container(
            height: 20,
            margin: const EdgeInsets.only(left: 10),
            child: CupertinoSwitch(
              value: controller.configService.notificationPlayer,
              activeColor: Theme.of(context).primaryColor,
              onChanged: (value) {
                controller.configService.notificationPlayer = value;
              },
            ),
          ),
        )
      ],
    );
  }

  Widget _buildEnableBiometric(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            L10n.of(context).unlock_by_biometric,
            style: const TextStyle(fontSize: 17.5),
          ),
        ),
        Obx(
          () => Container(
            height: 20,
            margin: const EdgeInsets.only(left: 10),
            child: CupertinoSwitch(
              value: controller.autoLockService.enableAuthByBiometrics,
              activeColor: Theme.of(context).primaryColor,
              onChanged: (value) {
                if (value) {
                  controller.getBiometricsAuth().then((value) {
                    controller.autoLockService.enableAuthByBiometrics = value;
                  });
                } else {
                  controller.autoLockService.enableAuthByBiometrics = value;
                }
              },
            ),
          ),
        )
      ],
    );
  }

  Widget _buildEnableAutoLock(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            L10n.of(context).setting_auto_lock,
            style: const TextStyle(fontSize: 17.5),
          ),
        ),
        Obx(
          () => Container(
            height: 20,
            margin: const EdgeInsets.only(left: 10),
            child: CupertinoSwitch(
              value: controller.autoLockService.enableAutoLock,
              activeColor: Theme.of(context).primaryColor,
              onChanged: (value) {
                if (value) {
                  Get.toNamed(AppRoutes.setPassword)?.then((value) {
                    if (value is bool) {
                      controller.autoLockService.enableAutoLock = value;
                    }
                  });
                } else {
                  controller.autoLockService.enableAutoLock = value;
                }
              },
            ),
          ),
        )
      ],
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return InkWell(
      onTap: controller.logout,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
              L10n.of(context).logout,
              style: const TextStyle(fontSize: 17.5),
            ),
          ),
          const FaIcon(FontAwesomeIcons.rightToBracket, color: Colors.grey),
        ],
      ),
    );
  }

  Widget _buildCheckUpdateButton(BuildContext context) {
    return InkWell(
      onTap: () {
        controller.configService.checkLatestVersion(
          showNoAvailable: true,
          noAvailableMessage: L10n.of(context).no_update_available,
        );
      },
      child: Text(
        L10n.of(context).check_update,
        style: const TextStyle(fontSize: 17.5),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    DisplayUtil.reset(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const FaIcon(FontAwesomeIcons.chevronLeft),
        ),
        shape: Border(
          bottom: BorderSide(
            color: Theme.of(context).dividerColor,
            width: 0,
          ),
        ),
        centerTitle: true,
        title: Text(
          L10n.of(context).user_settings,
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            SettingTitle(title: L10n.of(context).setting_appearance),
            SettingGroup(
              children: [
                _buildThemeSetting(context),
                _buildLanguageSetting(context),
              ],
            ),
            SettingTitle(title: L10n.of(context).setting_player),
            SettingGroup(
              children: [
                _buildEnableAutoPlay(context),
                _buildEnableNotificationPlayer(context),
              ],
            ),
            SettingTitle(title: L10n.of(context).setting_security),
            Obx(
              () => SettingGroup(
                children: [
                  _buildEnableAdultCoverBlur(context),
                  _buildEnableAutoLock(context),
                  if (controller.autoLockService.enableAutoLock)
                    _buildEnableBiometric(context),
                ],
              ),
            ),
            if (controller.accountService.isLogin)
              SettingGroup(
                children: [
                  _buildLogoutButton(context),
                ],
              ),
            SettingGroup(
              children: [
                _buildCheckUpdateButton(context),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SettingTitle extends StatelessWidget {
  final String title;

  const SettingTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 17.5,
        ),
      ),
    );
  }
}

class SettingGroup extends StatelessWidget {
  final List<Widget> children;

  const SettingGroup({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).canvasColor,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.5),
            child: children[index],
          );
        },
        separatorBuilder: (context, index) {
          return Divider(
            thickness: 1,
            color: Theme.of(context).dividerColor,
          );
        },
        itemCount: children.length,
      ),
    );
  }
}

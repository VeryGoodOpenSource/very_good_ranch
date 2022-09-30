import 'package:flutter/material.dart';
import 'package:ranch_ui/ranch_ui.dart';
import 'package:very_good_ranch/game_menu/game_menu.dart';
import 'package:very_good_ranch/l10n/l10n.dart';

class CreditsDialogPage extends StatelessWidget {
  const CreditsDialogPage({super.key});

  static const maxDialogWidth = 400.0;
  static const maxDialogHeight = 620.0;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return ModalScaffold(
      title: Text(l10n.credits),
      body: const _CreditsContent(),
      footer: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed<void, void>(
                GameMenuRoute.settings.name,
              );
            },
            child: Text(l10n.ok),
          ),
        ],
      ),
    );
  }
}

class _CreditsContent extends StatelessWidget {
  const _CreditsContent({Key? key}) : super(key: key);

  List<Widget> creditsSection({
    required String title,
    required List<String> names,
  }) {
    return [
      Text(
        title,
        style: const TextStyle(
          fontSize: 19,
          fontWeight: FontWeight.w700,
          height: 1.6,
        ),
      ),
      ...names.map(
        (e) => Text(
          e,
          style: const TextStyle(
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      const SizedBox(
        height: 20,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return DefaultTextStyle.merge(
      textAlign: TextAlign.center,
      style: RanchUITheme.minorFontTextStyle.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        height: 1.45,
      ),
      child: ListBody(
        children: [
          const Text(
            'Very Good Ranch',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w700,
              height: 1.4,
            ),
          ),
          const Text(
            'By Very Good Ventures',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(
            height: 18,
          ),
          ...creditsSection(
            title: 'Programming',
            names: [
              'Erick Zanardo',
              'Felix Angelov',
              'Jochum Van Der Ploeg',
              'Renan Araujo',
            ],
          ),
          ...creditsSection(
            title: 'Music',
            names: [
              '"Sunset Memory" by Beatrice Mitchell',
            ],
          ),
          ...creditsSection(
            title: 'Art and UI design',
            names: [
              'Very Good Ventures Design Team',
              'HOPR',
            ],
          ),
          const SizedBox(
            height: 9,
          ),
          const Text(
            'Libraries',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w700,
              height: 1.6,
            ),
          ),
          TextButton(
            onPressed: () {
              showLicensePage(
                context: context,
                useRootNavigator: true,
              );
            },
            child: Text(
              'Show open source licenses',
              style: RanchUITheme.minorFontTextStyle.copyWith(
                color: const Color(0xFF46B2A0),
                fontSize: 19,
                fontWeight: FontWeight.w700,
                height: 1.6,
              ),
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          const Text(
            'No Unicorns were harmed in the making of this game',
            style: TextStyle(
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(
            height: 18,
          ),
        ],
      ),
    );
  }
}

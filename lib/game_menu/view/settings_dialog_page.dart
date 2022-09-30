import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ranch_ui/ranch_ui.dart';
import 'package:very_good_ranch/game_menu/game_menu.dart';
import 'package:very_good_ranch/l10n/l10n.dart';

class SettingsDialogPage extends StatelessWidget {
  const SettingsDialogPage({
    super.key,
  });

  static const maxDialogHeight = 310.0;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        return ModalScaffold(
          title: Text(l10n.settings),
          body: SizedBox(
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              child: ColoredBox(
                color: const Color(0x14000000),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      Text(
                        l10n.musicVolume((state.musicVolume * 100).round()),
                        style: const TextStyle(
                          fontSize: 18,
                          color: Color(0xFF674FB2),
                        ),
                      ),
                      Slider(
                        value: state.musicVolume,
                        onChanged: (v) {
                          context
                              .read<SettingsBloc>()
                              .add(MusicVolumeChanged(v));
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          footer: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacementNamed<void, void>(
                          GameMenuRoute.instructions.name,
                        );
                      },
                      child: Text(l10n.help),
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Flexible(
                    flex: 3,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacementNamed<void, void>(
                          GameMenuRoute.credits.name,
                        );
                      },
                      child: Text(l10n.credits),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

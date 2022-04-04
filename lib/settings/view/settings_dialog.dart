import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good_ranch/l10n/l10n.dart';
import 'package:very_good_ranch/settings/bloc/settings/settings_bloc.dart';

class SettingsDialog extends StatelessWidget {
  const SettingsDialog({Key? key}) : super(key: key);

  static const overlayKey = 'settings';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = context.l10n;

    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: BlocBuilder<SettingsBloc, SettingsState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(l10n.settings, style: theme.textTheme.headline6),
                ),
                const SizedBox(height: 8),
                Text(l10n.audioSettings, style: theme.textTheme.headline6),
                const SizedBox(height: 8),
                Text(l10n.musicVolume((state.musicVolume * 100).round())),
                Slider(
                  key: const Key('musicVolumeSlider'),
                  value: state.musicVolume,
                  onChanged: (v) {
                    context.read<SettingsBloc>()
                        .add(MusicVolumeChanged(v));
                  },
                ),
                Text(l10n.gameplayVolume((state.gameplayVolume * 100).round())),
                Slider(
                  key: const Key('gameplayVolumeSlider'),
                  value: state.gameplayVolume,
                  onChanged: (v) {
                    context.read<SettingsBloc>()
                        .add(GameplayVolumeChanged(v));
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ranch_ui/ranch_ui.dart';
import 'package:very_good_ranch/l10n/l10n.dart';
import 'package:very_good_ranch/settings/settings.dart';

class SettingsDialog extends StatelessWidget {
  @visibleForTesting
  const SettingsDialog({
    super.key,
    required this.onTapCredits,
    required this.onTapHelp,
  });

  static void open(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (_) => SettingsDialog(
        onTapCredits: () {},
        onTapHelp: () {},
      ),
    );
  }

  final VoidCallback onTapCredits;
  final VoidCallback onTapHelp;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        return Modal(
          title: Text(l10n.settings),
          content: ClipRRect(
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
                        context.read<SettingsBloc>().add(MusicVolumeChanged(v));
                      },
                    ),
                  ],
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
                    child: ElevatedButton(
                      onPressed: onTapHelp,
                      child: Text(l10n.help),
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  ElevatedButton(
                    onPressed: onTapCredits,
                    child: Text(l10n.credits),
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

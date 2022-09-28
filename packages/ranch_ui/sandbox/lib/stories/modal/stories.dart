import 'package:dashbook/dashbook.dart';
import 'package:flutter/material.dart';
import 'package:ranch_ui/ranch_ui.dart';

void addModalStories(Dashbook dashbook) {
  dashbook.storiesOf('Modal').add('Playground', (context) {
    return Builder(
      builder: (context) {
        return Center(
          child: BoardButton(
            child: const Text('Open'),
            onTap: () {
              showDialog<void>(
                context: context,
                barrierColor: const Color(0x00000000),
                builder: (_) => const ExampleDialog(),
              );
            },
          ),
        );
      },
    );
  });
}

class ExampleDialog extends StatefulWidget {
  const ExampleDialog({super.key});

  @override
  State<ExampleDialog> createState() => _ExampleDialogState();
}

class _ExampleDialogState extends State<ExampleDialog> {
  double value = 1;

  @override
  Widget build(BuildContext context) {
    return Modal(
      title: const Text('A modal'),
      content: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        child: Container(
          padding: const EdgeInsets.all(12),
          color: const Color(0x14000000),
          child: Column(
            children: [
              const Text(
                'Parararan',
                style: TextStyle(
                  color: Color(0xFF674FB2),
                ),
              ),
              Slider(
                value: value,
                max: 100,
                onChanged: (value) {
                  setState(() {
                    value = value;
                  });
                },
              ),
            ],
          ),
        ),
      ),
      footer: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {},
                child: const Text('Help'),
              ),
              const SizedBox(
                width: 16,
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Credits'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

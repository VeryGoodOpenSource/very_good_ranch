import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ranch_components/ranch_components.dart';
import 'package:very_good_ranch/inventory/inventory.dart';
import 'package:very_good_ranch/l10n/l10n.dart';

class InventoryDialog extends StatelessWidget {
  const InventoryDialog({super.key});

  static const overlayKey = 'inventory';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = context.l10n;

    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Center(
              child: Text(l10n.inventory, style: theme.textTheme.headline6),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: BlocBuilder<InventoryBloc, InventoryState>(
                builder: (context, state) {
                  return GridView(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    children: [
                      for (final type in FoodType.values)
                        Container(
                          decoration: BoxDecoration(border: Border.all()),
                          padding: const EdgeInsets.all(8),
                          child: Center(
                            child: FoodItemEntry(
                              key: Key('food_type_${type.name}'),
                              type: type,
                              count: state.foodItems
                                  .where((e) => e == type)
                                  .length,
                            ),
                          ),
                        ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

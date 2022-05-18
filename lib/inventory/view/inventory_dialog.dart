import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good_ranch/inventory/bloc/bloc.dart';
import 'package:very_good_ranch/inventory/widgets/widgets.dart';
import 'package:very_good_ranch/l10n/l10n.dart';

class InventoryDialog extends StatelessWidget {
  const InventoryDialog({Key? key}) : super(key: key);

  static const overlayKey = 'inventory';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = context.l10n;

    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: BlocBuilder<InventoryBloc, InventoryState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(l10n.inventory, style: theme.textTheme.headline6),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: constraints.maxWidth ~/ 100,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemCount: state.foodItems.length,
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: BoxDecoration(border: Border.all()),
                            padding: const EdgeInsets.all(8),
                            child: Center(
                              child: FoodItemEntry(
                                key: Key('food_item_$index'),
                                item: state.foodItems.elementAt(index),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

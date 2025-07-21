import 'package:flutter/material.dart';

void showModelSelectorDialog(
    BuildContext context,
    String initialSelectedModel,
    Function(String) onModelSelected,
    ) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    isDismissible: true,
    builder: (_) {
      return StatefulBuilder(
        builder: (context, setState) {
          String selectedModel = initialSelectedModel;

          Widget buildModelOption(String model) {
            final isSelected = model == selectedModel;
            return GestureDetector(
              onTap: () {
                setState(() => selectedModel = model);
                onModelSelected(model);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                margin: const EdgeInsets.symmetric(vertical: 6),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.grey[700] : Colors.grey[900],
                  borderRadius: BorderRadius.circular(12),
                  border: isSelected ? Border.all(color: Colors.lightBlueAccent, width: 2) : null,
                ),
                child: Row(
                  children: [
                    Icon(
                      isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      model.toUpperCase(),
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
              ),
            );
          }

          return DraggableScrollableSheet(
            initialChildSize: 0.4,
            maxChildSize: 0.6,
            minChildSize: 0.3,
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF1E1E1E).withOpacity(0.95),
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                ),
                padding: const EdgeInsets.all(16),
                child: ListView(
                  controller: scrollController,
                  children: [
                    const Text(
                      "Choose a model",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    const SizedBox(height: 16),
                    buildModelOption("gpt-3.5"),
                    buildModelOption("gpt-4"),
                    buildModelOption("gpt-4o"),
                  ],
                ),
              );
            },
          );
        },
      );
    },
  );
}
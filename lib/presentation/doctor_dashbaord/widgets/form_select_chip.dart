import 'package:animal_kart/presentation/doctor_dashbaord/app_colors.dart';
import 'package:flutter/material.dart';


class FormSelectChip extends StatelessWidget {
  final List<String> options;
  final String selected;
  final Function(String) onSelect;

  const FormSelectChip({
    super.key,
    required this.options,
    required this.selected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: options.map((opt) {
        bool isSelected = opt == selected;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          child: ChoiceChip(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            selected: isSelected,
            selectedColor: AppColors.teal,
            backgroundColor: Colors.white,
            elevation: isSelected ? 2.5 : 1,
            shadowColor: Colors.black12,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            label: Text(
              opt,
              style: TextStyle(
                fontSize: 15,
                color: isSelected ? Colors.white : AppColors.textDark,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              ),
            ),
            onSelected: (_) => onSelect(opt),
          ),
        );
      }).toList(),
    );
  }
}

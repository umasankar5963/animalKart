import 'package:animal_kart/models/buffalo.dart';
import 'package:animal_kart/models/health_log.dart';
import 'package:animal_kart/presentation/doctor_dashbaord/app_colors.dart';
import 'package:animal_kart/presentation/doctor_dashbaord/buffalo_controller/buffalo_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/form_select_chip.dart';



class HealthLogForm extends ConsumerStatefulWidget {
  final Buffalo buffalo;

  const HealthLogForm({super.key, required this.buffalo});

  @override
  ConsumerState<HealthLogForm> createState() => _HealthLogFormState();
}

class _HealthLogFormState extends ConsumerState<HealthLogForm> {
  // --- Controlled Values ---
  String health = "Good";
  String vaccination = "Up to Date";
  String heatCycle = "Normal";
  String pregnancy = "Not Pregnant";

  final milkCtrl = TextEditingController();
  final bodyCtrl = TextEditingController();
  final symptomsCtrl = TextEditingController();
  final treatmentCtrl = TextEditingController();
  final remarksCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.teal,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Health Log",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// ----------- Title Section -----------
            Text(
              "Daily Health Log",
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w800,
                color: AppColors.textDark,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "Buffalo ID: ${widget.buffalo.id}",
              style: TextStyle(fontSize: 15, color: AppColors.textGrey),
            ),

            const SizedBox(height: 16),

            /// DAY TAG BOX
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: AppColors.teal.withOpacity(0.09),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Text(
                "Day ${widget.buffalo.day}",
                style: TextStyle(
                  fontSize: 15,
                  color: AppColors.teal,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            const SizedBox(height: 28),

            _sectionTitle("Health Status *"),
            FormSelectChip(
              options: ["Excellent", "Good", "Fair", "Poor"],
              selected: health,
              onSelect: (v) => setState(() => health = v),
            ),

            const SizedBox(height: 28),
            _sectionTitle("Milk Output (Liters) *"),
            _inputBox(milkCtrl, "e.g. 12.5"),

            const SizedBox(height: 28),
            _sectionTitle("Vaccination Status *"),
            FormSelectChip(
              options: ["Up to Date", "Pending", "Overdue"],
              selected: vaccination,
              onSelect: (v) => setState(() => vaccination = v),
            ),

            const SizedBox(height: 28),
            _sectionTitle("Heat Cycle *"),
            FormSelectChip(
              options: ["Normal", "In Heat", "Not Observed"],
              selected: heatCycle,
              onSelect: (v) => setState(() => heatCycle = v),
            ),

            const SizedBox(height: 28),
            _sectionTitle("Pregnancy Status *"),
            FormSelectChip(
              options: ["Not Pregnant", "Suspected", "Confirmed", "Unknown"],
              selected: pregnancy,
              onSelect: (v) => setState(() => pregnancy = v),
            ),

            const SizedBox(height: 30),
            _sectionTitle("Body Condition *"),
            _textareaBox(bodyCtrl, "Describe the body condition"),

            const SizedBox(height: 30),
            _sectionTitle("Symptoms"),
            _textareaBox(symptomsCtrl, "Any visible symptoms"),

            const SizedBox(height: 30),
            _sectionTitle("Treatments Given"),
            _textareaBox(treatmentCtrl, "Any treatments provided"),

            const SizedBox(height: 30),
            _sectionTitle("Additional Remarks"),
            _textareaBox(remarksCtrl, "Any important notes"),

            const SizedBox(height: 40),

            /// SUBMIT BUTTON (iOS style width)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.teal,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 2,
                ),
                child: const Text(
                  "Submit Health Log",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // --------------- SUBMIT LOG ---------------
  void _submitForm() {
    if (milkCtrl.text.isEmpty || bodyCtrl.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill all required fields."),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final log = HealthLog(
      dayLabel: "Day ${widget.buffalo.day}",
      date: DateTime.now().toString().split(" ").first,
      healthStatus: health,
      milkOutput: milkCtrl.text,
      vaccination: vaccination,
      heatCycle: heatCycle,
      pregnancy: pregnancy,
      bodyCondition: bodyCtrl.text,
      symptoms: symptomsCtrl.text,
      treatments: treatmentCtrl.text,
      remarks: remarksCtrl.text,
    );

    ref.read(buffaloProvider.notifier).addLog(widget.buffalo.id, log);

    Navigator.pop(context);
  }

  // ---------- COMPONENT BUILDERS ----------

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w700,
        color: AppColors.textDark,
      ),
    );
  }

  Widget _inputBox(TextEditingController controller, String hint) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(18),
        boxShadow: AppShadow.card,
      ),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          hintStyle: TextStyle(color: AppColors.textGrey),
        ),
      ),
    );
  }

  Widget _textareaBox(TextEditingController controller, String hint) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(18),
        boxShadow: AppShadow.card,
      ),
      child: TextField(
        controller: controller,
        maxLines: 4,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          hintStyle: TextStyle(color: AppColors.textGrey),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class XStepper extends StatefulWidget {
  final List<Step> steps;
  final int currentStep;
  final ValueChanged<int> onStepContinue;
  final VoidCallback? onStepCancel;
  final ValueChanged<int> onStepTapped;

  const XStepper({
    required this.steps,
    required this.currentStep,
    required this.onStepContinue,
    this.onStepCancel,
    required this.onStepTapped,
  });

  @override
  _XStepperState createState() => _XStepperState();
}

class _XStepperState extends State<XStepper> {
  @override
  Widget build(BuildContext context) {
    return Stepper(
      steps: widget.steps,
      currentStep: widget.currentStep,
      onStepContinue: () {
        if (widget.currentStep < widget.steps.length - 1) {
          widget.onStepContinue(widget.currentStep + 1);
        }
      },
      onStepCancel: widget.onStepCancel,
      onStepTapped: widget.onStepTapped,
    );
  }
}

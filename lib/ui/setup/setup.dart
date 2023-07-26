import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  int _currentStep = 0;
  late List<Step> _steps;

  @override
  void initState() {
    super.initState();
    _steps = [
      const Step(
        title: Text('Personal Information'),
        content: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Phone Number'),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'OTP'),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Date of Birth'),
            ),
          ],
        ),
        isActive: true,
      ),
      const Step(
        title: Text('Contact Information'),
        content: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'City'),
            ),
          ],
        ),
        isActive: false,
      ),
      Step(
        title: const Text('Additional Details'),
        content: Column(
          children: [
            const TextField(
              decoration: InputDecoration(labelText: 'Gender'),
            ),
            const TextField(
              decoration: InputDecoration(labelText: 'Job Role'),
            ),
            const TextField(
              decoration: InputDecoration(labelText: 'Company'),
            ),
            const TextField(
              decoration: InputDecoration(labelText: 'Address'),
            ),
            ElevatedButton(
              onPressed: () {
                
              },
              child: const Text('Select Profile Picture'),
            ),
          ],
        ),
        isActive: false,
      ),
    ];
  }

  void _nextStep() {
    setState(() {
      _currentStep += 1;
      if (_currentStep >= _steps.length) {
        
      }
    });
  }

  void _previousStep() {
    setState(() {
      _currentStep -= 1;
      if (_currentStep < 0) {
        _currentStep = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registration'),
      ),
      body: Stepper(
        
        currentStep: _currentStep,
        steps: _steps,
        onStepContinue: _nextStep,
        onStepCancel: _previousStep,
        controlsBuilder: (context, details) {
          return Row(
            children: [
              ElevatedButton(
                onPressed: _previousStep,
                child: const Text('Previous'),
              ),
              ElevatedButton(
                onPressed: _nextStep,
                child: _currentStep == _steps.length - 1
                    ? const Text('Finish')
                    : const Text('Next'),
              ),
            ],
          );
        },
      ),
    );
  }
}

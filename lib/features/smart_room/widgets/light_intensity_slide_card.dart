import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../../core/core.dart';

class LightIntensitySliderCard extends StatefulWidget {
  const LightIntensitySliderCard({required this.room, super.key});

  final SmartRoom room;

  @override
  State<LightIntensitySliderCard> createState() =>
      _LightIntensitySliderCardState();
}

class _LightIntensitySliderCardState extends State<LightIntensitySliderCard> {
  final DatabaseReference _databaseRef = FirebaseDatabase.instance.ref();
  bool _isLightOn = false;
  double _lightValue = 0;

  @override
  void initState() {
    super.initState();
    _setupFirebaseListeners();
  }

  void _setupFirebaseListeners() {
    // Listen for light value changes
    _databaseRef.child('light').onValue.listen((event) {
      final data = event.snapshot.value;
      if (data != null) {
        setState(() {
          _lightValue = double.parse(data.toString());
          // Update light status based on value (0 = off, >0 = on)
          _isLightOn = _lightValue > 0;
        });
      }
    });

    // Listen for ledStatus changes if you want to sync with that
    _databaseRef.child('ledStatus').onValue.listen((event) {
      final data = event.snapshot.value;
      if (data != null) {
        setState(() {
          _isLightOn = data == 1;
          // If light is turned off via ledStatus, set value to 0
          if (!_isLightOn) _lightValue = 0;
        });
      }
    });
  }

  Future<void> _toggleLight(bool value) async {
    try {
      // Update both ledStatus and light values in Firebase
      await _databaseRef.update({
        'ledStatus': value ? 1 : 0,
        'light': value ? _lightValue.clamp(1, 100).toDouble() : 0,
      });
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to update light: $e')));
    }
  }

  Future<void> _updateLightIntensity(double value) async {
    try {
      // Only update if light is on or we're turning it on
      if (_isLightOn || value > 0) {
        await _databaseRef.update({
          'light': value.clamp(0, 100).toDouble(),
          'ledStatus': value > 0 ? 1 : 0,
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update light intensity: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SHCard(
      childrenPadding: const EdgeInsets.all(12),
      children: [
        _LightSwitcher(
          room: widget.room,
          isOn: _isLightOn,
          lightValue: _lightValue,
          onToggle: _toggleLight,
        ),
        Row(
          children: [
            const Icon(SHIcons.lightMin),
            Expanded(
              child: Slider(
                value: _lightValue,
                min: 0,
                max: 1000,
                divisions: 100,
                onChanged: _updateLightIntensity,
              ),
            ),
            const Icon(SHIcons.lightMax),
          ],
        ),
      ],
    );
  }
}

class _LightSwitcher extends StatelessWidget {
  const _LightSwitcher({
    required this.room,
    required this.isOn,
    required this.lightValue,
    required this.onToggle,
  });

  final SmartRoom room;
  final bool isOn;
  final double lightValue;
  final Function(bool) onToggle;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Flexible(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text('Light intensity'),
          ),
        ),
        Flexible(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              '${lightValue.round() / 10}%',
              style: const TextStyle(fontSize: 20),
            ),
          ),
        ),
        //SHSwitcher(value: isOn, onChanged: onToggle),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../../core/core.dart';

class LightsAndTimerSwitchers extends StatefulWidget {
  const LightsAndTimerSwitchers({required this.room, super.key});

  final SmartRoom room;

  @override
  State<LightsAndTimerSwitchers> createState() =>
      _LightsAndTimerSwitchersState();
}

class _LightsAndTimerSwitchersState extends State<LightsAndTimerSwitchers> {
  final DatabaseReference _databaseRef = FirebaseDatabase.instance.ref();
  bool _isLight1On = false;
  bool _isLight2On = false;
  int _lightValue = 0;

  @override
  void initState() {
    super.initState();
    setupFirebaseListener();
  }

  void setupFirebaseListener() {
    _databaseRef.child('light').onValue.listen((event) {
      final data = event.snapshot.value;
      if (data != null) {
        setState(() {
          _lightValue = int.parse(data.toString());
          // _isLightOn = _lightValue > 0;
        });
      }
    });

    _databaseRef.child('led1Status').onValue.listen((event) {
      final data = event.snapshot.value;
      if (data != null) {
        setState(() {
          _isLight1On = data == 1;
        });
      }
    });

    _databaseRef.child('led2Status').onValue.listen((event) {
      final data = event.snapshot.value;
      if (data != null) {
        setState(() {
          _isLight2On = data == 1;
        });
      }
    });
  }

  Future<void> _toggleLightOne(bool value) async {
    try {
      await _databaseRef.update({'led1Status': value ? 1 : 0});
      setState(() {
        _isLight1On = value;
      });
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to update light: $e')));
    }
  }

  Future<void> _toggleLightTwo(bool value) async {
    try {
      await _databaseRef.update({'led2Status': value ? 1 : 0});
      setState(() {
        _isLight2On = value;
      });
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to update light: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SHCard(
      childrenPadding: const EdgeInsets.all(12),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Led one '),
            const SizedBox(height: 8),
            SHSwitcher(
              value: _isLight1On,
              onChanged: _toggleLightOne,
              icon: const Icon(SHIcons.lightBulbOutline),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(children: [Text('Led Two'), Spacer(), BlueLightDot()]),
            const SizedBox(height: 8),
            SHSwitcher(
              value: _isLight2On,
              onChanged: _toggleLightTwo,
              icon: const Icon(SHIcons.lightBulbOutline),
            ),
          ],
        ),
      ],
    );
  }
}

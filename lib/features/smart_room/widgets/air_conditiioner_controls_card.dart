import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../../core/core.dart';

class AirConditionerControlsCard extends StatefulWidget {
  const AirConditionerControlsCard({required this.room, super.key});

  final SmartRoom room;

  @override
  State<AirConditionerControlsCard> createState() =>
      _AirConditionerControlsCardState();
}

class _AirConditionerControlsCardState
    extends State<AirConditionerControlsCard> {
  final DatabaseReference _databaseRef = FirebaseDatabase.instance.ref();
  double _temperature = 0;
  int _humidity = 0;
  double _distance = 0.0;
  bool _isACOn = false;
  String _warning = "";

  @override
  void initState() {
    super.initState();
    _setupFirebaseListeners();
  }

  void _setupFirebaseListeners() {
    _databaseRef.child('temperature').onValue.listen((event) {
      final data = event.snapshot.value;
      if (data != null) {
        setState(() {
          _temperature = double.parse(data.toString());
        });
      }
    });

    // Listen for humidity changes
    _databaseRef.child('humidity').onValue.listen((event) {
      final data = event.snapshot.value;
      if (data != null) {
        setState(() {
          _humidity = int.parse(data.toString());
        });
      }
    });

    // Listen for distance changes
    _databaseRef.child('distance').onValue.listen((event) {
      final data = event.snapshot.value;
      if (data != null) {
        setState(() {
          _distance = double.parse(data.toString());
        });
      }
    });

    // Listen for warning messages
    _databaseRef.child('warning').onValue.listen((event) {
      final data = event.snapshot.value;
      if (data != null) {
        setState(() {
          _warning = data.toString();
        });
      }
    });
  }

  Future<void> _toggleAC(bool value) async {
    try {
      await _databaseRef.update({'acStatus': value ? 1 : 0});
      setState(() {
        _isACOn = value;
      });
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to update AC: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SHCard(
      childrenPadding: const EdgeInsets.all(12),
      children: [
        _AirSwitcher(
          isOn: _isACOn,
          temperature: _temperature,
          onToggle: _toggleAC,
        ),
        const _AirIcons(),
        Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color:
                    _warning.isNotEmpty
                        ? Colors.orange.withOpacity(0.1)
                        : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(
                        SHIcons.arrowUp,
                        color: Colors.white38,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Distance: ${_distance.toStringAsFixed(2)}m',
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          color: Colors.white60,
                        ),
                      ),
                    ],
                  ),
                  if (_warning.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(
                          Icons.warning,
                          color: Colors.orange,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            _warning,
                            style: GoogleFonts.montserrat(
                              fontSize: 12,
                              color: Colors.orange,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: LinearProgressIndicator(
                value: _distance.clamp(0, 2) / 2,
                backgroundColor: Colors.grey[800],
                valueColor: AlwaysStoppedAnimation<Color>(
                  _warning.isNotEmpty ? Colors.orange : Colors.blue,
                ),
              ),
            ),

            Row(
              children: [
                Container(
                  width: 120,
                  height: 50,
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    border: Border.all(width: 10, color: Colors.white38),
                  ),
                ),
                Expanded(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Icon(
                          SHIcons.waterDrop,
                          color: Colors.white38,
                          size: 20,
                        ),
                        Text(
                          'Air humidity',
                          style: GoogleFonts.montserrat(
                            fontSize: 15,
                            color: Colors.white60,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text('$_humidity%'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class _AirIcons extends StatelessWidget {
  const _AirIcons();

  @override
  Widget build(BuildContext context) {
    return const IconTheme(
      data: IconThemeData(size: 30, color: Colors.white38),
      child: Row(
        children: [
          Icon(SHIcons.snowFlake),
          SizedBox(width: 8),
          Icon(SHIcons.wind),
          SizedBox(width: 8),
          Icon(SHIcons.waterDrop),
          SizedBox(width: 8),
          Icon(SHIcons.timer, color: SHColors.selectedColor),
        ],
      ),
    );
  }
}

class _AirSwitcher extends StatelessWidget {
  const _AirSwitcher({
    required this.isOn,
    required this.temperature,
    required this.onToggle,
  });

  final bool isOn;
  final double temperature;
  final Function(bool) onToggle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Air conditioning'),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: SHSwitcher(
                icon: const Icon(SHIcons.fan),
                value: isOn,
                onChanged: onToggle,
              ),
            ),
            const Spacer(),
            Text(
              '${temperature.toStringAsFixed(1)}˚',
              style: const TextStyle(fontSize: 28),
            ),
          ],
        ),
      ],
    );
  }
}

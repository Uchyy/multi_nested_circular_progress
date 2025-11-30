import 'package:flutter/material.dart';
import 'package:multi_nested_circular_progress/multi_nested_circular_progress.dart';

void main() => runApp(const DemoApp());

class DemoApp extends StatelessWidget {
  const DemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xFFF4F4F4),
        body: const SafeArea(child: StatsExample()),
      ),
    );
  }
}

class StatsExample extends StatelessWidget {
  const StatsExample({super.key});

  @override
  Widget build(BuildContext context) {
    // Just some values to demonstrate the rings
    final double adjustedPlays = 0.75; // 75%
    final double average = 65;         // 65%
    final double best = 88;            // 88%

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            "Overview",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),

        Row(
          children: [
            const SizedBox(width: 16),

            MultiNestedCircularProgress(
              size: 250,
              strokeWidth: 12,
              progresses: [
                adjustedPlays,      // outer ring
                average / 100,      // middle ring
                best / 100,         // inner ring
              ],
              colors: [
                Colors.amber,
                Colors.pinkAccent,
                Colors.purple,
              ],
              child: Text(
                "${(adjustedPlays * 100).toInt()}%",
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),

            const SizedBox(width: 30),
          ],
        ),

        const SizedBox(height: 20),
      ],
    );
  }
}

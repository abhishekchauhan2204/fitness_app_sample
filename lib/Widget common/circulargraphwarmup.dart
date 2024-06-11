
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Screen/provider/provider.dart';

class CircularGraphScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Color(0xFF1C1B2E),
      appBar: AppBar(backgroundColor: Colors.transparent,titleTextStyle: TextStyle(color: Colors.white,fontSize: 21), iconTheme: IconThemeData(
        color: Colors.white, // This will change the color of the back button to white
      ),
        title: Text('Circular Graph & Real-time Data'),
      ),
      body: Consumer<WarmupState>(
        builder: (context, warmupState, child) {
          return Column(
            children: [
              Expanded(
                child: PieChart(
                  PieChartData(
                    sections: [
                      PieChartSectionData(radius: 130,
                        color: Colors.green,
                        value: warmupState.completedDays.toDouble(),
                        title: 'Completed (${warmupState.completedDays})',
                      ),
                      PieChartSectionData(radius: 130,
                        color: Colors.red,
                        value: (WarmupState.totalDays - warmupState.completedDays).toDouble(),
                        title: 'Not Completed (${WarmupState.totalDays - warmupState.completedDays})',
                      ),
                    ],
                    borderData: FlBorderData(show: false),
                    centerSpaceRadius: 0,
                    sectionsSpace: 0,
                  ),
                ),
              ),Expanded(
                child: ListView.builder(
                  itemCount: warmupState.completedHistory.length,
                  itemBuilder: (context, index) {
                    var entry = warmupState.completedHistory[index];
                    var date = entry['date'] as DateTime;
                    var formattedDate = "${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute}";
                    return ListTile(
                      title: Text("Day ${entry['completedDays']}",style: TextStyle(color: Colors.white,fontSize: 21)),
                      subtitle: Text(formattedDate,style: TextStyle(color: Colors.white,fontSize: 16)),
                    );
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  warmupState.resetWarmup();
                },
                child: Text('Reset Warmup'),
              ),
            ],
          );
        },
      ),
    );
  }
}
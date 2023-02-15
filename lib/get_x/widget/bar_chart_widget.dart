import 'dart:math';


import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:yella_merchant/constant/resources/app_colors.dart';
import 'package:yella_merchant/data_models/responses/shop_data_ob.dart';

Widget barChartWidget(WeakData weekData) {
  return BarChart(
    mainBarData(weekData),
  );
}
//
// List<BarChartGroupData> showingGroups() => List.generate(7, (i) {
//       switch (i) {
//         case 0:
//           return makeGroupData(
//             0,
//             5,
//           );
//         case 1:
//           return makeGroupData(
//             1,
//             6.5,
//           );
//         case 2:
//           return makeGroupData(
//             2,
//             5,
//           );
//         case 3:
//           return makeGroupData(3, 7.5);
//         case 4:
//           return makeGroupData(4, 9);
//         case 5:
//           return makeGroupData(5, 11.5);
//         case 6:
//           return makeGroupData(6, 6.5);
//         default:
//           return throw Error();
//       }
//     });

BarChartData mainBarData(WeakData weekData) {
  return BarChartData(
    barTouchData: BarTouchData(
      touchTooltipData: BarTouchTooltipData(
          tooltipPadding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
          tooltipBgColor: Colors.blueGrey,
          getTooltipItem: (group, groupIndex, rod, rodIndex) {
            return BarTooltipItem(
              weekData.dayList![group.x.toInt()] + '\n',
              const TextStyle(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 10,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: (rod.y - 1).toString(),
                  style: const TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            );
          }),
      touchCallback: (FlTouchEvent event, barTouchResponse) {},
    ),
    titlesData: FlTitlesData(
      show: true,
      rightTitles: SideTitles(showTitles: false),
      topTitles: SideTitles(showTitles: false),
      bottomTitles: SideTitles(
        showTitles: true,
        getTextStyles: (context, value) => const TextStyle(
            color: AppColors.spaceGrayColor,
            fontWeight: FontWeight.bold,
            fontSize: 12),
        margin: 5,
        getTitles: (double value) {
          return weekData.dayList![value.toInt()];
        },
      ),
      leftTitles: SideTitles(
        showTitles: false,
      ),
    ),
    borderData: FlBorderData(
      show: false,
    ),
    barGroups: weekData.countList
        ?.asMap()
        .entries
        .map(
          (item) => makeGroupData(
            item.key,
            item.value.toDouble(),
            weekData.countList!.reduce(max) + 10, // 10 is Gap number
          ),
        )
        .toList(),
    gridData: FlGridData(show: false),
  );
}

BarChartGroupData makeGroupData(
  int x,
  double y,
  int maxValue, {
  bool isTouched = false,
  Color barColor = Colors.white,
  double width = 5,
  List<int> showTooltips = const [],
}) {
  return BarChartGroupData(
    x: x,
    barRods: [
      BarChartRodData(
        y: isTouched ? y + 1 : y,
        colors: x == 6 ? [AppColors.brownRedColor] : [AppColors.primaryColor],
        width: width,
        borderSide: isTouched
            ? const BorderSide(color: AppColors.primaryColor, width: 1)
            : const BorderSide(color: Colors.white, width: 0),
        backDrawRodData: BackgroundBarChartRodData(
          show: true,
          y: maxValue.toDouble(),
          colors: [AppColors.reportBottomTitleColor],
        ),
      ),
    ],
    showingTooltipIndicators: showTooltips,
  );
}

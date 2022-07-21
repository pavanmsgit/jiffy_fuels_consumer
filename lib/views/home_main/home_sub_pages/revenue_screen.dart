import 'package:flutter/material.dart';
import 'package:jiffy_fuels_consumer/const/app_colors.dart';
import 'package:jiffy_fuels_consumer/const/screen_size.dart';
import 'package:jiffy_fuels_consumer/widgets/app_bar.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class RevenueScreen extends StatelessWidget {
  RevenueScreen({Key? key}) : super(key: key);
  final List revenueSummary = [
    'Order Received',
    'Order Delivered',
    'Total Earnings',
    'Monthly Earnings'
  ];
  final orderDelivered = [
        MonthRevenue('Jan', 100),
        MonthRevenue('Feb', 200),
        MonthRevenue('Mar', 150),
        MonthRevenue('Apr', 200),
      ],
      orderCancelled = [
        MonthRevenue('Jan', 50),
        MonthRevenue('Feb', 70),
        MonthRevenue('Mar', 110),
        MonthRevenue('Apr', 50),
      ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBarLogo(),
        SizedBox(height: 20),
        Text(
          'Total Revenue',
          style: TextStyle(
            fontSize: 15,
          ),
        ),
        Text(
          '₹250000.0',
          style: TextStyle(
            fontSize: 18,
            color: AppColor.primaryColor,
          ),
        ),
        Container(
          color: Colors.white.withOpacity(0.2),
          child: GridView.builder(
            itemCount: 4,
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2.5,
            ),
            itemBuilder: (ctx, i) => SummaryView(
              title: revenueSummary[i],
              value: '0',
            ),
          ),
        ),
        Text(
          'Orders',
          style: TextStyle(
            fontSize: 17,
            color: AppColor.primaryColor,
          ),
        ),
        SizedBox(
          height: ScreenSize.height(context) * 0.3,
          child: charts.BarChart(
            [
              charts.Series(
                id: 'delivered',
                colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
                domainFn: (sales, _) => sales.month,
                measureFn: (sales, _) => sales.revenue,
                data: orderDelivered,
              ),
              charts.Series(
                id: 'cancelled',
                colorFn: (_, __) =>
                    charts.MaterialPalette.deepOrange.shadeDefault,
                domainFn: (sales, _) => sales.month,
                measureFn: (sales, _) => sales.revenue,
                data: orderCancelled,
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 15,
              width: 15,
              color: Colors.green,
            ),
            SizedBox(width: 3),
            Text(
              'Order Delivered',
              style: TextStyle(
                fontSize: 13,
              ),
            ),
            SizedBox(width: 10),
            Container(
              height: 15,
              width: 15,
              color: Colors.deepOrangeAccent,
            ),
            SizedBox(width: 3),
            Text(
              'Order Cancelled',
              style: TextStyle(
                fontSize: 13,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class MonthRevenue {
  final String month;
  final int revenue;

  MonthRevenue(this.month, this.revenue);
}

class SummaryView extends StatelessWidget {
  const SummaryView({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);
  final String title, value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 15,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}

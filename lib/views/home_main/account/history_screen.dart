import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy_fuels_consumer/const/app_colors.dart';
import 'package:jiffy_fuels_consumer/const/screen_size.dart';
import 'package:jiffy_fuels_consumer/views/home_main/account/history_details.dart';
import '../../../const/app_images.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('History')),
      body: SafeArea(
        child: DefaultTabController(
          length: 3,
          child: Column(
            children: [
              Container(
                height: ScreenSize.height(context) * 0.06,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: TabBar(
                  controller: tabController,
                  indicatorColor: Colors.transparent,
                  labelColor: AppColor.primaryColor,
                  unselectedLabelColor: Colors.grey,
                  tabs: ['Ongoing', 'Past', 'Cancelled']
                      .map(
                        (e) => Text(
                          e,
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  children: [
                    OrderList(),
                    Center(
                      child: Text(
                        'No Orders',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Container(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OrderList extends StatelessWidget {
  const OrderList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 3,
      shrinkWrap: true,
      itemBuilder: (ctx, i) => GestureDetector(
        onTap: () {
          Get.to(() => HistoryDetails());
        },
        child: Container(
          height: ScreenSize.height(context) * 0.12,
          margin: EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 10,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 6,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 4,
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: ScreenSize.width(context) * 0.1,
                backgroundColor: AppColor.primaryColor,
                child: Center(
                  child: Image.asset(AppImages.appLogo),
                ),
              ),
              SizedBox(width: 5),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Order Id: J10000',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      'Place on Jun 30-2022',
                      style: TextStyle(
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                'Pending',
                style: TextStyle(
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:jiffy_fuels_consumer/const/app_colors.dart';
import 'package:jiffy_fuels_consumer/const/app_images.dart';

import '../../../const/screen_size.dart';

class HistoryDetails extends StatelessWidget {
  const HistoryDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image(
                    height: ScreenSize.height(context) * 0.1,
                    image: AssetImage(AppImages.appLogo),
                    color: AppColor.primaryColor,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //website
                      // Text(''),
                      //phone
                      // Text('M: +91 '),
                      //email
                      // Text('E: '),
                      //address
                      // Text(''),
                    ],
                  )
                ],
              ),
              buildDivider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(
                    child: Row(
                      children: [
                        SizedBox(
                          child: Text(
                            'Order: ',
                            style: TextStyle(
                              fontSize: 19.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(
                          child: Center(
                            child: Text(
                              'J10000',
                              style: TextStyle(
                                fontSize: 19.0,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    child: Row(
                      children: [
                        SizedBox(
                          child: Text(
                            'Date: ',
                            style: TextStyle(
                              fontSize: 19.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(
                          child: Center(
                            child: Text(
                              '30 Jun 2022',
                              style: TextStyle(
                                fontSize: 19.0,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              buildDivider(),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: ScreenSize.width(context) * 0.6,
                    child: Text(
                      'Product Amount',
                      style: TextStyle(
                        fontSize: 19.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Text(
                    '100',
                    style: TextStyle(
                      fontSize: 19.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SizedBox(height: ScreenSize.height(context) * 0.01),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: ScreenSize.width(context) * 0.6,
                    child: Text(
                      'Delivery Charge',
                      style: TextStyle(
                        fontSize: 19.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  SizedBox(
                    // width: ScreenSize.width(context) * 0.4,
                    child: Text(
                      '10',
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        fontSize: 19.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: ScreenSize.height(context) * 0.01),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: ScreenSize.width(context) * 0.6,
                    child: Text(
                      'Total Amount',
                      style: TextStyle(
                        fontSize: 19.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Text(
                    '1010',
                    style: TextStyle(
                      fontSize: 19.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              // Align(
              //   alignment: Alignment.centerRight,
              //   child: Text(
              //     'Includes all tax',
              //     style: TextStyle(
              //       color: Colors.black,
              //       fontWeight: FontWeight.w600,
              //       fontSize: 16,
              //     ),
              //   ),
              // ),
              SizedBox(height: ScreenSize.height(context) * 0.02),
              buildDivider(),
              SizedBox(height: ScreenSize.height(context) * 0.02),
              Text(
                'Order Items',
                style: TextStyle(
                  fontSize: 19.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: ScreenSize.height(context) * 0.02),
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(
                    width: ScreenSize.width(context) * 0.3,
                    child: Text(
                      'Item',
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: ScreenSize.width(context) * 0.28,
                    child: Text(
                      'Overall Qty',
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: ScreenSize.width(context) * 0.3,
                    child: Center(
                      child: Text(
                        'Price',
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              buildDivider(),
              SizedBox(
                child: ListView.separated(
                  separatorBuilder: (context, index) => buildDivider(),
                  itemCount: 1,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        SizedBox(
                          width: ScreenSize.width(context) * 0.3,
                          child: Text(
                            'Product',
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: ScreenSize.width(context) * 0.28,
                          child: Center(
                            child: Text(
                              '1 No',
                              style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: ScreenSize.width(context) * 0.3,
                          child: Center(
                            child: Text(
                              '1000',
                              style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        )
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Divider buildDivider() {
  return Divider(
    height: 30.0,
    thickness: 1.0,
    color: AppColor.primaryColor,
  );
}

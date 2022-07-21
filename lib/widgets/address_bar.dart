import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:jiffy_fuels_consumer/const/app_colors.dart';
import 'package:jiffy_fuels_consumer/widgets/shimmer_widgets.dart';
import 'package:jiffy_fuels_consumer/widgets/text_field.dart';

import '../controllers/phone_auth_controller.dart';


class AddressBar extends StatefulWidget {
  const AddressBar({Key? key}) : super(key: key);

  @override
  State<AddressBar> createState() => _AddressBarState();
}

class _AddressBarState extends State<AddressBar> {

  double? lat = 0.00, lng = 0.00;

  String address = 'LOADING...';

  final LocationSettings locationSettings = const LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 0,
  );


  @override
  void initState() {
    phoneAuthController.getLocationPermission();
    Future.delayed(const Duration(seconds:5)).then((v) async {
      Geolocator.getPositionStream(locationSettings: locationSettings)
          .listen((Position? position) {
        lat = position?.latitude;
        lng = position?.longitude;
        getAddressFromLatLong();
      });
    });
    super.initState();
  }

  ///GET CURRENT LOCATION ADDRESS STRING
  Future getAddressFromLatLong() async {
    List<Placemark> placeMarks = await placemarkFromCoordinates(lat!, lng!);
    Placemark place = placeMarks[0];
    address = '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    setState(() {});
    return address;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getAddressFromLatLong(),
        builder: (axy, snapshot){
     if(!snapshot.hasData){
       return const ShimmerForAddressBar();
     }else {
       return GestureDetector(
         onTap: (){
           //todo
         },
         child: Card(
           margin:const EdgeInsets.only(left: 40,right: 40,top: 10),
           shape: const RoundedRectangleBorder(
             borderRadius: BorderRadius.all(Radius.circular(10.0)),
           ),
           child: Padding(
             padding: const EdgeInsets.all(15.0),
             child: Column(
               children: [
                 SingleChildScrollView(
                   scrollDirection: Axis.horizontal,
                   child: Row(children: const [
                     Text('CURRENT LOCATION',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12),),
                     Icon(Icons.keyboard_arrow_down_rounded,color: AppColor.primaryColor,)
                   ],),
                 ),
                 SingleChildScrollView(
                   scrollDirection: Axis.horizontal,
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.start,
                     children: [
                       SingleChildScrollView(
                           scrollDirection: Axis.horizontal,child: Text(address)),
                     ],),
                 )
               ],
             ),
           ),
         ),
       );
     }
    });
      
     
  }
}

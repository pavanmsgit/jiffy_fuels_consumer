// ignore_for_file:prefer_const_literals_to_create_immutables, prefer_const_constructors, use_key_in_widget_constructors,file_names

import 'package:get_storage/get_storage.dart';

class UserData {
  GetStorage g = GetStorage();

  setUserPhone({required String phone}) => g.write('phone', phone);

  getUserPhone() => g.read('phone') ?? '';


  ///todo - no use
  setUserEmail({required String email}) => g.write('email', email);

  ///todo - no use
  getUserEmail() => g.read('email') ?? '';


  // setDefaultAddress(id) async {
  //   final GetStorage g = GetStorage();
  //   g.write('address_id', id);
  // }
  //
  // getDefaultAddress() async {
  //   final GetStorage g = GetStorage();
  //   return g.read('address_id');
  // }

  // addAddress({address}) async {
  //   final SharedPreferences c = await SharedPreferences.getInstance();
  //   c.setString('address', address);
  // }

  // getAddress() async {
  //   final SharedPreferences c = await SharedPreferences.getInstance();
  //   return c.getString('address');
  // }
}

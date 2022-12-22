import 'package:finance_rifzki/ui/homescreen/home_screen.dart';
import 'package:finance_rifzki/ui/setting_nama/setting_nama_screen.dart';
import 'package:finance_rifzki/ui/welcome/welcome_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Navigasi/navigasi.dart';

class CheckSessionScreen extends StatefulWidget {
  const CheckSessionScreen({Key? key}) : super(key: key);

  @override
  State<CheckSessionScreen> createState() => _CheckSessionScreenState();
}

class _CheckSessionScreenState extends State<CheckSessionScreen> {


  late SharedPreferences logindata;


  void initial() async {
    logindata = await SharedPreferences.getInstance();
    if(logindata.getBool('first') == false){
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context){
            return Navigasi();
          })
      );
    }else{
      print("${logindata.getBool('first')}");
      Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context){
              return WelcomeScreen();
            })
      );
    }

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initial();
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: Image.asset("assets/overlay.png", width: size.width, height: size.height,fit: BoxFit.fill,)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: CircularProgressIndicator(),
    );
  }
}

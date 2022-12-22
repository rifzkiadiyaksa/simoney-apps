import 'package:finance_rifzki/ui/setting_nama/setting_nama_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../homescreen/home_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {

  late SharedPreferences logindata;
  bool isFirst = true;


  void initial() async {
    logindata = await SharedPreferences.getInstance();
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
      backgroundColor: Color(0xff253334),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: size.width,

            alignment: Alignment.center,
            height: size.height,
            child: Stack(
              children: [
                Positioned(
                    top: -80,
                    left: 0, 
                    right: 0,
                    child: Image.asset("assets/vector_atas.png")
                ),
                Positioned(
                    top: 350,
                    left: 20,
                    right: 20,
                    child: Image.asset("assets/welcome.png", fit: BoxFit.cover,)),
                Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Image.asset("assets/logo.png", fit: BoxFit.cover,)),
                Positioned(
                    bottom: 127,
                    left: 20, right: 20,
                    child: InkWell(
                      onTap: () async {
                        setState(() {
                          isFirst = false;
                        });

                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context){
                              return SettingNamaScreen();
                            })
                        );
                      },
                      child: Container(
                        width: size.width,
                        height: 61,
                        decoration: BoxDecoration(
                          color: Color(0xff7C9A92),
                          borderRadius: BorderRadius.circular(12)
                        ),
                        child: Center(
                          child: Text("Mari Merencanakan", style: TextStyle(
                            color:Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold

                          ),),

                        ),
                      ),
                    ),

                )

              ],
            ),
          )
        ],
      ),
    );
  }
}

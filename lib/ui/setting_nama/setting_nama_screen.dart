import 'dart:convert';

import 'package:finance_rifzki/ui/Navigasi/navigasi.dart';
import 'package:finance_rifzki/ui/homescreen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

class SettingNamaScreen extends StatefulWidget {
  const SettingNamaScreen({Key? key}) : super(key: key);

  @override
  State<SettingNamaScreen> createState() => _SettingNamaScreenState();
}

class _SettingNamaScreenState extends State<SettingNamaScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late SharedPreferences logindata;

  TextEditingController _namaLengkapController = TextEditingController();
  TextEditingController _emailPribadi = TextEditingController();

  void initial() async {
    logindata = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initial();
  }

  Future sendEmail({
  required String name,
  required String email,
  required String subject,
  required String message
  }) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_){
          return Dialog(
            insetPadding: EdgeInsets.only(left: 100, right:100, top: 10, bottom: 10),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                    width: 200 ,
                    height: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white
                    ),

                    child: Center(child: CircularProgressIndicator(color: Colors.grey,))
                ),
              ],

            ),
          );
        }
    );

    final url = Uri.parse("https://api.emailjs.com/api/v1.0/email/send");
    final response = await http.post(
        url,
      headers: {
          'origin':'http://localhost',
          'Content-Type':'application/json'
      },
      body: json.encode( {
         'service_id':"service_h8y13pp",
        'template_id':"template_wuzl9y9",
        'user_id':"XD889x64JbkROnXEc",
        'template_params':{
           'user_name':name,
           'user_email':'no-reply@research.simoney.my.id',
            'user_subject':subject,
          'user_message':message,
          'to_email':email
        }
      })
    );
    // if(response.statusCode == 200){
    //   print(response.body);
    // }else{
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(
    //       backgroundColor: Colors.red,
    //       content: Text('${response.statusCode}, error: ${response.body}'),
    //     ),
    //   );
    // }
    logindata.setBool('first', false);
    logindata.setString('namaLengkap',_namaLengkapController.text);
    logindata.setString('email', _emailPribadi.text);
    logindata.setString('visible', "isvisible");
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return Navigasi();
    }));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xff253334),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        // reverse: true,
        child: Column(
          children: [
            Container(
              width: size.width,
              height: size.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 180,
                    child: Stack(
                      children: [
                        Positioned(
                            top: 32,
                            left: -18,
                            child: Image.asset("assets/logosyokecil.png")),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Setting", style: TextStyle(fontSize: 30, color: Colors.white),),
                        SizedBox(height: 10,),
                        Text("Buat personal keuangan pribadi\ndengan mudah", style: TextStyle(fontSize: 22, color: Colors.white.withOpacity(0.7)),),
                        SizedBox(height: 20,),
                        Form(
                          key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextFormField(
                                  controller:_namaLengkapController,
                                  style:  TextStyle(fontSize: 18, color: Colors.white.withOpacity(0.7)),
                                  textAlign: TextAlign.start,

                                  textAlignVertical: TextAlignVertical.center,
                                  decoration: InputDecoration(
                                    hintText: 'Nama Lengkap',
                                    hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Color(0xff536C6B)),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color:  Color(0xff536C6B)),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10,),
                                TextFormField(
                                  controller: _emailPribadi,
                                  style:  TextStyle(fontSize: 18, color: Colors.white.withOpacity(0.7)),
                                  textAlign: TextAlign.start,

                                  textAlignVertical: TextAlignVertical.center,
                                  decoration: InputDecoration(
                                    hintText: 'Email Pribadi',
                                    hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color:  Color(0xff536C6B)),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color:  Color(0xff536C6B)),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 35,),
                                InkWell(
                                  onTap: () async {
                                    print(_namaLengkapController.text);

                                    sendEmail(
                                        name: _namaLengkapController.text,
                                        email: _emailPribadi.text,
                                        subject: 'Simoney Account ${_namaLengkapController.text})',
                                        message: 'Hai \nAkun Anda sudah berhasil dibuat \nnama: ${_namaLengkapController.text} \nemail: ${_emailPribadi.text}'
                                    );

                                    },
                                  child: Container(
                                    width: size.width,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      color: Color(0xff7C9A92),
                                      borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: Center(child: Text("Rencanakan Sekarang", style: TextStyle(color: Colors.white, fontSize: 20),)),
                                  ),
                                )
                              ],
                            )
                        )
                      ],
                    ),
                  ),

                ],
              ),
            ),
            Padding( // this is new
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom)
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Image.asset("assets/vector_bawah.png",height: 150, width: size.width,fit: BoxFit.fill,),
    );
  }
}

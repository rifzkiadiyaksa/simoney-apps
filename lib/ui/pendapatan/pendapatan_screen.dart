import 'dart:async';

import 'package:finance_rifzki/model/pendapatan/pendapatan.dart';
import 'package:finance_rifzki/ui/Navigasi/navigasi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../pengeluaran/PengeluaranScreen.dart';
import '../webview/webview_screen.dart';

class PendapatanScreen extends StatefulWidget {
  const PendapatanScreen({Key? key}) : super(key: key);

  @override
  State<PendapatanScreen> createState() => _PendapatanScreenState();
}

class _PendapatanScreenState extends State<PendapatanScreen> {

  TextEditingController _budgetController = TextEditingController();
  var uangcontroller = MoneyMaskedTextController(
      thousandSeparator: '.',
      decimalSeparator: '',
      precision: 0);

  double jumlah = 0;
  Timer? _timer;
  var selectedDate = DateTime.now();
  String day = 'sample';

  TextEditingController sumberPendapatan = TextEditingController();
  List<Pendapatan> pendapatan = [];
  TextEditingController _dateController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // clearData();
    getData();
    getLimit();
    day =DateFormat('EEEE, dd MMMM yyyy').format(selectedDate);
    _dateController.text = day;
    // tambahLimit();
  }

  void getLimit() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if(pref.getString('limit') != null){
      print(pref.getString('limit'));
    }else{
      print("belum ada data limit");
    }
  }

  void clearData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
  }

  void getData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    //ambil data pendapatan
    if(pref.getString('pendapatan') != null){
      final String listPendapatan = await pref.getString('pendapatan')!;
      print("disini hasilnya $listPendapatan");
      setState(() {
        pendapatan = Pendapatan.decode(listPendapatan);
      });
    }else{
      print("gada data awal");
    }

    // print("jumlah diisniii ${pendapatan[0].jumlah}");
  }

  void tambahLimit() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if(pref.getString('limit') != null){
      print("awalan ${pref.getString('limit')}");
      List nums = [
        double.parse(pref.getString('limit')!),
        uangcontroller.numberValue
      ];
      double k = nums.fold(0, (p, n) => p+n);
      await pref.setString('limit', k.toString());
      print("akhiran ${pref.getString('limit')}");
    }else{
      await pref.setString('limit', uangcontroller.numberValue.toString());
      print("no dataaa");
    }
  }



  void munculDialog(){
    _timer = Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context){
            return Navigasi();
          }));
    });
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_){
          return Dialog(
            insetPadding: EdgeInsets.only(left: 35, right: 35, top: 10, bottom: 10),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                    width:200,
                    height: 180,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white
                    ),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("assets/success.png", height: 64, width: 64, fit: BoxFit.fill,),
                        SizedBox(height: 10,),
                        Text("Pendapatan dicatat", style: TextStyle(fontWeight: FontWeight.bold),)
                      ],
                    )
                ),
              ],
            ),
          );
        }
    ).then((value) => {
      if(_timer!.isActive){
        _timer!.cancel()
      }
    });
  }

  void masukanPendapatan(List<Pendapatan> pendapatan) async  {
    SharedPreferences pref =  await SharedPreferences.getInstance();
    String encodedData = Pendapatan.encode(pendapatan);
    await pref.setString('pendapatan', encodedData);
    getData();
  }

  bool isRepeat = false;
  bool issepuluh = false;
  bool isduapuluh = false;
  bool islimapuluh = false;



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xff253334),
      resizeToAvoidBottomInset: false,
      body:SingleChildScrollView(

        child: Column(
          children: [
            Container(
              width: size.width,
              height: size.height,
              child: Stack(
                children: [
                  Positioned(
                      left: 20,
                      right: 20,
                      top: 48,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Pendapatan", style: TextStyle(color: Colors.white, fontSize: 35),),
                              InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context){
                                      return WebViewScreen(
                                        url: "https://syo.biz.id/id/income",
                                        judul: "Pendapatan",
                                      );
                                    }));
                                  },
                                  child: Image.asset("assets/help.png", width: 40, height: 40, fit: BoxFit.fill,))
                            
                            ],
                          ),
                          SizedBox(height: 30,),
                          Text("Jumlah Pendapatan?", style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 18),),
                          SizedBox(height: 15,),
                          TextFormField(
                            style: TextStyle(color: Colors.white, fontSize:36 ),
                            textAlignVertical: TextAlignVertical.center,
                            textAlign: TextAlign.start,
                            controller: uangcontroller,
                            decoration: InputDecoration(
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                prefixIcon: Text("Rp. ",style: TextStyle(fontSize: 36, color: Colors.white),)
                            ),
                            keyboardType: TextInputType.number,
                          ),
                          SizedBox(height: 20,),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap:(){
                                  setState(() {
                                    islimapuluh = false;
                                    issepuluh = true;
                                    isduapuluh = false;
                                    uangcontroller.text = "10000";
                                  });
                                },
                                child: Container(
                                  width: 94,
                                  height: 42,
                                  decoration: BoxDecoration(
                                      color: issepuluh ? Color(0xff2A8371): Colors.transparent,
                                      border: Border.all(color: Colors.white),
                                      borderRadius: BorderRadius.circular(24)
                                  ),
                                  child: Center(child: Text("10.000", style: TextStyle(fontSize: 14, color: Colors.white),)),
                                ),
                              ),
                              SizedBox(width: 10,),
                              InkWell(
                                onTap: (){
                                  setState(() {
                                    islimapuluh = false;
                                    issepuluh = false;
                                    isduapuluh = true;
                                    uangcontroller.text = "20000";
                                  });
                                },
                                child: Container(
                                  width: 94,
                                  height: 42,
                                  decoration: BoxDecoration(
                                      color: isduapuluh ? Color(0xff2A8371): Colors.transparent,
                                      border: Border.all(color: Colors.white),
                                      borderRadius: BorderRadius.circular(24)
                                  ),
                                  child: Center(child: Text("20.000", style: TextStyle(fontSize: 14, color: Colors.white),)),
                                ),
                              ),
                              SizedBox(width: 10,),
                              InkWell(
                                onTap: (){
                                  setState(() {
                                    islimapuluh = true;
                                    issepuluh = false;
                                    isduapuluh = false;
                                    uangcontroller.text = "50000";
                                  });
                                },
                                child: Container(
                                  width: 94,
                                  height: 42,
                                  decoration: BoxDecoration(
                                      color: islimapuluh ? Color(0xff2A8371): Colors.transparent,
                                      border: Border.all(color: Colors.white),
                                      borderRadius: BorderRadius.circular(24)
                                  ),
                                  child: Center(child: Text("50.000", style: TextStyle(fontSize: 14, color: Colors.white),)),
                                ),
                              ),

                            ],
                          )
                        ],
                      )
                  ),
                  Positioned(
                    top: size.height * 0.5,
                    child: Container(
                      width: size.width,
                      height: size.height * 0.5,
                      padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(32),
                              topRight: Radius.circular(32)
                          )
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                child: TextFormField(
                                  style: TextStyle(fontSize: 18),
                                  controller: sumberPendapatan,
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16.0),
                                      borderSide: BorderSide(
                                        color: Color(0xffF1F1FA),
                                      ),
                                    ),
                                    labelText: "Sumber Pendapatan",
                                    labelStyle: TextStyle(fontSize: 18),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16.0),
                                      borderSide: BorderSide(
                                        color: Color(0xffF1F1FA),
                                      ),
                                    ),
                                  ),
                                ),
                                margin: EdgeInsets.only(top: 10),
                              ),
                              SizedBox(height: 15,),
                              Container(
                                height: 56,
                                width: size.width,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: Color(0xffF1F1FA),
                                    )
                                ),
                                padding: EdgeInsets.only(left: 10, right: 10),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text("Pendapatan Rutin?", style: TextStyle(color: Colors.black, fontSize: 16,),),
                                        Text("Contoh: Gaji / Uang Bulanan", style: TextStyle(color: Colors.grey, fontSize: 13),)
                                      ],
                                    ),
                                    CupertinoSwitch(
                                      value: isRepeat,
                                      activeColor: Color(0xff7C9A92),
                                      onChanged: (value){
                                        setState(() {
                                          isRepeat = value;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 15,),
                              InkWell(
                                onTap: () async {
                                  DatePicker.showPicker(context, showTitleActions: true,
                                      onChanged: (date) {
                                        // print('change $date in time zone ');
                                      }, onConfirm: (date) {
                                        // print('confirm $date');
                                        setState(() {
                                          selectedDate = date;
                                          day = DateFormat('EEEE, dd MMMM yyyy').format(selectedDate);
                                          _dateController.text = day;
                                        });
                                      },
                                      pickerModel: CustomMonthPicker(
                                          minTime: DateTime(2004, 1, 1),
                                          maxTime: DateTime(2101,12,12),
                                          currentTime:selectedDate
                                      ),
                                      locale: LocaleType.id);
                                },
                                child: Container(
                                  child: TextFormField(
                                    enabled: false,
                                    controller: _dateController,
                                    style: TextStyle(fontSize: 18),
                                    decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16.0),
                                        borderSide: BorderSide(
                                          color: Color(0xffF1F1FA),
                                        ),
                                      ),

                                      labelText: "Tanggal Pendapatan",
                                      labelStyle: TextStyle(fontSize: 18),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16.0),
                                        borderSide: BorderSide(
                                          color: Color(0xffF1F1FA),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: () async {
                              setState(() {
                                pendapatan.add(Pendapatan(
                                    jumlah: uangcontroller.numberValue.toString(),
                                    sumberPendapatan: sumberPendapatan.text,
                                    berulang: isRepeat,
                                    tanggal: day
                                ));
                              });
                              // print(uangcontroller.text);

                              masukanPendapatan(pendapatan);
                              tambahLimit();
                              munculDialog();
                              //
                            },
                            child: Container(
                              height: 56,
                              width: size.width,
                              margin: EdgeInsets.only(bottom: 20),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: Color(0xff7C9A92)
                              ),
                              child: Center(
                                child: Text("Buat Pendapatan", style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding( // this is new
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom)
            ),
          ],
        ),
      )
    );
  }
}

import 'dart:async';

import 'package:finance_rifzki/model/rencana/rencana.dart';
import 'package:finance_rifzki/ui/Navigasi/navigasi.dart';
import 'package:finance_rifzki/ui/webview/webview_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BuatPerencanaanScreen extends StatefulWidget {
  const BuatPerencanaanScreen({Key? key}) : super(key: key);

  @override
  State<BuatPerencanaanScreen> createState() => _BuatPerencanaanScreenState();
}

class _BuatPerencanaanScreenState extends State<BuatPerencanaanScreen> {

  TextEditingController _namakategori = TextEditingController();
  var uangcontroller = MoneyMaskedTextController(
      thousandSeparator: '.',
      decimalSeparator: '',
      precision: 0);

  var uangbataspendapatan = MoneyMaskedTextController(
      thousandSeparator: '.',
      decimalSeparator: '',
      precision: 0);

  var uangbatasperencanaan = MoneyMaskedTextController(
      thousandSeparator: '.',
      decimalSeparator: '',
      precision: 0);

  String limitPendapatan = "0";
  String limitRencanaValue = "0";
  Timer? _timer;

  String kategoriValue = "Kategori";

  var kategori = [
    "Kategori",
    "Makan",
    "Transportasi",
    "Tagihan",
    "Lainnya"
  ];

  List<Rencana> dataRencana = [];

  void clearData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
  }

  void tambahRencana(List<Rencana> rencana) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String encodedData = Rencana.encode(rencana);
    await pref.setString('rencana', encodedData);
    getData();
  }

  void getData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    if(pref.getString('rencana') != null ){
      final String listRencana = await pref.getString('rencana')!;
      setState(() {
        dataRencana = Rencana.decode(listRencana);
      });
      String encodedData = Rencana.encode(dataRencana);
      print(encodedData);
    }else{
      print("no data");
    }
  }

  void tambahlimitRencana() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if(pref.getString('limitRencana') != null){
      List nums = [
        double.parse(pref.getString('limitRencana')!),
        uangcontroller.numberValue
      ];
      double k = nums.fold(0, (p, n) => p+n);
      await pref.setString('limitRencana', k.toString());
    }else{
      await pref.setString('limitRencana', uangcontroller.numberValue.toString());
    }
  }

  void getLimitPendapatan() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if(pref.getString('limit') != null){

      setState(() {
        uangbataspendapatan.text = pref.getString('limit')!.substring(0, (pref.getString('limit')!.length -2));
        limitPendapatan = uangbataspendapatan.text;
      });
      print(uangbataspendapatan.numberValue);
    }else{
      print("belum ada limit pendapatan");
    }
  }

  void getLimitPerencanaan() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if(pref.getString('limitRencana') != null){
      setState(() {
        uangbatasperencanaan.text = pref.getString('limitRencana')!.substring(0, (pref.getString('limitRencana')!.length -2));
        limitRencanaValue = uangbatasperencanaan.text;
      });
      print("disini limit rencana ${limitRencanaValue}");
    }else{
      print("belum ada limit perencanaan");
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
                        Text("Rencana berhasil dibuat", style: TextStyle(fontWeight: FontWeight.bold),)
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

  void dialogError(String text){
    _timer = Timer(Duration(seconds: 2), () {
      Navigator.of(context).pop();
    });
    showDialog(
        context: context,
        builder: (_){
          return Dialog(
            insetPadding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
            backgroundColor: Colors.red,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                    width:double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.red
                    ),
                    padding: EdgeInsets.only(left: 15, right: 15),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.info, color: Colors.white,),
                        FittedBox(
                          child: Text(text, style: TextStyle(color: Colors.white, fontSize: 14),),
                        )
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

  bool isRepeat = false;
  bool issepuluh = false;
  bool isduapuluh = false;
  bool islimapuluh = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    getLimitPendapatan();
    getLimitPerencanaan();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xff253334),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(

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
                              Text("Buat Rencana", style: TextStyle(color: Colors.white, fontSize: 35),),
                              InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context){
                                      return WebViewScreen(
                                        url: "https://syo.biz.id/id/budget",
                                        judul: "Perencanaan",
                                      );
                                    }));
                                  },
                                  child: Image.asset("assets/help.png", width: 40, height: 40, fit: BoxFit.fill,))
                            ],
                          ),
                          SizedBox(height: 30,),
                          Text("Limit Budget?", style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 18),),
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
                    top: size.height * 0.52,
                    child: Container(
                      width: size.width,
                      height: size.height * 0.48,
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
                                  controller: _namakategori,
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16.0),
                                      borderSide: BorderSide(
                                        color: Color(0xffF1F1FA),
                                      ),
                                    ),
                                    labelText: "Nama Budget",
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
                              SizedBox(height: 15,),
                              Container(
                                height: 56,
                                width: size.width,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                        color:Color(0xffF1F1FA)
                                    )
                                ),
                                padding: EdgeInsets.only(left: 10, right: 10),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    value: kategoriValue,
                                    isExpanded: true,
                                    icon: Icon(                // Add this
                                      Icons.arrow_drop_down,  // Add this
                                      color: Color(0xff253334),   // Add this
                                    ),
                                    items: kategori.map((String items) {
                                      return DropdownMenuItem(
                                          value: items,
                                          child: Text(items)
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue){
                                      setState(() {
                                        kategoriValue = newValue!;
                                      });
                                    },
                                  )
                                )
                              ),
                              SizedBox(height: 15,),
                              Container(
                                height: 56,
                                width: size.width,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                        color: Color(0xffF1F1FA)
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
                                        Text("Berulang?", style: TextStyle(color: Colors.black, fontSize: 16,),),
                                        Text("Budget rutin", style: TextStyle(color: Colors.grey, fontSize: 13),)
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
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 20,),
                          InkWell(
                            onTap: (){
                              if(kategoriValue != "Kategori" && uangcontroller.numberValue >0){
                                setState(() {
                                  dataRencana.add(
                                      Rencana(
                                          jumlah: uangcontroller.numberValue.toString(),
                                          namaRencana: _namakategori.text,
                                          kategori: kategoriValue,
                                          berulang: isRepeat,
                                        terpakai: "0"
                                      )
                                  );
                                });

                                if(uangbataspendapatan.numberValue != 0){
                                  if(uangbatasperencanaan.numberValue == 0){
                                    tambahRencana(dataRencana);
                                    tambahlimitRencana();
                                    munculDialog();
                                  }else{
                                    double limitsementara = uangbatasperencanaan.numberValue + uangcontroller.numberValue;
                                    if(limitsementara <= uangbataspendapatan.numberValue){
                                      tambahRencana(dataRencana);
                                      tambahlimitRencana();
                                      munculDialog();

                                    }else{
                                      dialogError(
                                        "Anda melampaui batas pendapatan"
                                      );
                                      dataRencana.clear();
                                      uangcontroller.clear();
                                      print("melebihi limit");
                                    }
                                  }
                                }
                                else{
                                  dialogError("Anda belum menambahkan Pendapatan");
                                }
                              }
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
                                child: Text("Buat budget", style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),),
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
      ),
    );
  }
}

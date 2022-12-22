import 'dart:async';

import 'package:finance_rifzki/model/pengeluaran/pengeluaran.dart';
import 'package:finance_rifzki/ui/Navigasi/navigasi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:intl/intl.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/rencana/rencana.dart';
import '../webview/webview_screen.dart';

class PengeluaranScreen extends StatefulWidget {
  const PengeluaranScreen({Key? key}) : super(key: key);

  @override
  State<PengeluaranScreen> createState() => _PengeluaranScreenState();
}

class _PengeluaranScreenState extends State<PengeluaranScreen> {

  TextEditingController _dateController = TextEditingController();
  TextEditingController _namaController = TextEditingController();
  Timer? _timer;
  var uangcontroller = MoneyMaskedTextController(
      thousandSeparator: '.',
      decimalSeparator: '',
      precision: 0);

  String kategoriValue = "Jenis Pengeluaran";

  List<Pengeluaran> dataPengeluaran = [];
  List<Rencana> dataRencana = [];

  List<String> kategori = [
    "Jenis Pengeluaran"
  ];

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
                        Text("Pengeluaran dicatat", style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center,)
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
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context){
            return Navigasi();
          }));
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


  void tambahPengeluaran(List<Pengeluaran> pengeluaran) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String encodedData = Pengeluaran.encode(pengeluaran);
    await pref.setString('pengeluaran', encodedData);
    getData();
  }

  void getData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if(pref.getString('pengeluaran') != null){
      final String listPengeluaran = await pref.getString('pengeluaran')!;
      setState(() {
        dataPengeluaran = Pengeluaran.decode(listPengeluaran);
      });
      String encodedData = Pengeluaran.encode(dataPengeluaran);
      print(encodedData);
    }else{
      // print("no data");
    }
  }



  void getDataKategori() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if(pref.getString('rencana') != null ){
      final String listRencana = await pref.getString('rencana')!;
      setState(() {
        dataRencana = Rencana.decode(listRencana);
      });
      for(int i=0;i<dataRencana.length;i++){
        setState(() {
          kategori.add(dataRencana[i].namaRencana!);
        });
      }
    }else{
      // print("no data");
    }
  }

  void tambahRencana(List<Rencana> rencana) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String encodedData = Rencana.encode(rencana);
    await pref.setString('rencana', encodedData);
    // getData();
  }

  void tambahLimit() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if(pref.getString('limitPengeluaran') != null){
      // print("awalan ${pref.getString('limit')}");
      List nums = [
        double.parse(pref.getString('limitPengeluaran')!),
        uangcontroller.numberValue
      ];
      double k = nums.fold(0, (p, n) => p+n);
      await pref.setString('limitPengeluaran', k.toString());
      // print("akhiran ${pref.getString('limit')}");
    }else{
      await pref.setString('limitPengeluaran', uangcontroller.numberValue.toString());
      print("no dataaa");
    }
  }

  void getLimit() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if(pref.getString('limitPengeluran') != null){
      print(pref.getString('limitPengeluaran'));
    }else{
      print("belum ada data limit");
    }
  }



  bool isRepeat = false;
  bool issepuluh = false;
  bool isduapuluh = false;
  bool islimapuluh = false;
  var selectedDate = DateTime.now();
  String day = 'sample';



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    day =DateFormat('EEEE, dd MMMM yyyy').format(selectedDate);

    _dateController.text = day;
    getData();
    getDataKategori();
    getLimit();
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
                              Text("Pengeluaran", style: TextStyle(color: Colors.white, fontSize: 35),),
                              InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context){
                                      return WebViewScreen(
                                        url: "https://syo.biz.id/id/outcome",
                                        judul: "Pengeluaran",
                                      );
                                    }));
                                  },
                                  child: Image.asset("assets/help.png", width: 40, height: 40, fit: BoxFit.fill,))
                            ],
                          ),
                          SizedBox(height: 30,),
                          Text("Jumlah Pengeluaran?", style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 18),),
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
                                  controller: _namaController,
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16.0),
                                      borderSide: BorderSide(
                                        color: Color(0xffF1F1FA),
                                      ),
                                    ),
                                    labelText: "Nama Pengeluaran",
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

                                      labelText: "Tanggal Pengeluaran",
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
                              SizedBox(height: 10,),
                            ],
                          ),
                          InkWell(
                            onTap: () async {
                              if(dataRencana.isNotEmpty){
                                if((kategoriValue != "Jenis Pengeluaran") && _namaController.text != "" && uangcontroller.numberValue>0){
                                  setState(() {
                                    dataPengeluaran.add(
                                        Pengeluaran(
                                            namaPengeluaran: _namaController.text,
                                            jumlah: uangcontroller.numberValue.toString(),
                                            jenis: kategoriValue,
                                            tanggal: _dateController.text
                                        )
                                    );
                                  });

                                  tambahPengeluaran(dataPengeluaran);
                                  if(dataRencana[dataRencana.indexWhere((element) => element.namaRencana == kategoriValue)].terpakai != "0"){
                                    List nums =  [
                                      double.parse(dataRencana[dataRencana.indexWhere((element) => element.namaRencana == kategoriValue)].terpakai!),
                                      uangcontroller.numberValue
                                    ];
                                    double k = nums.fold(0, (p, n) => p+n);
                                    setState(() {
                                      dataRencana[dataRencana.indexWhere((element) => element.namaRencana == kategoriValue)].terpakai = k.toString();
                                    });
                                    if((double.parse(dataRencana[dataRencana.indexWhere((element) => element.namaRencana == kategoriValue)].terpakai!)) <= (double.parse(dataRencana[dataRencana.indexWhere((element) => element.namaRencana == kategoriValue)].jumlah!))){
                                      // print("masih bisa");
                                      print("ini terpakai ${(double.parse(dataRencana[dataRencana.indexWhere((element) => element.namaRencana == kategoriValue)].terpakai!))}");
                                      print("ini jumlah ${double.parse(dataRencana[dataRencana.indexWhere((element) => element.namaRencana == kategoriValue)].jumlah!)}");
                                      tambahRencana(dataRencana);
                                      tambahLimit();
                                      munculDialog();
                                    }else{
                                      // print("gabisa");
                                      dialogError("Anda melampaui batas perencanaan");
                                    }
                                  }
                                  else{
                                    setState(() {
                                      dataRencana[dataRencana.indexWhere((element) => element.namaRencana == kategoriValue)].terpakai = uangcontroller.numberValue.toString();
                                    });
                                    if((double.parse(dataRencana[dataRencana.indexWhere((element) => element.namaRencana == kategoriValue)].terpakai!)) <= (double.parse(dataRencana[dataRencana.indexWhere((element) => element.namaRencana == kategoriValue)].jumlah!))){
                                      // print("masih bisa");
                                      print("ini terpakai ${(double.parse(dataRencana[dataRencana.indexWhere((element) => element.namaRencana == kategoriValue)].terpakai!))}");
                                      print("ini jumlah ${double.parse(dataRencana[dataRencana.indexWhere((element) => element.namaRencana == kategoriValue)].jumlah!)}");
                                      tambahRencana(dataRencana);
                                      tambahLimit();
                                      munculDialog();
                                    }else{

                                      // print("gabisa");
                                      dialogError("Anda melampaui batas perencanaan");
                                    }
                                  }
                                }
                                else{
                                  // print("gabisa");
                                  dialogError("Jumlah nominal tidak boleh 0");
                                }
                              }else{
                                dialogError("Data rencana belum ditambahkan");
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
                                child: Text("Buat Pengeluaran", style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),),
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

class CustomMonthPicker extends DatePickerModel {
  CustomMonthPicker({DateTime? currentTime, DateTime? minTime, DateTime? maxTime,
    LocaleType? locale}) : super(locale: locale, minTime: minTime, maxTime:
  maxTime, currentTime: currentTime);

  @override
  List<int> layoutProportions() {
    return [1, 1, 1];
  }
}
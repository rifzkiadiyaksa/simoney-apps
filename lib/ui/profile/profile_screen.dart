import 'package:finance_rifzki/model/pendapatan/pendapatan.dart';
import 'package:finance_rifzki/model/pengeluaran/pengeluaran.dart';
import 'package:finance_rifzki/ui/homescreen/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../buat/buat_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isSemua = true;
  bool isPemasukan = true;
  bool isPengeluaran = false;

  List<Pendapatan> pendapatan = [];
  List<Pengeluaran> dataPengeluaran = [];
  List<Pendapatan> searchPendapatan = [];
  List<Pengeluaran> searchPengeluaran = [];
  List<String> jumlahNominalPendapatan = [];
  List<String> nominalSearchPendapatan = [];
  List<String> jumlahNominalPengeluaran = [];
  List<String> nominalSearchPengeluaran = [];
  TextEditingController _searchPendapatancontroller = TextEditingController();
  TextEditingController _searchPengeluarancontroller = TextEditingController();


  var uangpendapatancontroller = MoneyMaskedTextController(
      thousandSeparator: '.',
      decimalSeparator: '',
      precision: 0);

  var uangpengeluarancontroller = MoneyMaskedTextController(
      thousandSeparator: '.',
      decimalSeparator: '',
      precision: 0);


  void getDataPengeluaran() async {
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

  void getDataPendapatan() async {
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

  void convert() {
    for(int i = 0; i<pendapatan.length;i++){
      String nominal = pendapatan[i].jumlah!.substring(0, pendapatan[i].jumlah!.length -2);
      uangpendapatancontroller.text = nominal;
      jumlahNominalPendapatan.add(uangpendapatancontroller.text);
    }
  }
  void convertSearchPendapatan() {
    for(int i = 0; i<searchPendapatan.length;i++){
      String nominal = searchPendapatan[i].jumlah!.substring(0, searchPendapatan[i].jumlah!.length -2);
      uangpendapatancontroller.text = nominal;
      nominalSearchPendapatan.add(uangpendapatancontroller.text);
    }
  }



  void convertPengeluaran() {
    for(int i = 0; i<dataPengeluaran.length;i++){
      String nominal = dataPengeluaran[i].jumlah!.substring(0, dataPengeluaran[i].jumlah!.length -2);
      uangpengeluarancontroller.text = nominal;
      jumlahNominalPengeluaran.add(uangpengeluarancontroller.text);
    }
  }
   void convertSearchPengeluaran() {
    for(int i = 0; i<searchPengeluaran.length;i++){
      String nominal = searchPengeluaran[i].jumlah!.substring(0, searchPengeluaran[i].jumlah!.length -2);
      uangpengeluarancontroller.text = nominal;
      nominalSearchPengeluaran.add(uangpengeluarancontroller.text);
    }
  }



  onSearchTextChanged(String text) async {
    searchPendapatan.clear();
    nominalSearchPendapatan.clear();
    if(text.isEmpty){
      setState(() {

      });
      return;
    }

    pendapatan.forEach((dataa) {
      if(dataa.sumberPendapatan!.toLowerCase().contains(text))
        searchPendapatan.add(dataa);
    });

    setState(() {
    });
  }

  onSearchPengeluaranTextChanged(String text) async {
    searchPengeluaran.clear();
    nominalSearchPengeluaran.clear();
    if(text.isEmpty){
      setState(() {

      });
      return;
    }

    dataPengeluaran.forEach((dataa) {
      if(dataa.namaPengeluaran!.toLowerCase().contains(text))
        searchPengeluaran.add(dataa);
    });

    setState(() {
    });
  }




  Widget tampilPendapatan(){
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 15, bottom: 15, left: 20, right: 20),
          child: TextFormField(
            onChanged: onSearchTextChanged,
            controller: _searchPendapatancontroller,
            style: TextStyle(fontSize: 16, color: Colors.white),
            decoration: InputDecoration(
              label: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset("assets/receiptsearch.png", color: Colors.white,height: 20,),
                  SizedBox(width: 10,),
                  Text("Cari riwayat pendapatan", style: TextStyle(color: Colors.white, fontSize: 11),)
                ],
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white)
              ),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white)
              ),
            ),
          ),
        ),
        Container(
          height: size.height * 0.7,
          child:
          searchPendapatan.length != 0 || _searchPendapatancontroller.text.isNotEmpty ?
            ListView.separated(
    shrinkWrap: true,
    itemBuilder: (context, index){
    convertSearchPendapatan();
    //B39B9B
    return Container(
    height: 74,
    width: double.infinity,
    margin: EdgeInsets.only(left: 20, right: 20),
    decoration: BoxDecoration(
    color: Color(0xff414849),
    borderRadius: BorderRadius.circular(9),
    boxShadow: [
    BoxShadow(
    color: Colors.black.withOpacity(0.4),
    spreadRadius: 1,
    blurRadius: 9,
    offset: Offset(
    0, 1), // changes position of shadow
    ),
    ],
    ),
    padding: EdgeInsets.symmetric(horizontal: 15,),
    child: Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
    Image.asset("assets/income3.png", width: 45,height: 45, fit: BoxFit.fill,),
    SizedBox(width: 10,),
    Text("${searchPendapatan[index].sumberPendapatan} \nRp. ${nominalSearchPendapatan[index]}", style: TextStyle(color: Colors.white, fontSize: 15),),
    SizedBox(width: 5,),
    Expanded(child: Text("${searchPendapatan[index].tanggal}", style: TextStyle(color: Colors.white, fontSize: 12),maxLines: 2,overflow: TextOverflow.visible, textAlign: TextAlign.end,))
    ],
    ),
    );
    },
    separatorBuilder: (context, index){
    return SizedBox(height: 20,);
    },
    itemCount: searchPendapatan.length
    ):

          ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index){
                convert();
                //B39B9B
                return Container(
                  height: 74,
                  width: double.infinity,
                  margin: EdgeInsets.only(left: 20, right: 20),
                  decoration: BoxDecoration(
                      color: Color(0xff414849),
                      borderRadius: BorderRadius.circular(9),
                      boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.4),
                        spreadRadius: 1,
                        blurRadius: 9,
                        offset: Offset(
                            0, 1), // changes position of shadow
                      ),
                    ],
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 15,),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset("assets/income3.png", width: 45,height: 45, fit: BoxFit.fill,),
                      SizedBox(width: 10,),
                      Text("${pendapatan[index].sumberPendapatan} \nRp. ${jumlahNominalPendapatan[index]}", style: TextStyle(color: Colors.white, fontSize: 15),),
                      SizedBox(width: 5,),
                      Expanded(child: Text("${pendapatan[index].tanggal}", style: TextStyle(color: Colors.white, fontSize: 12),maxLines: 2,overflow: TextOverflow.visible, textAlign: TextAlign.end,))
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index){
                return SizedBox(height: 20,);
              },
              itemCount: pendapatan.length
          ),
        ),
      ],
    );
  }

  Widget tampilPengeluaran(){
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 15, bottom: 15, left: 20, right: 20),
          child: TextFormField(
            onChanged: onSearchPengeluaranTextChanged,
            controller: _searchPengeluarancontroller,
            style: TextStyle(fontSize: 16, color: Colors.white),
            decoration: InputDecoration(
              label: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset("assets/receiptsearch.png", color: Colors.white,height: 20,),
                  SizedBox(width: 10,),
                  Text("Cari riwayat pengeluran", style: TextStyle(color: Colors.white, fontSize: 11),)
                ],
              ),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white)
              ),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white)
              ),
            ),
          ),
        ),
        Container(
          height: size.height * 0.72,
          child:
          searchPengeluaran.length != 0 || _searchPengeluarancontroller.text.isNotEmpty ?
          ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index){
                convertSearchPengeluaran();
                //B39B9B
                return Container(
                  height: 74,
                  width: double.infinity,
                  margin: EdgeInsets.only(left: 20, right: 20),
                  decoration: BoxDecoration(
                    color: Color(0xff414849),
                    borderRadius: BorderRadius.circular(9),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.4),
                        spreadRadius: 1,
                        blurRadius: 9,
                        offset: Offset(
                            0, 1), // changes position of shadow
                      ),
                    ],
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 15,),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset("assets/outcomemerah.png", width: 45,height: 45, fit: BoxFit.fill,),
                      SizedBox(width: 10,),
                      Text("${searchPengeluaran[index].namaPengeluaran} \nRp. ${nominalSearchPengeluaran[index]}", style: TextStyle(color: Colors.white, fontSize: 15),),
                      SizedBox(width: 10,),
                      Expanded(child: Text("${searchPengeluaran[index].tanggal}", style: TextStyle(color: Colors.white, fontSize: 12),maxLines: 2,overflow: TextOverflow.visible, textAlign: TextAlign.end,))
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index){
                return SizedBox(height: 20,);
              },
              itemCount: searchPengeluaran.length
          )

              :
          ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index){
                convertPengeluaran();
                //B39B9B
                return Container(
                  height: 74,
                  width: double.infinity,
                  margin: EdgeInsets.only(left: 20, right: 20),
                  decoration: BoxDecoration(
                      color: Color(0xff414849),
                      borderRadius: BorderRadius.circular(9),
                      boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.4),
                        spreadRadius: 1,
                        blurRadius: 9,
                        offset: Offset(
                            0, 1), // changes position of shadow
                      ),
                    ],
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 15,),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset("assets/outcomemerah.png", width: 45,height: 45, fit: BoxFit.fill,),
                      SizedBox(width: 10,),
                      Text("${dataPengeluaran[index].namaPengeluaran} \nRp. ${jumlahNominalPengeluaran[index]}", style: TextStyle(color: Colors.white, fontSize: 15),),
                      SizedBox(width: 10,),
                      Expanded(child: Text("${dataPengeluaran[index].tanggal}", style: TextStyle(color: Colors.white, fontSize: 12),maxLines: 2,overflow: TextOverflow.visible, textAlign: TextAlign.end,))
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index){
                return SizedBox(height: 20,);
              },
              itemCount: dataPengeluaran.length
          ),
        ),
      ],
    );
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataPendapatan();
    getDataPengeluaran();
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xff253334),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(top: 45, ),
                width: size.width,
                child: Center(child: Image.asset("assets/title.png" ))),
            Container(
              margin: EdgeInsets.only(top: 35, left: 20, right: 20),
              height: 34,
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: Color(0xff2A8371)
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: (){
                      setState(() {
                        isSemua = false;
                        isPemasukan = true;
                        isPengeluaran = false;
                      });
                    },
                    child: Container(
                      height:25,
                      width: size.width * 0.4,
                      decoration: BoxDecoration(
                          color: isPemasukan ? Colors.white : Color(0xff2A8371),
                          borderRadius: BorderRadius.circular(12)
                      ),
                      child: Center(
                        child: Text("Pemasukan", style: TextStyle(color: isPemasukan ? Color(0xff51D285) : Colors.white, fontSize: 12),),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      setState(() {
                        isSemua = false;
                        isPemasukan = false;
                        isPengeluaran = true;
                      });
                    },
                    child: Container(
                      height:25,
                      width: size.width * 0.4,
                      decoration: BoxDecoration(
                          color: isPengeluaran? Colors.white : Color(0xff2A8371),
                          borderRadius: BorderRadius.circular(12)
                      ),
                      child: Center(
                        child: Text("Pengeluaran", style: TextStyle(color:isPengeluaran ? Color(0xff51D285) : Colors.white, fontSize: 12),),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            isPemasukan ?
            tampilPendapatan()
                : tampilPengeluaran()


          ],
        ),
      ),
    );
  }
}

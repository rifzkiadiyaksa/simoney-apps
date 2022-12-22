import 'package:finance_rifzki/ui/buat/buat_budget/buat_budget_screen.dart';
import 'package:finance_rifzki/ui/buat/dummy_budget.dart';
import 'package:finance_rifzki/ui/perencanaan/buat_perencanaan_screen.dart';
import 'package:finance_rifzki/ui/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../model/rencana/rencana.dart';
import '../Navigasi/navigasi.dart';
import 'package:intl/intl.dart';
import '../homescreen/home_screen.dart';

class PerencanaanScreen extends StatefulWidget {
  const PerencanaanScreen({Key? key}) : super(key: key);

  @override
  State<PerencanaanScreen> createState() => _PerencanaanScreenState();
}

class _PerencanaanScreenState extends State<PerencanaanScreen> {

  bool isIncome = true;
  bool isExpense = false;
  String tampilLimit = "0";
  String bulan = "jan";
  DateTime now = DateTime.now();
  String? limitPengeluaran;

  var uangbataspendapatan = MoneyMaskedTextController(
      thousandSeparator: '.',
      decimalSeparator: '',
      precision: 0);

  var uangbatasperencanaan = MoneyMaskedTextController(
      thousandSeparator: '.',
      decimalSeparator: '',
      precision: 0);

  var uangcontroller = MoneyMaskedTextController(
      thousandSeparator: '.',
      decimalSeparator: '',
      precision: 0);

  var jumlahnominalcontroller = MoneyMaskedTextController(
      thousandSeparator: '.',
      decimalSeparator: '',
      precision: 0);

  var uangbataspengeluaran = MoneyMaskedTextController(
      thousandSeparator: '.',
      decimalSeparator: '',
      precision: 0);

  String limitPendapatan = "0";
  List<Rencana> dataRencana = [];
  String limitRencanaValue = "0";

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
      getSisaLimit();
      print("disini limit rencana ${limitRencanaValue}");
    }else{
      print("belum ada limit perencanaan");
    }
  }

  void getSisaLimit(){
    double hitung = uangbataspendapatan.numberValue - uangbatasperencanaan.numberValue;
    setState(() {
      uangcontroller.text = hitung.toString().substring(0, hitung.toString().length -2);
      tampilLimit = uangcontroller.text;
    });
    print("disini tampil limit $tampilLimit");
    setState(() {

    });
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

  void convert() {
    for(int i = 0; i<dataRencana.length;i++){
      String nominal = dataRencana[i].jumlah!.substring(0, dataRencana[i].jumlah!.length -2);
      jumlahnominalcontroller.text = nominal;
      jumlahNominal.add(jumlahnominalcontroller.text);
    }
  }

  void getLimitPengeluaran() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if(pref.getString('limitPengeluaran') != null){

      setState(() {
        uangbataspengeluaran.text = pref.getString('limitPengeluaran')!.substring(0, (pref.getString('limitPengeluaran')!.length -2));
        limitPengeluaran = uangbataspendapatan.text;
      });
      print(uangbataspengeluaran.numberValue);
    }else{

    }

  }

  List<String> jumlahNominal = [];
  List<String> gambar = [];

  void ubahGambar(){
    for(int i=0;i<dataRencana.length;i++){
      if(dataRencana[i].kategori=="Transportasi"){
        gambar.add("assets/transportasi.png");
      }else if(dataRencana[i].kategori == "Makan"){
        gambar.add("assets/makan.png");
      }else if(dataRencana[i].kategori == "Tagihan"){
        gambar.add("assets/other.png");
      }else{
        gambar.add("assets/shop.png");
      }
    }
  }

  void tambahRencana(List<Rencana> rencana) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String encodedData = Rencana.encode(rencana);
    await pref.setString('rencana', encodedData);
    tambahlimitRencana();
    getData();
  }

  void tambahlimitRencana() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if(pref.getString('limitRencana') != null){
      List nums = [];
      for(int i = 0; i<dataRencana.length;i++){
        nums.add(double.parse(dataRencana[i].jumlah!));
      }
      double k = nums.fold(0, (p, n) => p+n);
      await pref.setString('limitRencana', k.toString());
      getLimitPerencanaan();
    }else{
      await pref.setString('limitRencana', uangcontroller.numberValue.toString());
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLimitPendapatan();
    getLimitPerencanaan();
    getData();
    getLimitPengeluaran();
    bulan = DateFormat("MMMM").format(now);
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
          return Navigasi();
        }));
        return true;
      },
      child: Scaffold(
        backgroundColor: Color(0xff253334),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: size.width,
                height: size.height * 0.35,
                decoration: BoxDecoration(
                  color: Color(0xff536D6C),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(32),
                      bottomRight: Radius.circular(32)
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 42),
                      child: Text("Batas rencana keuangan anda", style: TextStyle(color: Colors.white, fontSize: 14),),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 9),
                      child: Text("Rp. ${tampilLimit}", style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),),
                    ),
                    Container(
                      width: size.width,
                      height: 80,
                      margin: EdgeInsets.only(top: 27, left: 15, right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: (){
                              setState(() {
                                isIncome = true;
                                isExpense = false;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: isIncome ? Color(0xff52907A) : Color(0xff6F8B8A),
                                  borderRadius: BorderRadius.circular(28)
                              ),
                              height: 80,
                              width: size.width * 0.43,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset("assets/income2.png"),
                                  SizedBox(width: 10,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Pemasukan", style: TextStyle(color: Colors.white, fontSize: 12),),
                                      Text(limitPendapatan, style: TextStyle(color: Colors.white, fontSize: 15),),

                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              setState(() {
                                isIncome = false;
                                isExpense = true;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: isExpense ? Color(0xff52907A) : Color(0xff6F8B8A),
                                  borderRadius: BorderRadius.circular(28)
                              ),
                              height: 80,
                              width: size.width * 0.43,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset("assets/expense2.png"),
                                  SizedBox(width: 10,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Pengeluaran", style: TextStyle(color: Colors.white, fontSize: 12),),
                                      Text("${uangbataspengeluaran.text}", style: TextStyle(color: Colors.white, fontSize: 15),),

                                    ],
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),

              dataRencana.isEmpty ?
              Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Lottie.asset("assets/empty.json", animate: true),
                      Text("Belum ada data rencana", style: TextStyle(color: Colors.white),),
                    ],
                  ),
                ),
              )
                  :
              Container(
                width: size.width,
                height: size.height * 0.53,
                child: ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index){
                      convert();
                      ubahGambar();
                      return Container(
                        margin: EdgeInsets.only(left: 20, right: 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Image.asset(
                                  gambar[index], width: 45, height: 45, fit: BoxFit.fill,),
                                SizedBox(width: 10,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(dataRencana[index].namaRencana!, style: TextStyle(fontSize: 20, color: Colors.white), maxLines: 3, overflow: TextOverflow.ellipsis,),
                                    Text("Limit budget $bulan", style: TextStyle(color: Colors.white, fontSize: 12),),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text("Rp. ${jumlahNominal[index]}", style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 15),),
                                SizedBox(width: 5,),
                                InkWell(
                                    onTap: () async {
                                      SharedPreferences pref = await SharedPreferences.getInstance();
                                      if(pref.getString('limitPengeluaran') != null){
                                        String limitexpanse = pref.getString('limitPengeluaran')!;
                                        double hitung = double.parse(limitexpanse) - double.parse(dataRencana[index].terpakai!);
                                        pref.setString('limitPengeluaran', hitung.toString());
                                      }
                                      setState(() {
                                        dataRencana.removeAt(index);
                                      });
                                      tambahRencana(dataRencana);
                                      getLimitPerencanaan();
                                      getLimitPengeluaran();
                                      Navigator.push(context, MaterialPageRoute(builder: (context){
                                        return PerencanaanScreen();
                                      }));
                                    },
                                    child: Image.asset("assets/trash.png"))
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index){
                      return SizedBox(height: 15,);
                    },
                    itemCount: dataRencana.length
                ),
              )
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: InkWell(
          onTap: (){
            Navigator.push(context,MaterialPageRoute(builder: (context){
              return BuatPerencanaanScreen();
            }));
          },
          child: Container(
              height: 56,
              width: size.width,
              margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
              decoration: BoxDecoration(
                  color: Color(0xff7C9A92),
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Center(
                child: Text("Buat Budget", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),),
              )
          ),
        ),
      ),
    );
  }
}

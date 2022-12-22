import 'package:finance_rifzki/ui/buat/buat_screen.dart';
import 'package:finance_rifzki/ui/profile/profile_screen.dart';
import 'package:finance_rifzki/ui/webview/webview_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../model/rencana/rencana.dart';
import 'dummy_data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  bool isVisible = true;
  bool isExpand = false;
  String sisaLimit = "0";
  String? visiblee;
  
  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }

  var uangcontroller = MoneyMaskedTextController(
      thousandSeparator: '.',
      decimalSeparator: '',
      precision: 0);

  var uangbataspendapatan = MoneyMaskedTextController(
      thousandSeparator: '.',
      decimalSeparator: '',
      precision: 0);

  var uangbataspengeluaran = MoneyMaskedTextController(
      thousandSeparator: '.',
      decimalSeparator: '',
      precision: 0);

  var uangbatasperencanaan = MoneyMaskedTextController(
      thousandSeparator: '.',
      decimalSeparator: '',
      precision: 0);

  var jumlahnominalcontroller = MoneyMaskedTextController(
      thousandSeparator: '.',
      decimalSeparator: '',
      precision: 0);

  var terpakaicontroller = MoneyMaskedTextController(
      thousandSeparator: '.',
      decimalSeparator: '',
      precision: 0);

  var sisaLimitTotal = MoneyMaskedTextController(
      thousandSeparator: '.',
      decimalSeparator: '',
      precision: 0);

  String limitPendapatan = "0";
  String limitPengeluaran = "0";
  List<Rencana> dataRencana = [];
  String limitRencanaValue = "0";
  bool isView = true;

  void convert() {
    for(int i = 0; i<dataRencana.length;i++){
      String nominal = dataRencana[i].jumlah!.substring(0, dataRencana[i].jumlah!.length -2);
      jumlahnominalcontroller.text = nominal;
      jumlahNominal.add(jumlahnominalcontroller.text);
      if(dataRencana[i].terpakai! == "0"){
        terpakai.add("0");
      }else{
        String terpakaiString = dataRencana[i].terpakai!.substring(0, dataRencana[i].terpakai!.length -2);
        terpakaicontroller.text = terpakaiString;
        terpakai.add(terpakaicontroller.text);
      }
      // print("daisini data terpakai ${double.parse(dataRencana[i].terpakai!)}");
      // double coba = double.parse(dataRencana[i].terpakai!) /400000;
      // print("disini hasil bagii $coba");
    }
  }

  void hitung(){
    for(int i=0;i<dataRencana.length;i++){
      double hasil = (double.parse(dataRencana[i].terpakai!)/double.parse(dataRencana[i].jumlah!));
      nums.add(hasil);
    }
  }

  List<String> jumlahNominal = [];
  List<double> nums = [];
  List<String> terpakai = [];
  String nama = "harap tunggu";

  void getLimitPendapatan() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if(pref.getString('limit') != null){

      setState(() {
        uangbataspendapatan.text = pref.getString('limit')!.substring(0, (pref.getString('limit')!.length -2));
        limitPendapatan = uangbataspendapatan.text;
      });
      print(uangbataspendapatan.numberValue);
      print("disini ada kok");
    }else{
      print("belum ada limit pendapatan");
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
    calculateLimit();
  }

  void calculateLimit() async {
    double sisaLimit = uangbataspendapatan.numberValue - uangbataspengeluaran.numberValue;
    setState(() {
      sisaLimitTotal.text = sisaLimit.toString().substring(0, sisaLimit.toString().length -2);
    });
    print("disini double sisa limit $sisaLimit");
    print("disini double pendapatan ${uangbataspendapatan.numberValue}");
    print("disini double pengeluaran ${uangbataspengeluaran.numberValue}");


    print("disini sisa limit Total ${sisaLimitTotal.text}");
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

  void getData() async {

    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      nama = pref.getString('namaLengkap')!;
    });
    if(pref.getString('rencana') != null ){
      final String listRencana = await pref.getString('rencana')!;
      setState(() {
        dataRencana = Rencana.decode(listRencana);
        visiblee = pref.getString('visible');
      });
      String encodedData = Rencana.encode(dataRencana);
      print(encodedData);
    }else{
      print("no data");
    }

    setState(() {
      visiblee = pref.getString('visible');
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getLimit();
    getLimitPendapatan();
    getData();
    getLimitPengeluaran();
    // calculateLimit();
    // clearData();
  }

  void clearData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
  }

  void getLimit() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if(pref.getString('limit') != null){
      setState(() {
        uangcontroller.text = pref.getString('limit')!.substring(0, (pref.getString('limit')!.length -2));
        sisaLimit = uangcontroller.text;
      });
    }else{
      print("belum ada data limit");
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        final shouldClose = await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Peringatan"),
              content: Text("Apakah Anda yakin ingin menutup aplikasi?"),
              actions: <Widget>[
                TextButton(
                  child: Text("Tidak"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text("Ya"),
                  onPressed: () {
                    SystemNavigator.pop();
                  },
                ),
              ],
            );
          },
        );
        return shouldClose;
      },
      child: Scaffold(
        backgroundColor: Color(0xff253334),
        body: SingleChildScrollView(
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 280,
                width: size.width,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Image.asset("assets/header.png", width: size.width,),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 40, left: 20, right: 20),
                            width: size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Selamat datang,", style: TextStyle(color: Colors.white, fontSize: 12),),
                                    Text(nama, style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),)
                                  ],
                                ),
                                InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context){
                                      return ProfileScreen();
                                    }));
                                  },
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text("Riwayat", style: TextStyle(color: Colors.white, fontSize: 12),),
                                      SizedBox(width: 5,),
                                      Image.asset("assets/receiptitem.png", width: 20, height: 20, fit: BoxFit.fill,)
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 25,),
                          FittedBox(
                              child: Container(
                                margin: EdgeInsets.only(left: 20, right: 20),
                                child: Text(
                                  "Sisa keuangan kamu",
                                  style: TextStyle(color: Colors.white,
                                      fontSize:12),
                                ),
                              )
                          ),
                          SizedBox(height: 5,),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Rp ", style: TextStyle(fontSize: 16, color: Colors.white),),
                              isView ?Text("${sisaLimitTotal.text}", style: TextStyle(color: Colors.white, fontSize: 30),)
                              : Text("******", style: TextStyle(color: Colors.white, fontSize: 30),),
                              SizedBox(width: 8,),
                              InkWell(
                                  onTap: (){
                                    setState(() {
                                      isView = !isView;
                                    });
                                  },
                                  child: Icon(isView ? Icons.visibility_outlined : Icons.visibility_off_outlined, size: 20,color: Colors.white,))
                            ],
                          ),
                          SizedBox(height:  40,),
                          Container(
                            height: 70,
                            width: size.width,
                            margin: EdgeInsets.only(left: 20, right: 20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12)
                            ),
                            padding: EdgeInsets.all(10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text("Pemasukan", style: TextStyle(color: Color(0xff91919F), fontSize: 14),),
                                        Text(uangbataspendapatan.text, style: TextStyle(color: Colors.black, fontSize: 16),)
                                      ],
                                    ),
                                    SizedBox(width: 10,),
                                    Image.asset("assets/income_ijo.png")
                                    ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image.asset("assets/expanse_merah.png"),
                                    SizedBox(width: 10,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text("Pengeluaran", style: TextStyle(color: Color(0xff91919F), fontSize: 14),),
                                        Text("${uangbataspengeluaran.text}", style: TextStyle(color: Colors.black, fontSize: 16),)
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 20,),
                  Text("Ringkasan", style: TextStyle(fontSize: 18, color: Color(0xffFCFCFC).withOpacity(0.64)),),
                ],
              ),
              SizedBox(height: 10,),

              dataRencana.isEmpty ?
              Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Lottie.asset("assets/empty.json", animate: true),
                      Text("Belum ada data", style: TextStyle(color: Colors.white),),
                    ],
                  ),
                ),
              ) :
              ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.only(top: 5, bottom: 5),
                  itemBuilder: (context, index){
                    convert();
                    hitung();
                    // print(dataRencana[index].terpakai);
                    return Container(
                      width: size.width,
                      height: 135,
                      margin: EdgeInsets.only(left: 20, right: 20),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                backgroundColor: Color(0xff44897D),
                                radius: 8,
                              ),
                              SizedBox(width: 10,),
                              Text("${dataRencana[index].namaRencana}", style: TextStyle(fontSize: 16, color: Colors.black),),
                            ],
                          ),
                          Text("Total Rp.${terpakai[index]}", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                          ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: LinearProgressIndicator(
                                value: nums[index],
                                color: Color(0xff90A0B1),
                                backgroundColor: Color(0xffF1F1FA),
                                minHeight: 12,
                              )
                          ),
                          Text("${terpakai[index]}/${jumlahNominal[index]}", style: TextStyle(color: Colors.grey, fontSize: 16),)
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index){
                    return SizedBox(height: 17,);
                  },
                  itemCount: dataRencana.length
              ),
              SizedBox(height: 100,)

            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton:visiblee != 'null' ? Container(
          height: 170,
          margin: EdgeInsets.only(bottom: 45),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: InkWell(
                    onTap: () async {
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return WebViewScreen(
                          url: "https://syo.biz.id/id/Tutorial",
                          judul: "Tutorial",
                        );
                      }));
                      // _launchInBrowser(Uri.parse("https://links.simoney.my.id/Tutorial"));
                    },
                    child: Image.asset(
                        "assets/bannervideo.png")),
              ),
              Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.only(right: 20),
                    child: Image.asset("assets/orangkaget.png"),
                  )
              ),
              Positioned(
                  top: 15,
                  right: 20,
                  child: InkWell(
                    onTap: () async {
                      SharedPreferences pref = await SharedPreferences.getInstance();
                      pref.setString('visible', 'null');
                      setState(() {
                        visiblee = pref.getString('visible');
                      });
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.black,
                      radius: 16,
                      child: Icon(Icons.clear, color: Colors.white, size: 16,),
                    ),
                  )
              )
            ],
          ),
        ) : SizedBox(),
      ),
    );
  }
}

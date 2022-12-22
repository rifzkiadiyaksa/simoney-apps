import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
class BuatBudgetScreen extends StatefulWidget {
  const BuatBudgetScreen({Key? key}) : super(key: key);

  @override
  State<BuatBudgetScreen> createState() => _BuatBudgetScreenState();
}

class _BuatBudgetScreenState extends State<BuatBudgetScreen> {

  TextEditingController _budgetController = TextEditingController();
  var uangcontroller = MoneyMaskedTextController(
      thousandSeparator: '.',
      decimalSeparator: '',
      precision: 0);

  bool isRepeat = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xff253334),
      body: Stack(
        children: [
          Positioned(
            left: 20,
              right: 20,
              top: 48,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Buat Budget", style: TextStyle(color: Colors.white, fontSize: 35),),
                  SizedBox(height: 30,),
                  Text("Limit Budget", style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 18),),
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
                  Image.asset("assets/angka.png")
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
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16.0),
                                borderSide: BorderSide(
                                  color: Colors.black.withOpacity(0.2),
                                ),
                              ),
                              labelText: "Nama",
                              labelStyle: TextStyle(fontSize: 18),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16.0),
                                borderSide: BorderSide(
                                  color: Colors.black.withOpacity(0.2),
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
                                color: Colors.black.withOpacity(0.2)
                              )
                          ),
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Kategori", style: TextStyle(fontSize: 16, color: Colors.black),),
                              Icon(Icons.expand_more, color: Colors.black, size: 25,)
                            ],
                          ),
                        ),
                        SizedBox(height: 15,),
                        Container(
                          height: 56,
                          width: size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                  color: Colors.black.withOpacity(0.2)
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
                    Container(
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
                    )
                  ],
                ),
              ),
          )
        ],
      ),
    );
  }
}

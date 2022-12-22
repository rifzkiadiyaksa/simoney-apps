import 'package:finance_rifzki/ui/buat/buat_budget/buat_budget_screen.dart';
import 'package:finance_rifzki/ui/buat/dummy_budget.dart';
import 'package:finance_rifzki/ui/profile/profile_screen.dart';
import 'package:flutter/material.dart';

import '../homescreen/home_screen.dart';

class BuatScreen extends StatefulWidget {
  const BuatScreen({Key? key}) : super(key: key);

  @override
  State<BuatScreen> createState() => _BuatScreenState();
}

class _BuatScreenState extends State<BuatScreen> {

  bool isIncome = true;
  bool isExpense = false;


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
                      child: Text("Limit Budget", style: TextStyle(color: Colors.white, fontSize: 14),),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 9),
                    child: Text("Rp. 5.000.000", style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),),
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
                                    Text("5.000.000", style: TextStyle(color: Colors.white, fontSize: 15),),

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
                                    Text("2.500.000", style: TextStyle(color: Colors.white, fontSize: 15),),

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
            SizedBox(height: 10,),
            ListView.separated(
              shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index){
                  return Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(listBudget[index].gambar!),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(listBudget[index].judul!, style: TextStyle(fontSize: 20, color: Colors.white),),
                            Text(listBudget[index].deskripsi!, style: TextStyle(color: Colors.white, fontSize: 12),),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(listBudget[index].harga!, style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 15),),
                            SizedBox(width: 5,),
                            Image.asset("assets/trash.png")
                          ],
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index){
                  return SizedBox(height: 15,);
                },
                itemCount: listBudget.length
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          InkWell(
            onTap: (){
              Navigator.push(context,MaterialPageRoute(builder: (context){
                return BuatBudgetScreen();
              }));
            },
            child: Container(
              height: 56,
              width: size.width,
              margin: EdgeInsets.only(left: 20, right: 20),
              decoration: BoxDecoration(
                  color: Color(0xff7C9A92),
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Center(
                child: Text("Buat Budget", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),),
              )
            ),
          ),
          SizedBox(height: 5,),
          Padding(
            padding: EdgeInsets.only(bottom: 5.0, left: size.width * 0.14, right: size.width * 0.12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                    onTap:(){
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return HomeScreen();
                      }));
                    },
                    child: Image.asset("assets/syonavbar.png")),
                SizedBox(width: size.width * 0.1,),
                InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return BuatScreen();
                      }));
                    },
                    child: Image.asset("assets/plusnavbar.png")),
                SizedBox(width: size.width * 0.15,),
                InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return ProfileScreen();
                      }));
                    },
                    child: Image.asset("assets/profilenavbar.png"))
              ],
            ),
          ),
        ],
      ),
    );
  }
}

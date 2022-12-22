import 'package:finance_rifzki/ui/buat/buat_screen.dart';
import 'package:finance_rifzki/ui/eksplore/eksplore_screen.dart';
import 'package:finance_rifzki/ui/homescreen/home_screen.dart';
import 'package:finance_rifzki/ui/pendapatan/pendapatan_screen.dart';
import 'package:finance_rifzki/ui/pengeluaran/PengeluaranScreen.dart';
import 'package:finance_rifzki/ui/perencanaan/buat_perencanaan_screen.dart';
import 'package:finance_rifzki/ui/perencanaan/perencanaan_screen.dart';
import 'package:finance_rifzki/ui/profile/profile_screen.dart';
import 'package:flutter/material.dart';

class Navigasi extends StatefulWidget {
  const Navigasi({Key? key}) : super(key: key);

  @override
  State<Navigasi> createState() => _NavigasiState();
}

class _NavigasiState extends State<Navigasi> {

  List<Widget> halaman =[
    HomeScreen(),
    // BuatScreen(),
    EksploreScreen()
  ];

  bool isVisible = false;

  int selectedIndex = 0;

  void onItemTap(int index) {
    if(isVisible == true){
      setState(() {
        isVisible = false;
      });
    }
    setState(() {
      selectedIndex = index;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          isVisible?
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                        onTap:(){
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return PerencanaanScreen();
                          }));
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(

                              decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(32)
                              ),
                              height: 20,
                              width: 110,
                              child: Center(
                                child: Text("Perencanaan", style: TextStyle(fontSize: 14),),
                              ),
                            ),
                            SizedBox(height: 11,),
                            Image.asset("assets/plan_new.png", width: 45, height: 45, fit: BoxFit.fill,),
                          ],
                        )),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                            onTap:(){
                              Navigator.push(context, MaterialPageRoute(builder: (context){
                                return PendapatanScreen();
                              }));
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(32)
                                  ),
                                  height: 20,
                                  width: 110,
                                  child: Center(
                                    child: Text("Pemasukan", style: TextStyle(fontSize: 14),),
                                  ),
                                ),
                                SizedBox(width: 7,),
                                Image.asset(
                                  "assets/income_new.png", width: 45, height: 45, fit: BoxFit.fill,),
                              ],
                            )),

                        InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context){
                              return PengeluaranScreen();
                            }));
                          },
                            child:
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [

                                Image.asset(
                                  "assets/expanse_new.png", width: 45, height: 45, fit: BoxFit.fill,),
                                SizedBox(width: 7,),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(32)
                                  ),
                                  height: 20,
                                  width: 110,
                                  child: Center(
                                    child: Text("Pengeluaran", style: TextStyle(fontSize: 14),),
                                  ),
                                ),
                              ],
                            )),
                      ],
                    )
                  ],
                ),
              )
              : SizedBox(),
          InkWell(
            onTap: (){
              setState(() {
                isVisible = !isVisible;
              });
            },
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 18,
              child: Icon(isVisible ? Icons.clear : Icons.add, size: 25, color: Colors.black,),
            ),
          ),
          SizedBox(height: 20,)
        ],
      ),
      bottomNavigationBar: Container(
        height: 60,
        margin: EdgeInsets.only(bottom: 0, left: 0, right: 0),
        child: BottomNavigationBar(
          backgroundColor:  Color(0xff253334),
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Image.asset("assets/logolagi.png", width: 30, height: 30,),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Image.asset("assets/settings.png", width: 25, height: 25,),
              label: '',
            ),
          ],
          selectedItemColor: Colors.white,
          unselectedItemColor: const Color(0xff9CA3AF),
          onTap: onItemTap,
          currentIndex: selectedIndex,
          showUnselectedLabels: false,
          showSelectedLabels: false,
        ),
      ),
      extendBody: true,
      body: halaman.elementAt(selectedIndex),
    );
  }
}

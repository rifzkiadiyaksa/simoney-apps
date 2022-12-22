import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:finance_rifzki/ui/eksplore/blog_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../webview/webview_screen.dart';
import 'kerja_data.dart';

class EksploreScreen extends StatefulWidget {
  const EksploreScreen({Key? key}) : super(key: key);

  @override
  State<EksploreScreen> createState() => _EksploreScreenState();
}

final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
];

class _EksploreScreenState extends State<EksploreScreen> {

  int _current = 0;
  final CarouselController _controller = CarouselController();
  bool isIntern = true;
  bool isFull = false;
  bool isPart = false;

  List<DataKerja> listIntern = [
    DataKerja(
      gambar: "assets/BFI.png",
      judul: "Technical Lead",
      filter: "Internship",
      link: "https://www.kalibrr.com/c/bfifinance/jobs/207973/technical-lead-bravo-division",
      gaji: "Rp.4,5 JT"
    ),
    DataKerja(
      gambar: "assets/kitabisa.png",
      judul: " Business Intelligence Analyst",
      filter: "Internship",
      link: "https://www.kalibrr.com/c/kitabisa-com/jobs/182695/remote-senior-business-intelligence-analyst",
        gaji: "Rp.3,3 JT"
    ),
    DataKerja(
      gambar: "assets/niagahoster.png",
      judul: "Customer Succes",
      filter: "Internship",
      link: " https://www.kalibrr.com/c/niagahoster-pt-web-media-technology-indonesia/jobs/200220/web-hosting-customer-success-specialist-english-fluent-global-team",
        gaji: "Rp.4,8 JT"
    ),
  ];

  List<DataKerja> dataFull = [
    DataKerja(
      gambar: "assets/bca.png",
      judul: "IT System Infrastructure Engineer",
      filter: "Full Time",
      link: "https://www.kalibrr.com/c/bank-central-asia-1/jobs/196084/it-system-infrastructure-engineer",
      gaji: "Rp.7,4 JT"
    ),
    DataKerja(
      gambar: "assets/bca.png",
      judul: "Relationship Officer",
      filter: "Full Time",
      link: "https://www.kalibrr.com/c/bank-central-asia-1/jobs/211498/relationship-officer",
      gaji: "Rp.8,4 JT"
    ),
     DataKerja(
      gambar: "assets/xxi.png",
      judul: "DevOps Engineer",
      filter: "Full Time",
      link: "https://www.kalibrr.com/c/nsr-cinema-xxi/jobs/105933/devops-engineer",
         gaji: "Rp.9,4 JT"
    ),
  ];

  List<DataKerja> dataPart = [
    DataKerja(
      gambar: "assets/bobox.png",
      filter: "Part Time",
      judul: "Construction Engineer",
      link: "https://www.kalibrr.com/c/bobobox-id/jobs/212645/construction-engineer-manager",
      gaji: "Rp.2,4 JT"
    ),
    DataKerja(
      gambar: "assets/btpn.png",
      judul: "UI/UX Writer",
      filter: "Part Time",
      gaji: "Rp.5 JT",
      link: "https://www.kalibrr.com/c/btpn/jobs/215841/ui-ux-writer-intern-ideas-2"
    ),
    DataKerja(
      gambar: "assets/doku.png",
      judul: "Security Architect",
      filter: "Part Time",
      gaji: "Rp.8,5 JT",
      link: "https://www.kalibrr.com/c/doku-indonesia/jobs/209137/security-architect"
    ),
    DataKerja(
      gambar: "assets/mandiri-taspen.png",
      judul: "IT Security",
      filter: "Part Time",
      gaji: "Rp.7,5 JT",
      link: "https://www.kalibrr.com/c/pt-bank-mandiri-taspen/jobs/215345/information-technology-it-security"
    ),



  ];





  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    
    List<Widget> itemBlog = blog
        .map((item) => InkWell(
      onTap:(){
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return WebViewScreen(
            url: item.link,
            judul: "Eksplore",
          );
        }));
      } ,
      child: Container(
        margin: EdgeInsets.all(5),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          child: Stack(
            children: [
              Container(
                width: 500,
                height: 200,
                padding: EdgeInsets.only(left: 15, right: 15),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xff2A8371),
                      Color(0xff7C9A92)
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Row(

                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(top: 23, bottom: 23),
                        child:  Column(
                          children: [
                            Flexible(child: Text(item.judul!, overflow: TextOverflow.visible, maxLines: 3, style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),)),
                            SizedBox(height: 15,),
                            Text("Kategori", style: TextStyle(color: Colors.white, fontSize: 10),),
                            Text("Tips & Trik", style: TextStyle(color: Colors.white, fontSize: 15),),
                            SizedBox(height: 15,),
                            Container(
                              height: 23,
                              width: 100,
                              padding: EdgeInsets.only(left: 5, right: 5),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20)
                              ),
                              child: FittedBox(child: Text("Baca Sekarang", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),)),
                            )
                          ],
                          crossAxisAlignment: CrossAxisAlignment.start,
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Image.asset(item.image!, height: 130, width: 100, fit: BoxFit.fill,),
                      ],
                    )
                  ],
                ),
              ),

            ],
          ),
        ),

      ),
    )
    ).toList();

    return Scaffold(
      backgroundColor: Color(0xff253334),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: 20, top: 50, bottom: 17),
              child: Text("Eksplore", style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 28),),
            ),
            CarouselSlider(
              items: itemBlog,
              carouselController: _controller,
              options: CarouselOptions(
                  autoPlay: true,
                  enlargeCenterPage: true,

                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: itemBlog.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () => _controller.animateToPage(entry.key),
                  child: Container(
                    width: 8.0,
                    height: 8.0,
                    margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                    decoration: BoxDecoration(
                        shape: _current == entry.key ? BoxShape.rectangle :BoxShape.circle,
                        color: (Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Color(0xff7C9A92))
                            .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 46,),
            Container(
              margin: EdgeInsets.only(left: 20,right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Tambah Pemasukan", style: TextStyle(color: Colors.white, fontSize: 16),),
                  SizedBox(height: 26,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                          onTap:(){
                            setState(() {
                              isIntern = true;
                              isFull = false;
                              isPart = false;
                            });
                          },
                          child: Text("Internship", style: TextStyle(fontSize: 14, color:isIntern ? Color(0xff72978E) :Color(0xff949494)),)),
                      SizedBox(width: 10,),
                      InkWell(
                          onTap: (){
                            setState(() {
                              isIntern = false;
                              isFull = true;
                              isPart = false;
                            });
                          },
                          child: Text("Full Time", style: TextStyle(fontSize: 14, color: isFull ? Color(0xff72978E) :Color(0xff949494)),)),
                      SizedBox(width: 10,),
                      InkWell(
                          onTap: (){
                            setState(() {
                              isIntern = false;
                              isFull = false;
                              isPart = true;
                            });
                          },
                          child: Text("Part Time", style: TextStyle(fontSize: 14, color: isPart ? Color(0xff72978E) :Color(0xff949494)),))
                    ],
                  ),
                  isIntern ?
                      ListView.separated(
                        shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index){
                            return InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context){
                                  return WebViewScreen(
                                    url: listIntern[index].link,
                                    judul: "Eksplore",
                                  );
                                }));
                              },
                              child: Container(
                                height: 80,
                                width: size.width,

                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16)
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image.asset(listIntern[index].gambar!, width: 60, height: 60, fit: BoxFit.fill,),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(listIntern[index].judul!, style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15 ),maxLines: 2, overflow: TextOverflow.visible,)
                                          ,Text(listIntern[index].filter!, style: TextStyle(color: Colors.grey),)
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 85,
                                      height: 42,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: Color(0xff657F79).withOpacity(0.47)
                                      ),
                                      child: Center(
                                        child: Text(listIntern[index].gaji!, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index){
                            return SizedBox(height: 17,);
                          },
                          itemCount: listIntern.length)
                      : SizedBox(),
                  isFull ?
                      ListView.separated(
                        shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index){
                            return InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context){
                                  return WebViewScreen(
                                    url: dataFull[index].link,
                                    judul: "Eksplore",
                                  );
                                }));
                              },
                              child: Container(
                                height: 80,
                                width: size.width,

                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16)
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image.asset(dataFull[index].gambar!, width: 60, height: 60, fit: BoxFit.fill,),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(dataFull[index].judul!, style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15 ),maxLines: 2, overflow: TextOverflow.visible,)
                                          ,Text(dataFull[index].filter!, style: TextStyle(color: Colors.grey),)
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 85,
                                      height: 42,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: Color(0xff657F79).withOpacity(0.47)
                                      ),
                                      child: Center(
                                        child: Text(dataFull[index].gaji!, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index){
                            return SizedBox(height: 17,);
                          },
                          itemCount: dataFull.length)
                      : SizedBox(),
                  isPart ?
                      ListView.separated(
                        shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index){
                            return InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context){
                                  return WebViewScreen(
                                    url: dataPart[index].link,
                                    judul: "Eksplore",
                                  );
                                }));
                              },
                              child: Container(
                                height: 80,
                                width: size.width,

                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16)
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image.asset(dataPart[index].gambar!, width: 60, height: 60, fit: BoxFit.fill,),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(dataPart[index].judul!, style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15 ),maxLines: 2, overflow: TextOverflow.visible,)
                                          ,Text(dataPart[index].filter!, style: TextStyle(color: Colors.grey),)
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 85,
                                      height: 42,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: Color(0xff657F79).withOpacity(0.47)
                                      ),
                                      child: Center(
                                        child: Text(dataPart[index].gaji!, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index){
                            return SizedBox(height: 17,);
                          },
                          itemCount: dataPart.length)
                      : SizedBox(),


                ],
              ),
            )

          ],
        ),
      ),
    );
  }
}


final List<String> coba =[];


List<DataBlog> blog = [
  DataBlog(
      image: "assets/blog1.png",
      link: "https://simoney.my.id/investasi-milenials.html",
      judul: "Investasi Milenials"
  ),
  DataBlog(
      image: "assets/blog2.png",
      link: "https://simoney.my.id/karir-untuk-masa-depan.html",
      judul: "Karir Masa Depan"
  ),
  DataBlog(
      image: "assets/blog3.png",
      link: "https://simoney.my.id/perempuan-merdeka-finansial",
      judul: "Perempuan Merdeka Finansial"
  ),
  DataBlog(
      image: "assets/blog4.png",
      link: "https://simoney.my.id/kesalahan-dalam-menentukan-investasi",
      judul: "Kesalahan Dalam Menentukan Investasi"
  ),
  DataBlog(
      image: "assets/blog5.png",
      link: "https://simoney.my.id/tools-bisnis",
      judul: "Tools Bisnis Digital"
  ),

];

final List<Widget> imageSliders = imgList
    .map((item) => Container(
  child: Container(
    margin: EdgeInsets.all(5.0),
    child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        child: Stack(
          children: <Widget>[
            Image.network(item, fit: BoxFit.cover, width: 1000.0),
            Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(200, 0, 0, 0),
                      Color.fromARGB(0, 0, 0, 0)
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
                padding: EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 20.0),
                child: Text(
                  'No. ${imgList.indexOf(item)} image',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        )),
  ),
))
    .toList();

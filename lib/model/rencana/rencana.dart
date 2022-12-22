import 'dart:convert';

class Rencana{
  String? namaRencana;
  String? jumlah;
  String? terpakai;
  String? kategori;
  bool? berulang;

  Rencana({
   this.namaRencana,
   this.jumlah,
   this.terpakai,
   this.kategori,
   this.berulang
  });

  factory Rencana.fromJson(Map<String, dynamic> jsonData){
    return Rencana(
      namaRencana: jsonData['namaRencana'],
      jumlah:  jsonData['jumlah'],
      terpakai: jsonData['terpakai'],
      kategori: jsonData['kategori'],
      berulang: false
    );
  }

  static Map<String, dynamic> toMap(Rencana rencana) => {
    'namaRencana':rencana.namaRencana,
    'jumlah':rencana.jumlah,
    'terpakai':rencana.terpakai,
    'kategori':rencana.kategori,
    'berulang':rencana.berulang
  };

  static String encode(List<Rencana> rencana) => jsonEncode(
    rencana
    .map<Map<String, dynamic>>((rencana) => Rencana.toMap(rencana)
    ).toList()
  );

  static List<Rencana> decode(String rencana) =>
      (jsonDecode(rencana) as List<dynamic>)
      .map<Rencana>((item) => Rencana.fromJson(item)).toList();
}
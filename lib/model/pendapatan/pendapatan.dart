import 'dart:convert';

class Pendapatan{
  String? sumberPendapatan;
  String? jumlah;
  bool? berulang;
  String? tanggal;

  Pendapatan({
    this.sumberPendapatan,
    this.jumlah,
    this.berulang,
    this.tanggal
  });

  factory Pendapatan.fromJson(Map<String, dynamic> jsonData){
    return Pendapatan(
      sumberPendapatan: jsonData['sumberPendapatan'],
      jumlah: jsonData['jumlah'],
      berulang: false,
      tanggal: jsonData['tanggal']
    );
  }

  static Map<String, dynamic> toMap(Pendapatan pendapatan) => {
    'sumberPendapatan':pendapatan.sumberPendapatan,
    'jumlah':pendapatan.jumlah,
    'berulangl':pendapatan.berulang,
    'tanggal':pendapatan.tanggal
  };

  static String encode(List<Pendapatan> pendapatan) => jsonEncode(
      pendapatan
          .map<Map<String, dynamic>>((pendapatan) => Pendapatan.toMap(pendapatan)
      ).toList()
  );

  static List<Pendapatan> decode(String pendapatan) =>
      (jsonDecode(pendapatan) as List<dynamic>)
          .map<Pendapatan>((item) => Pendapatan.fromJson(item)).toList();




}
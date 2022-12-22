import 'dart:convert';

class Pengeluaran{
  String? namaPengeluaran;
  String? jumlah;
  String? jenis;
  String? tanggal;

  Pengeluaran({
      this.namaPengeluaran,
    this.jumlah,
    this.jenis,
    this.tanggal
  });

  factory Pengeluaran.fromJson(Map<String, dynamic> jsonData){
    return Pengeluaran(
      namaPengeluaran: jsonData['namaPengeluaran'],
      jumlah: jsonData['jumlah'],
      jenis: jsonData['jenis'],
      tanggal: jsonData['tanggal']
    );
  }

  static Map<String, dynamic> toMap(Pengeluaran pengeluaran) => {
    'namaPengeluaran':pengeluaran.namaPengeluaran,
    'jumlah':pengeluaran.jumlah,
    'jenis':pengeluaran.jenis,
    'tanggal':pengeluaran.tanggal
  };

  static String encode(List<Pengeluaran> pengeluaran) => jsonEncode(
    pengeluaran
      .map<Map<String, dynamic>>((pengeluaran) => Pengeluaran.toMap(pengeluaran)
    ).toList()
  );

  static List<Pengeluaran> decode(String pengeluaran) =>
      (jsonDecode(pengeluaran) as List<dynamic>)
        .map<Pengeluaran>((item) => Pengeluaran.fromJson(item)).toList();

}
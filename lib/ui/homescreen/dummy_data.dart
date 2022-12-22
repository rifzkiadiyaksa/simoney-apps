class DummyData {
  String? nama;
  String? awal;
  String? akhir;
  double? value;
  int? warna;


  DummyData({
    this.nama,
    this.awal,
    this.akhir,
    this.value,
    this.warna
  });

}

List<DummyData> listData = [
  DummyData(
    nama: 'Transportasi',
    awal: '27.000',
    akhir: '150.000',
    value: 0.6,
    warna: 0xff44897D
  ),
  DummyData(
      nama: 'Makan',
      awal: '100.000',
      akhir: '200.000',
      value: 0.4,
      warna: 0xff44897D
  ),
  DummyData(
      nama: 'Parkir',
      awal: '30.000',
      akhir: '200.000',
      value: 0.7,
      warna: 0xff44897D
  ),
];
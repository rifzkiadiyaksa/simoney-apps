class DummyBudget {
  String? gambar;
  String? judul;
  String? deskripsi;
  String? harga;

  DummyBudget({
    this.gambar,
    this.judul,
    this.deskripsi,
    this.harga
  });
}

List<DummyBudget> listBudget = [
  DummyBudget(
    gambar: "assets/makan.png",
    judul: "Makan",
    deskripsi: "Limit budget Desember",
    harga: "Rp.100.000"
  ),
  DummyBudget(
    gambar: "assets/transportasi.png",
    judul: "Transportasi",
    deskripsi: "Limit budget Desember",
    harga: "Rp.150.000"
  ),
  DummyBudget(
    gambar: "assets/shop.png",
    judul: "Beli CD K-Pop",
    deskripsi: "Limit budget Desember",
    harga: "Rp.200.000"
  ),
  DummyBudget(
    gambar: "assets/other.png",
    judul: "Beli CD K-Pop",
    deskripsi: "Limit budget Desember",
    harga: "Rp.200.000"
  ),

];
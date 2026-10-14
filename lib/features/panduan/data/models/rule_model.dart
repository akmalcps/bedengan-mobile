class RuleModel {
  final int number;
  final String title;
  final String description;

  const RuleModel({
    required this.number,
    required this.title,
    required this.description,
  });
}

const List<RuleModel> dummyRules = [
  RuleModel(
    number: 1,
    title: 'Menjaga Kebersihan & Kelola Sampah',
    description:
        'Wajib membawa kantong sampah sendiri (trash bag) dan membawa kembali seluruh sampah masing-masing ke TPS di area gerbang utama (prinsip Leave No Trace).',
  ),
  RuleModel(
    number: 2,
    title: 'Jam Tenang & Bebas Kebisingan',
    description:
        'Berlaku jam tenang mulai pukul 22.00 – 06.00 WIB. Dilarang menyalakan speaker portable dengan volume keras atau membuat kebisingan yang mengganggu camper lain.',
  ),
  RuleModel(
    number: 3,
    title: 'Larangan Perapian Sembarangan',
    description:
        'Menyalakan api unggun hanya di wadah atau titik fire pit yang ditentukan. Dilarang keras membuat perapian tepat di atas akar pohon Pinus dan pastikan api padam total sebelum beristirahat.',
  ),
  RuleModel(
    number: 4,
    title: 'Keselamatan Aliran Sungai',
    description:
        'Dilarang bermain atau beraktivitas di aliran sungai tanpa pengawasan. Waspada banjir bandang saat musim hujan dan segera jauhi bantaran sungai jika cuaca buruk (mendadak).',
  ),
  RuleModel(
    number: 5,
    title: 'Pelestarian Alam & Pohon Pinus',
    description:
        'Dilarang menebang pohon, menguliti kulit kayu, menebang dahan hijau, atau memetik tanaman liar di seluruh kawasan lindung Bedengan.',
  ),
  RuleModel(
    number: 6,
    title: 'Larangan Minuman Keras & Narkoba',
    description:
        'Kawasan Bedengan adalah destinasi ramah keluarga. Dilarang keras membawa, memperjualbelikan, atau mengonsumsi minuman keras, narkotika, serta membawa senjata tajam.',
  ),
  RuleModel(
    number: 7,
    title: 'Pengawasan Anak-Anak & Lansia',
    description:
        'Orang tua/pendamping wajib mendampingi putra-putrinya setiap saat, terutama di sekitar lereng, bebatuan licin, serta pinggir aliran sungai berbatu.',
  ),
  RuleModel(
    number: 8,
    title: 'Parkir Kendaraan & Akses Darurat',
    description:
        'Parkirkan motor dan mobil hanya pada kantong parkir resmi. Dilarang memarkirkan kendaraan pada badan jalan setapak yang menjadi koridor evakuasi darurat.',
  ),
];

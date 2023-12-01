part of 'pages.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Province> provinceData = [];

  ///
  bool isLoading = false;

  Future<dynamic> getProvinces() async {
    ////
    await MasterDataService.getProvince().then((value) {
      setState(() {
        provinceData = value;

        ///
        isLoading = false;
      });
    });
  }

  Future<List<City>>? citydataorigin1;
  dynamic cityDataOrigin;
  dynamic cityIdOrigin;
  dynamic selectedCityOrigin;

  // Future<List<City>> getCities(var provId) async {
  //   ////
  //   dynamic city;
  //   await MasterDataService.getCitybyprovince(provId).then((value) {
  //     setState(() {
  //       city = value;
  //       cityDataOrigin = value;
  //     });
  //   });

  //   return cityDataOrigin;
  // }

  @override
  void initState() {
    super.initState();
    setState(() {
      isLoading = true;
    });
    getProvinces();

    ///
    citydataorigin1 = MasterDataService.getCitybyprovince('5');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Home Page"),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Flexible(
                flex: 1,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: Column(
                    children: [
                      Text("Origin"),
                      //Dropdown cities
                      Container(
                        width: 240,
                        child: FutureBuilder<List<City>>(
                            future: citydataorigin1,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return DropdownButton(
                                    isExpanded: true,
                                    value: selectedCityOrigin,
                                    icon: Icon(Icons.arrow_drop_down),
                                    iconSize: 30,
                                    elevation: 4,
                                    style: TextStyle(color: Colors.black),
                                    hint: selectedCityOrigin == null
                                        ? Text('Pilih kota')
                                        : Text(selectedCityOrigin.cityName),
                                    items: snapshot.data!
                                        .map<DropdownMenuItem<City>>(
                                            (City value) {
                                      return DropdownMenuItem(
                                          value: value,
                                          child:
                                              Text(value.cityName.toString()));
                                    }).toList(),
                                    onChanged: (newValue) {
                                      setState(() {
                                        selectedCityOrigin = newValue;
                                        cityIdOrigin =
                                            selectedCityOrigin.cityId;
                                      });
                                    });
                              } else if (snapshot.hasError) {
                                return Text("Tidak ada data");
                              }
                              return UILoading.smallloadingBlock();
                            }),
                      )
                    ],
                  ),
                ),
              ),
              Flexible(
                flex: 5,
                child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    child: provinceData.isEmpty
                        ? const Align(
                            alignment: Alignment.center,
                            child: Text("Data tidak ditemukan"),
                          )
                        : ListView.builder(
                            itemCount: provinceData.length,
                            itemBuilder: (context, index) {
                              return Card_Province(provinceData[index]);
                            })),
              ),
            ],
          ),
          isLoading == true ? UILoading.bigloadingBlock() : Container()
        ],
      ),
    );
  }
}

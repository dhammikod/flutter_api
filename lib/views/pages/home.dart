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

  //data from api for dropdown
  Future<List<Province>>? provincedataorigin1;
  Future<List<City>>? citydataorigin1;
  Future<List<City>>? citydataDestination;

  //form data
  //access grams by gramsValue, selected kurir value by selectedValue
  // dynamic cityIdOrigin;
  dynamic selectedCityOrigin;
  dynamic selectedProvinceOrigin;

  dynamic selectedProvinceDestination;
  dynamic selectedCityDestination;

  String selectedValue = 'jne';
  TextEditingController _controller = TextEditingController();
  String? gramsValue;

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
    // citydataorigin1 = MasterDataService.getCitybyprovince('5');
    provincedataorigin1 = MasterDataService.getProvince();
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
              //form part
              Flexible(
                flex: 5,
                child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    child: Column(
                      children: [
                        //first part of the form
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                  flex: 1,
                                  child: Container(
                                    child: DropdownButton<String>(
                                      value: selectedValue,
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          selectedValue = newValue!;
                                        });
                                      },
                                      items: <String>['jne', 'pos', 'tiki']
                                          .map<DropdownMenuItem<String>>(
                                              (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                    ),
                                  )),
                              Flexible(
                                  flex: 1,
                                  child: Container(
                                    child: TextField(
                                      controller: _controller,
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                        labelText: 'Berat (gr)',
                                        suffixText: 'gr',
                                        border: OutlineInputBorder(),
                                      ),
                                      onChanged: (value) {
                                        setState(() {
                                          gramsValue = value;
                                        });
                                      },
                                    ),
                                  )),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),

                        //second part of the form
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Column(
                            children: [
                              Container(
                                width: double.infinity,
                                child: const Text(
                                  'Origin',
                                  style: TextStyle(
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Row(
                                //dropdown province 1
                                children: [
                                  Flexible(
                                    flex: 1,
                                    child: Container(
                                      child: FutureBuilder<List<Province>>(
                                          future: provincedataorigin1,
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              return DropdownButton(
                                                  isExpanded: true,
                                                  value: selectedProvinceOrigin,
                                                  icon: Icon(
                                                      Icons.arrow_drop_down),
                                                  iconSize: 30,
                                                  elevation: 4,
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                  hint: selectedProvinceOrigin ==
                                                          null
                                                      ? Text('Pilih kota')
                                                      : Text(
                                                          selectedProvinceOrigin
                                                              .province),
                                                  items: snapshot.data!.map<
                                                          DropdownMenuItem<
                                                              Province>>(
                                                      (Province value) {
                                                    return DropdownMenuItem(
                                                        value: value,
                                                        child: Text(value
                                                            .province
                                                            .toString()));
                                                  }).toList(),
                                                  onChanged: (newValue) {
                                                    setState(() {
                                                      selectedProvinceOrigin =
                                                          newValue;
                                                      //call a function
                                                      citydataorigin1 =
                                                          MasterDataService
                                                              .getCitybyprovince(
                                                                  selectedProvinceOrigin
                                                                      .provinceId);

                                                      // cityIdOrigin =
                                                      //     selectedProvinceOrigin
                                                      //         .cityId;
                                                    });
                                                  });
                                            } else if (snapshot.hasError) {
                                              return Text("Tidak ada data");
                                            }
                                            return UILoading
                                                .smallloadingBlock();
                                          }),
                                    ),
                                  ),
                                  //Dropdown cities 1
                                  Flexible(
                                    flex: 1,
                                    child: Container(
                                      child: FutureBuilder<List<City>>(
                                          future: citydataorigin1,
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              return DropdownButton(
                                                  isExpanded: true,
                                                  value: selectedCityOrigin,
                                                  icon: Icon(
                                                      Icons.arrow_drop_down),
                                                  iconSize: 30,
                                                  elevation: 4,
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                  hint: selectedCityOrigin ==
                                                          null
                                                      ? Text('Pilih kota')
                                                      : Text(selectedCityOrigin
                                                          .cityName),
                                                  items: snapshot.data!.map<
                                                      DropdownMenuItem<
                                                          City>>((City value) {
                                                    return DropdownMenuItem(
                                                        value: value,
                                                        child: Text(value
                                                            .cityName
                                                            .toString()));
                                                  }).toList(),
                                                  onChanged: (newValue) {
                                                    setState(() {
                                                      selectedCityOrigin =
                                                          newValue;

                                                      // cityIdOrigin =
                                                      //     selectedCityOrigin
                                                      //         .cityId;
                                                    });
                                                  });
                                            } else if (snapshot.hasError) {
                                              return Text("Tidak ada data");
                                            }
                                            return UILoading
                                                .smallloadingBlock();
                                          }),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),

                        //third part of the form
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Column(
                            children: [
                              Container(
                                width: double.infinity,
                                child: const Text(
                                  'Destination',
                                  style: TextStyle(
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Row(
                                //dropdown province 2
                                children: [
                                  Flexible(
                                    flex: 1,
                                    child: Container(
                                      child: FutureBuilder<List<Province>>(
                                          future: provincedataorigin1,
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              return DropdownButton(
                                                  isExpanded: true,
                                                  value:
                                                      selectedProvinceDestination,
                                                  icon: Icon(
                                                      Icons.arrow_drop_down),
                                                  iconSize: 30,
                                                  elevation: 4,
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                  hint: selectedProvinceDestination ==
                                                          null
                                                      ? Text('Pilih kota')
                                                      : Text(
                                                          selectedProvinceDestination
                                                              .province),
                                                  items: snapshot.data!.map<
                                                          DropdownMenuItem<
                                                              Province>>(
                                                      (Province value) {
                                                    return DropdownMenuItem(
                                                        value: value,
                                                        child: Text(value
                                                            .province
                                                            .toString()));
                                                  }).toList(),
                                                  onChanged: (newValue) {
                                                    setState(() {
                                                      selectedProvinceDestination =
                                                          newValue;
                                                      //call a function
                                                      citydataDestination =
                                                          MasterDataService
                                                              .getCitybyprovince(
                                                                  selectedProvinceDestination
                                                                      .provinceId);

                                                      // cityIdOrigin =
                                                      //     selectedProvinceOrigin
                                                      //         .cityId;
                                                    });
                                                  });
                                            } else if (snapshot.hasError) {
                                              return Text("Tidak ada data");
                                            }
                                            return UILoading
                                                .smallloadingBlock();
                                          }),
                                    ),
                                  ),
                                  //Dropdown cities 2
                                  Flexible(
                                    flex: 1,
                                    child: Container(
                                      child: FutureBuilder<List<City>>(
                                          future: citydataDestination,
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              return DropdownButton(
                                                  isExpanded: true,
                                                  value:
                                                      selectedCityDestination,
                                                  icon: Icon(
                                                      Icons.arrow_drop_down),
                                                  iconSize: 30,
                                                  elevation: 4,
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                  hint: selectedCityDestination ==
                                                          null
                                                      ? Text('Pilih kota')
                                                      : Text(
                                                          selectedCityDestination
                                                              .cityName),
                                                  items: snapshot.data!.map<
                                                      DropdownMenuItem<
                                                          City>>((City value) {
                                                    return DropdownMenuItem(
                                                        value: value,
                                                        child: Text(value
                                                            .cityName
                                                            .toString()));
                                                  }).toList(),
                                                  onChanged: (newValue) {
                                                    setState(() {
                                                      selectedCityDestination =
                                                          newValue;
                                                    });
                                                  });
                                            } else if (snapshot.hasError) {
                                              return Text("Tidak ada data");
                                            }
                                            return UILoading
                                                .smallloadingBlock();
                                          }),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),

                        SizedBox(
                          height: 20,
                        ),

                        ElevatedButton(
                          onPressed: () {
                            // Handle button press
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.blue,
                            padding: EdgeInsets.all(16.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  8.0), // Adjust the radius as needed
                            ),
                          ),
                          child: Text('Click me'),
                        )
                      ],
                    )),
              ),
              //result part
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

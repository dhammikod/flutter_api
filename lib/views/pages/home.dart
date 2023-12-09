part of 'pages.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Province> provinceData = [];
  bool isLoading = false;

  Future<List<Province>>? provincedataorigin1;
  Future<List<City>>? citydataorigin1;
  Future<List<City>>? citydataDestination;
  Future<List<CostResult>>? api_costs;

  bool is_origin_loading = false;
  bool isApiCallInProgress = false;

  dynamic selectedCityOrigin;
  dynamic selectedProvinceOrigin;
  dynamic selectedProvinceDestination;
  dynamic selectedCityDestination;
  String selectedValue = 'jne';
  TextEditingController _controller = TextEditingController();
  String? gramsValue;

  @override
  void initState() {
    super.initState();
    setState(() {
      isLoading = true;
    });
    getProvinces();
  }

  Future<void> getProvinces() async {
    provincedataorigin1 = MasterDataService.getProvince();
    setState(() {
      isLoading = false;
    });
  }

  Future<void> updateCityDataOrigin() async {
    if (selectedProvinceOrigin != null) {
      citydataorigin1 = MasterDataService.getCitybyprovince(
          selectedProvinceOrigin.provinceId);
      setState(() {});
    }
  }

  Future<void> updateCityDataDestination() async {
    if (selectedProvinceDestination != null) {
      citydataDestination = MasterDataService.getCitybyprovince(
          selectedProvinceDestination.provinceId);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Home Page"),
        centerTitle: true,
        backgroundColor: Colors.blue, // Set the background color to blue
      ),
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(
                height: 20,
              ),
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
                                                      selectedCityOrigin = null;
                                                      //call a function
                                                      updateCityDataOrigin();

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
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return UILoading
                                                  .smallloadingBlock(); // Show loading block while waiting for data
                                            } else if (snapshot.hasData) {
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
                                                      updateCityDataDestination();
                                                      selectedCityDestination =
                                                          null;
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
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return UILoading
                                                  .smallloadingBlock(); // Show loading block while waiting for data
                                            } else if (snapshot.hasData) {
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
                            // Handle button press only if all form fields are filled
                            if (selectedCityOrigin != null &&
                                selectedCityDestination != null &&
                                selectedValue.isNotEmpty &&
                                gramsValue != null) {
                              setState(() {
                                isApiCallInProgress = true;
                                print(isApiCallInProgress);
                              });

                              MasterDataService.getCosts(
                                selectedCityOrigin.cityId,
                                selectedCityDestination.cityId,
                                gramsValue,
                                selectedValue,
                              ).then((List<CostResult>? data) {
                                // Process the data when the Future completes
                                setState(() {
                                  isApiCallInProgress = false;
                                  print(isApiCallInProgress);
                                  print('data = {$data}');
                                  api_costs = Future.value(data);
                                  print('api = $api_costs');
                                });
                              }).catchError((error) {
                                // Handle errors if any
                                setState(() {
                                  isApiCallInProgress = false;
                                });
                              });
                            } else {
                              // Show an alert or toast indicating that all form fields are required
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      "Please fill in all the required fields"),
                                ),
                              );
                            }
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
                          // ... rest of the button properties
                          child: Text('Click me'),
                        ),
                      ],
                    )),
              ),
              //result part
              Flexible(
                  flex: 5,
                  child: FutureBuilder<List<CostResult>>(
                    future: api_costs,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator(); // Loading indicator while waiting for data
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Text('No data available');
                      } else {
                        // Display a ListView of cards
                        return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              CostResult costResult = snapshot.data![index];
                              return Card_Province(costResult);
                            });
                      }
                    },
                  )),
            ],
          ),
          Visibility(
              visible: isApiCallInProgress, // Set your condition here
              child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: double.infinity,
                color: Colors.black.withOpacity(0.5),
                child: SpinKitFadingCircle(
                  size: 100,
                  color: Colors.blue,
                ),
              ))
        ],
      ),
    );
  }
}

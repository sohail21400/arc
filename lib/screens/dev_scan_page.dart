import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_beacon/flutter_beacon.dart';

class DevScanPage extends StatefulWidget {
  @override
  _DevScanPageState createState() => _DevScanPageState();
}

// it is used with widget binder to know weather the app in minimized or closed
class _DevScanPageState extends State<DevScanPage> with WidgetsBindingObserver {
  // this list have the major and minor of the current beacon available
  static List<List<int>> currentBeaconList;

  // stream controller for bluetooth
  final StreamController<BluetoothState> streamController = StreamController();
  // stream subscription for bluetooth
  StreamSubscription<BluetoothState> _streamBluetooth;
  // stream subscription for ranging
  StreamSubscription<RangingResult> _streamRanging;

  // the region of beacon is saved in this list of type Region
  // this is for ranging monitoring and managing beacon scanning
  final regionBeacons = <Region, List<Beacon>>{};
  //..................................................................................................................................

  // i think the scanned beacon is saved here
  final _beacons = <Beacon>[];

  // chechking the authorization of sdk
  bool authorizationStatusOk = false;
  // checking the location service is enabled or not
  bool locationServiceEnabled = false;
  // checking bluetooth is enabled or not
  bool bluetoothEnabled = false;

  @override
  void initState() {
    // widget binding is set to track the app state from the begining itself
    WidgetsBinding.instance.addObserver(this);

    super.initState();
    // .......................
    listeningState();
  }

  // this function is to start scanning beacons when the bluetooth is already
  // on. if it is off it will pause scanning beacon and check for requirenments
  listeningState() async {
    print('Listening to bluetooth state');
    _streamBluetooth = flutterBeacon
        .bluetoothStateChanged()
        .listen((BluetoothState state) async {
      print('BluetoothState = $state');
      streamController.add(state);

      switch (state) {
        case BluetoothState.stateOn:
          initScanBeacon();
          break;
        case BluetoothState.stateOff:
          await pauseScanBeacon();
          await checkAllRequirements();
          break;
      }
    });
  }

  // checks all the requirenments needed for the app like bt, location etc.
  // and if that changed it will update the state variable of the class
  checkAllRequirements() async {
    final bluetoothState = await flutterBeacon.bluetoothState;
    final bluetoothEnabled = bluetoothState == BluetoothState.stateOn;
    final authorizationStatus = await flutterBeacon.authorizationStatus;
    final authorizationStatusOk =
        authorizationStatus == AuthorizationStatus.allowed ||
            authorizationStatus == AuthorizationStatus.always;
    final locationServiceEnabled =
        await flutterBeacon.checkLocationServicesIfEnabled;

    setState(() {
      this.authorizationStatusOk = authorizationStatusOk;
      this.locationServiceEnabled = locationServiceEnabled;
      this.bluetoothEnabled = bluetoothEnabled;
    });
  }

  // this is a async function
  // it added a region called Cubeacon with proximity uuid
  initScanBeacon() async {
    await flutterBeacon.initializeScanning;
    await checkAllRequirements();

    // prints a message if it's ready to scan
    if (!authorizationStatusOk ||
        !locationServiceEnabled ||
        !bluetoothEnabled) {
      print('RETURNED, authorizationStatusOk=$authorizationStatusOk, '
          'locationServiceEnabled=$locationServiceEnabled, '
          'bluetoothEnabled=$bluetoothEnabled');
      return;
    }
    // it is setting a region
    final regions = <Region>[
      Region(
        identifier: 'Cubeacon',
        proximityUUID: 'CB10023F-A318-3394-4199-A8730C7C1AEC',
      ),
    ];

    // ranging is not started yet!

    // if it fails to setup a subscription for ranging
    // it should not start ranging so the if condition
    // if stream subscription is setup and currently in pause state
    // idk i guess it will be null state (it will be if this is running for the first time)
    // it will resume the ranging
    if (_streamRanging != null) {
      if (_streamRanging.isPaused) {
        _streamRanging.resume();
        return;
      }
    }

    void funToAddCurrentBeaconToList(RangingResult result) {
      List<Beacon> beaconList = result.beacons;
      beaconList.map((item) {
        currentBeaconList.add([item.major, item.minor]);
      });
    }
    //.........................................................................................................................

    // setting up the stream for the ranging result
    // on each event of the stream the funcion in the .listen will be called
    _streamRanging =
        flutterBeacon.ranging(regions).listen((RangingResult result) {
      funToAddCurrentBeaconToList(result);
      // print(result);
      print("beacon list");
      print(currentBeaconList);

      // ignore mounted
      // if we got something from the ranging subscription setState is called
      if (result != null && mounted) {
        setState(() {
          // the founded beacon's region will be added to this _regionBeacons list
          regionBeacons[result.region] = result.beacons;
          // i think this clear is useless
          _beacons.clear();
          // the value of each beacons is saved it the _beacons list
          regionBeacons.values.forEach((list) {
            _beacons.addAll(list);
          });
          // the scanned beacons is sorted in some sort
          _beacons.sort(_compareParameters);
        });
      }
    });
  }

  // this function is for pausing the beacon scanning process
  pauseScanBeacon() async {
    // i don't understand the .? thing. i think that ? is not a mistake
    // pausing the beacon scanning
    _streamRanging?.pause();
    // it is clearing the old beacons collected when paused
    // so pauses is like stoping
    if (_beacons.isNotEmpty) {
      setState(() {
        _beacons.clear();
      });
    }
  }

  // this is a useless sort function
  int _compareParameters(Beacon a, Beacon b) {
    int compare = a.proximityUUID.compareTo(b.proximityUUID);

    if (compare == 0) {
      compare = a.major.compareTo(b.major);
    }

    if (compare == 0) {
      compare = a.minor.compareTo(b.minor);
    }

    return compare;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    print('AppLifecycleState = $state');

    // if app is opened and the stream subscription for bt is resumed
    // ie activates the bluetooth state
    // idk why it is initializing the beacon scanning
    if (state == AppLifecycleState.resumed) {
      if (_streamBluetooth != null && _streamBluetooth.isPaused) {
        _streamBluetooth.resume();
      }
      await checkAllRequirements();
      if (authorizationStatusOk && locationServiceEnabled && bluetoothEnabled) {
        await initScanBeacon();
      } else {
        await pauseScanBeacon();
        await checkAllRequirements();
        // ........................................................................................
        // thing i need to check is that what if the requirenments are not satisfied
      }
    } else if (state == AppLifecycleState.paused) {
      // here also the ?. is used
      _streamBluetooth?.pause();
    }
  }

  @override
  // this will dispose bt stream controller and all of the subscription ie bt and ranging
  // when this widget is removed form the tree
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    streamController?.close();
    _streamRanging?.cancel();
    _streamBluetooth?.cancel();
    flutterBeacon.close;

    super.dispose();
  }

  // BUILDING THE BODY
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.white,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: Scaffold(
        appBar: AppBar(
          // all these thing doing below is to design the app bar by checking the state of the bt
          // using stream builder
          //.................................................................................................
          title: const Text('Flutter Beacon'),
          centerTitle: false,
          actions: <Widget>[
            // if sdk authorisartion is not done it will give this icon
            // when tapped it will ask for the location access (ACCESS_COARSE_LOCATION)
            if (!authorizationStatusOk)
              IconButton(
                  icon: Icon(Icons.portable_wifi_off),
                  color: Colors.red,
                  onPressed: () async {
                    await flutterBeacon.requestAuthorization;
                  }),
            // if location service is not enabled it will show the icon
            // if tapped it should redirect to the settings page
            if (!locationServiceEnabled)
              IconButton(
                  icon: Icon(Icons.location_off),
                  color: Colors.red,
                  onPressed: () async {
                    if (Platform.isAndroid) {
                      await flutterBeacon.openLocationSettings;
                    } else if (Platform.isIOS) {}
                  }),

            // this is a stream builder which builds some widget from a stream of data
            StreamBuilder<BluetoothState>(
              // builder takes context and snapshot
              builder: (context, snapshot) {
                // checking if the snapshot has data
                // it is giving that data to a variable called state
                if (snapshot.hasData) {
                  final state = snapshot.data;

                  // if bluetooth is on it will give a bluetooth connected icon
                  // on tap does nothing
                  if (state == BluetoothState.stateOn) {
                    return IconButton(
                      icon: Icon(Icons.bluetooth_connected),
                      onPressed: () {},
                      color: Colors.lightBlueAccent,
                    );
                  }
                  // if bluetooth is off it will show normal bt button in red color
                  // on tap will open bt settings
                  if (state == BluetoothState.stateOff) {
                    return IconButton(
                      icon: Icon(Icons.bluetooth),
                      onPressed: () async {
                        if (Platform.isAndroid) {
                          try {
                            await flutterBeacon.openBluetoothSettings;
                          } on PlatformException catch (e) {
                            print(e);
                          }
                        } else if (Platform.isIOS) {}
                      },
                      color: Colors.red,
                    );
                  }
                  //...............................................................
                  // need to check what is if ... return statement

                  // i think this is shown when the device doesn't have bt
                  // on tap does nothing
                  return IconButton(
                    icon: Icon(Icons.bluetooth_disabled),
                    onPressed: () {},
                    color: Colors.grey,
                  );
                }

                return SizedBox.shrink();
              },
              // the stream of data is given from the bt stream controller
              stream: streamController.stream,
              initialData: BluetoothState.stateUnknown,
            ),
          ],
        ),
        //..........................................................................................
        // till here we just build the interactive app bar
        // NEED TO CHECK WHEN THE BEACON SCAN STARTS................................................

        body: _beacons == null || _beacons.isEmpty
            // if the list of beacon is empty it will show a circualr progress
            ? Center(child: CircularProgressIndicator())
            // or if the list of beacon is not empty
            // it will build a list view
            : ListView(
                children: ListTile.divideTiles(
                    context: context,
                    tiles: _beacons.map((beacon) {
                      return ListTile(
                        title: Text(beacon.proximityUUID),
                        subtitle: new Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Flexible(
                                child: Text(
                                    'Major: ${beacon.major}\nMinor: ${beacon.minor}',
                                    style: TextStyle(fontSize: 13.0)),
                                flex: 1,
                                fit: FlexFit.tight),
                            Flexible(
                                child: Text(
                                    'Accuracy: ${beacon.accuracy}m\nRSSI: ${beacon.rssi}',
                                    style: TextStyle(fontSize: 13.0)),
                                flex: 2,
                                fit: FlexFit.tight)
                          ],
                        ),
                      );
                    })).toList(),
              ),
      ),
    );
  }
}

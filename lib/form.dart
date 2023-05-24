import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:provider/provider.dart';
import 'global_state.dart';
import 'sample.dart';
import 'main.dart';

class FormPage extends StatelessWidget {
  final DatabaseReference _database = FirebaseDatabase.instance.reference();

  Future<void> saveGlobalStateToDatabase(GlobalState globalState) async {
    await _database
        .child("panelist_data/${globalState.panelistId}")
        .push()
        .set({
      "selectedSample": globalState.selectedSample,
      "selectedGender": globalState.selectedGender,
      "age": globalState.age,
      "ethnicity": globalState.ethnicity,
      "race": globalState.race,
      "blueberryConsumption": globalState.blueberryConsumption,
      "appearance": globalState.appearance,
      "overall": globalState.overall,
      "posFeedback": globalState.posFeedback,
      "negFeedback": globalState.negFeedback,
      "texture": globalState.texture,
      "flavor": globalState.flavor,
      "sweetness": globalState.sweetness,
      "sourness": globalState.sourness,
      "firmness": globalState.firmness,
      "juiciness": globalState.juiciness,
      "overallFlavor": globalState.overallFlavor,
      "currSample": globalState.currSample,
      "textureClass": globalState.textureClass,
    });
  }

  void resetGlobalState(GlobalState globalState) {
    globalState.selectedSample = null;
    globalState.appearance = null;
    globalState.overall = null;
    globalState.posFeedback = null;
    globalState.negFeedback = null;
    globalState.texture = null;
    globalState.flavor = null;
    globalState.sweetness = null;
    globalState.sourness = null;
    globalState.firmness = null;
    globalState.juiciness = null;
    globalState.overallFlavor = null;
    globalState.textureClass = null;
  }

  @override
  Widget build(BuildContext context) {
    final globalState = Provider.of<GlobalState>(context, listen: false);

    void resetAllGlobalState() {
      globalState.panelistId = null;
      globalState.selectedGender = null;
      globalState.age = null;
      globalState.ethnicity = null;
      globalState.race = null;
      globalState.blueberryConsumption = null;
      globalState.currSample = 1;
      resetGlobalState(globalState);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Form'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (globalState.currSample != null && globalState.currSample! < 6)
              Text(
                "Ready for sample ${globalState.currSample} out of 5?",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            if (globalState.currSample != null && globalState.currSample! < 6)
              SizedBox(height: 30),
            if (globalState.currSample != null && globalState.currSample! < 6)
              ElevatedButton(
                onPressed: () async {
                  await saveGlobalStateToDatabase(globalState);
                  resetGlobalState(globalState);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SamplePage()),
                  );
                },
                child: Text('Continue', style: TextStyle(fontSize: 20)),
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
              ),
            if (globalState.currSample != null && globalState.currSample! == 6)
              Text(
                "Thank you for participating in this survey panelist ${globalState
                    .panelistId}!",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            if (globalState.currSample != null && globalState.currSample! == 6)
              SizedBox(height: 30),
            if (globalState.currSample != null && globalState.currSample! == 6)
              ElevatedButton(
                onPressed: () async {
                  await saveGlobalStateToDatabase(globalState);
                  resetAllGlobalState();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyHomePage()),
                  );
                },
                child: Text(
                    'Submit and Sign Out', style: TextStyle(fontSize: 20)),
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
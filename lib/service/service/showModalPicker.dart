import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

showModalTimePicker(BuildContext context, List minutes, List seconds, List half,
    Function selectMinutes, Function selectSeconds, Function selectHalf) {
  showModalBottomSheet<void>(
    context: context,
    builder: (BuildContext context) {
      return Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height / 3,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: 120,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: CupertinoPicker(
                  backgroundColor: Colors.white,
                  itemExtent: 40,
                  children: half.map((e) => Text(e)).toList(),
                  onSelectedItemChanged: selectHalf,
                ),
              ),
            ),
            SizedBox(
              width: 120,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: CupertinoPicker(
                  backgroundColor: Colors.white,
                  itemExtent: 40,
                  children: minutes.map((e) => Text(e)).toList(),
                  onSelectedItemChanged: selectMinutes,
                ),
              ),
            ),
            Text(
              ':',
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
            SizedBox(
              width: 120,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: CupertinoPicker(
                  backgroundColor: Colors.white,
                  itemExtent: 40,
                  children: seconds.map((e) => Text(e)).toList(),
                  onSelectedItemChanged: selectSeconds,
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}

showModalSelectPicker(
    BuildContext context, List patternList, Function selectPattern) {
  showModalBottomSheet<void>(
    context: context,
    builder: (BuildContext context) {
      return Container(
        height: MediaQuery.of(context).size.height / 3,
        child: SizedBox(
          width: 200,
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: CupertinoPicker(
              backgroundColor: Colors.white,
              itemExtent: 40,
              children: patternList.map((e) => Text(e)).toList(),
              onSelectedItemChanged: selectPattern,
            ),
          ),
        ),
      );
    },
  );
}

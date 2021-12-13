import 'package:flutter/material.dart';

class NominalItemTile extends StatefulWidget {

  final String nominal;
  final int selectedIndex;
  final int currentIndex;
  final Function() itemClicked;

  const NominalItemTile(
    this.nominal,
    this.selectedIndex,
    this.currentIndex,
    this.itemClicked
  );

  @override
  _NominalItemTileState createState() => _NominalItemTileState();
}

class _NominalItemTileState extends State<NominalItemTile> {

  bool isClicked = false;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: widget.itemClicked,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        height: 50,
        decoration: BoxDecoration(
            border: Border.all(color: widget.selectedIndex == widget.currentIndex ? Colors.red : Colors.black, width: 1),
            borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: Text(
            widget.nominal,
            style: TextStyle(color: widget.selectedIndex == widget.currentIndex ? Colors.red : Colors.black,),
          ),
        ),
      ),
    );
  }
}

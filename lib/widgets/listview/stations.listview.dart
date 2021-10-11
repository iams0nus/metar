import 'package:flutter/material.dart';
import 'package:metar/colors/material.colors.dart';
import 'package:metar/models/metar.dart';

class StationsListView extends StatelessWidget {
  const StationsListView({
    Key? key,
    required this.entries,
    required this.fetchMetar,
  }) : super(key: key);

  final List<Metar> entries;
  final Function fetchMetar;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => fetchMetar(),
      child: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: entries.length,
        physics: const AlwaysScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            child: new Column(
              children: <Widget>[
                Card(
                  child: StationTile(entry: entries[index]),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class StationTile extends StatelessWidget {
  const StationTile({
    Key? key,
    required this.entry,
  }) : super(key: key);

  final Metar entry;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: Text('${(entry.station)}',
            style: TextStyle(
                fontSize: 20,
                color: black.shade500,
                fontWeight: FontWeight.bold)),
        title: Text('${(entry.reading)}',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
        trailing: Icon(Icons.keyboard_arrow_right));
  }
}

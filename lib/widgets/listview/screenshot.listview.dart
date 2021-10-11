import 'package:flutter/material.dart';
import 'package:metar/models/metar.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class ScreenshotListView extends StatelessWidget {
  const ScreenshotListView({
    Key? key,
    required bool isInAsyncCall,
    required this.entries,
    required this.fetchMetar,
  })  : _isInAsyncCall = isInAsyncCall,
        super(key: key);

  final bool _isInAsyncCall;
  final List<Metar> entries;
  final Function fetchMetar;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _isInAsyncCall,
      opacity: 0.5,
      progressIndicator: CircularProgressIndicator(),
      child: RefreshIndicator(
        onRefresh: () => fetchMetar(),
        child: ListView.separated(
          physics: const AlwaysScrollableScrollPhysics(),
          separatorBuilder: (BuildContext context, int index) => const Divider(
            height: 2,
          ),
          padding: const EdgeInsets.all(8),
          itemCount: entries.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              child: Padding(
                padding: EdgeInsets.all(2),
                child: Text('${(entries[index].reading)}',
                    style:
                        TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
              ),
            );
          },
        ),
      ),
    );
  }
}

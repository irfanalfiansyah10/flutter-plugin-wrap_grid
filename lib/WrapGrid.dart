library mcnmr_wrap_height_gridview;

import 'package:flutter/widgets.dart';

class WrapGrid extends StatelessWidget {
  final EdgeInsets contentMargin;
  final EdgeInsets contentPadding;
  final int rowAxisCount;
  final int itemCount;
  final IndexedWidgetBuilder builder;
  final ContentHeight contentHeight;
  final bool isScrollable;

  WrapGrid({@required this.rowAxisCount, @required this.itemCount,
    @required this.builder, this.isScrollable = false,
    this.contentHeight = ContentHeight.dynamic,
    this.contentMargin = const EdgeInsets.all(0),
    this.contentPadding = const EdgeInsets.all(0)});

  @override
  Widget build(BuildContext context) {

    var maxColumn = (itemCount / rowAxisCount).ceil();
    var currentPosition = 0;

    var rows = <Row>[];
    for(int i=0;i<maxColumn;i++){
      var child = <Widget>[];

      for(int x=0;x<rowAxisCount;x++){
        if(currentPosition < itemCount){
          child.add(
              Expanded(
                child: Container(
                  height: contentHeight.height,
                  margin: contentMargin,
                  padding: contentPadding,
                  child: builder(context, currentPosition),
                ),
              )
          );

          currentPosition += 1;
        }else {
          child.add(Expanded(child: Container()));
        }
      }

      rows.add(Row(
        children: child,
      ));
    }

    var column = Column(
      mainAxisSize: MainAxisSize.min,
      children: rows,
    );

    if(isScrollable){
      return SingleChildScrollView(
        child: column,
      );
    }

    return column;
  }
}

class ContentHeight{
  static const dynamic = ContentHeight(height: null);

  final double height;

  const ContentHeight({this.height});
}

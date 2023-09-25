import 'dart:math';
import 'package:flutter/material.dart';
import 'package:responsive_table/responsive_table.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (_) => DataPage(),
      },
    );
  }
}

class DataPage extends StatefulWidget {
  DataPage({Key? key}) : super(key: key);
  @override
  _DataPageState createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {
  bool edit = false;
  List<dynamic> _colInfos = [
    'Item',
    'Description',
    'Unit',
    'Price',
    'Quantity',
    'Bonus',
    'Discount',
    'Serial',
    'Batch',
    'Campaign',
    'Total',
    'Points',
    'Comment',
    'Source',
  ];
  // double get _sumOfRightColumnWidth {
  //   return _colInfos
  //       .sublist(1)
  //       .map((e) => e.width)
  //       .fold(0, (previousValue, element) => previousValue + element);
  // }

  @override
  void initState() {
    super.initState();
    // widget.user.initData(100);
    // _colInfos = [
    //   const UserColumnInfo('Name', 100),
    //   const UserColumnInfo('Status', 100),
    //   const UserColumnInfo('Phone', 200),
    //   const UserColumnInfo('Register', 100),
    //   const UserColumnInfo('Termination', 200),
    // ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reorderable Header/Footer Table')),
      body: HorizontalDataTable(
        leftHandSideColumnWidth: 100,
        rightHandSideColumnWidth: 1300,
        isFixedHeader: true,
        headerWidgets: _getTitleWidget(),
        leftSideItemBuilder: _generateFirstColumnRow,
        rightSideItemBuilder: _generateRightHandSideColumnRow,
        itemCount: 200,
        rowSeparatorWidget: const Divider(
          color: Colors.black38,
          height: 1.0,
          thickness: 0.0,
        ),
        leftHandSideColBackgroundColor: const Color(0xFFFFFFFF),
        rightHandSideColBackgroundColor: const Color(0xFFFFFFFF),
      ),
    );
  }

  List<Widget> _getTitleWidget() {
    return _colInfos
        .map((e) => DragTarget(
              builder: (context, candidateData, rejectedData) {
                return Draggable<String>(
                  data: e,
                  feedback: Material(child: _getTitleItemWidget(e, 100)),
                  child: _getTitleItemWidget(e, 100),
                );
              },
              onWillAccept: (value) {
                return value != e;
              },
              onAccept: (value) {
                int oldIndex =
                    _colInfos.indexWhere((element) => element == value);
                int newIndex = _colInfos.indexWhere((element) => element == e);
                dynamic temp = _colInfos.removeAt(oldIndex);
                _colInfos.insert(newIndex, temp);
                setState(() {});
              },
            ))
        .toList();
  }

  Widget _getTitleItemWidget(String label, double width) {
    return Container(
      width: width,
      height: 56,
      padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
      alignment: Alignment.centerLeft,
      child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }

  Widget _generateGeneralColumnCell(
      BuildContext context, int rowIndex, int colIndex) {
    return Container(
      width: 100,
      height: 52,
      padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
      alignment: Alignment.centerLeft,
      child: edit
          ? const TextField(
              decoration: InputDecoration(
              border: OutlineInputBorder(),
              isDense: true, // Added this
              contentPadding: EdgeInsets.all(12),
            ))
          : Text('${_colInfos[colIndex]} $rowIndex'),
    );
  }

  Widget _generateIconColumnCell(
      BuildContext context, int rowIndex, int colIndex) {
    return IconButton(
        onPressed: _edit, icon: Icon(edit ? Icons.check : Icons.edit));
  }

  Widget _generateFirstColumnRow(BuildContext context, int rowIndex) {
    return Container(
      width: 100,
      height: 52,
      child: Row(
        children: [
          IconButton(
              onPressed: _edit, icon: Icon(edit ? Icons.check : Icons.edit)),
          Text('item $rowIndex'),
        ],
      ),
    );

    // if (_colInfos.first == 'Edit') {
    //   return _generateIconColumnCell(context, rowIndex, 0);
    // } else {
    //   return _generateGeneralColumnCell(context, rowIndex, 0);
    // }
    // return Row(
    //   children: _colInfos.sublist(0, 2).map((e) {
    //     if (e == 'Edit') {
    //       return _generateIconColumnCell(
    //           context, rowIndex, _colInfos.indexOf(e));
    //     } else {
    //       return _generateGeneralColumnCell(
    //           context, rowIndex, _colInfos.indexOf(e));
    //     }
    //   }).toList(),
    // );
  }

  Widget _generateRightHandSideColumnRow(BuildContext context, int rowIndex) {
    return Row(
      children: _colInfos.sublist(1).map((e) {
        if (e == 'Edit') {
          return _generateIconColumnCell(
              context, rowIndex, _colInfos.indexOf(e));
        } else {
          return _generateGeneralColumnCell(
              context, rowIndex, _colInfos.indexOf(e));
        }
      }).toList(),
    );
  }

  _edit() {
    setState(() {
      edit = !edit;
    });
  }
}










//   late List<DatatableHeader> _headers;

//   List<int> _perPages = [10, 20, 50, 100];
//   List<String> fields = [
//     'Item',
//     'Description',
//     'Unit',
//     'Price',
//     'Quantity',
//     'Bonus',
//     'Discount%',
//     'Discounted Price',
//     'Serial',
//     'Batch',
//     'Campaign',
//     'Total',
//     'Points Total',
//     'Comment',
//     'Source'
//   ];
//   int _total = 100;
//   int? _currentPerPage = 1000;
//   List<bool>? _expanded;
//   String? _searchKey = "id";

//   int _currentPage = 1;
//   bool _isSearch = false;
//   List<Map<String, dynamic>> _sourceOriginal = [];
//   List<Map<String, dynamic>> _sourceFiltered = [];
//   List<Map<String, dynamic>> _source = [];
//   List<Map<String, dynamic>> _selecteds = [];
//   // ignore: unused_field
//   String _selectableKey = "id";

//   String? _sortColumn;
//   bool _sortAscending = true;
//   bool _isLoading = true;
//   bool _showSelect = true;
//   var random = new Random();

//   List<Map<String, dynamic>> _generateData({int n = 100}) {
//     final List source = List.filled(n, Random.secure());
//     List<Map<String, dynamic>> temps = [];
//     var i = 1;
//     print(i);
//     // ignore: unused_local_variable
//     for (var data in source) {
//       temps.add({
//         "Item": i,
//         "Description": "$i\000$i",
//         "Unit": "Product $i",
//         "Price": "Category-$i",
//         "Quantity": i * 10.00,
//         "Bonus": "20.00",
//         "Discount": "${i}0.20",
//         "Serial": "${i}0",
//         "Batch": "5",
//         "Campaign": i * 10.00,
//         "Total": "20.00",
//         "Points": "${i}0.20",
//         "Comment": "${i}0",
//         "Source": "5",
//       });
//       i++;
//     }
//     return temps;
//   }

//   _initializeData() async {
//     _mockPullData();
//   }

//   _mockPullData() async {
//     _expanded = List.generate(_currentPerPage!, (index) => false);

//     setState(() => _isLoading = true);
//     Future.delayed(Duration(seconds: 3)).then((value) {
//       _sourceOriginal.clear();
//       _sourceOriginal.addAll(_generateData(n: random.nextInt(10000)));
//       _sourceFiltered = _sourceOriginal;
//       _total = _sourceFiltered.length;
//       _source = _sourceFiltered.getRange(0, _currentPerPage!).toList();
//       setState(() => _isLoading = false);
//     });
//   }

//   _resetData({start = 0}) async {
//     setState(() => _isLoading = true);
//     var _expandedLen =
//         _total - start < _currentPerPage! ? _total - start : _currentPerPage;
//     Future.delayed(Duration(seconds: 0)).then((value) {
//       _expanded = List.generate(_expandedLen as int, (index) => false);
//       _source.clear();
//       _source = _sourceFiltered.getRange(start, start + _expandedLen).toList();
//       setState(() => _isLoading = false);
//     });
//   }

//   _filterData(value) {
//     setState(() => _isLoading = true);

//     try {
//       if (value == "" || value == null) {
//         _sourceFiltered = _sourceOriginal;
//       } else {
//         _sourceFiltered = _sourceOriginal
//             .where((data) => data[_searchKey!]
//                 .toString()
//                 .toLowerCase()
//                 .contains(value.toString().toLowerCase()))
//             .toList();
//       }

//       _total = _sourceFiltered.length;
//       var _rangeTop = _total < _currentPerPage! ? _total : _currentPerPage!;
//       _expanded = List.generate(_rangeTop, (index) => false);
//       _source = _sourceFiltered.getRange(0, _rangeTop).toList();
//     } catch (e) {
//       print(e);
//     }
//     setState(() => _isLoading = false);
//   }

//   @override
//   void initState() {
//     super.initState();

//     /// set headers
//     _headers = [
//       DatatableHeader(
//           text: "Item",
//           value: "Item",
//           show: true,
//           sortable: true,
//           textAlign: TextAlign.center),
//       DatatableHeader(
//           text: "Description",
//           value: "Description",
//           show: true,
//           flex: 2,
//           sortable: true,
//           editable: true,
//           textAlign: TextAlign.left),
//       DatatableHeader(
//           text: "Unit",
//           value: "Unit",
//           show: true,
//           sortable: true,
//           textAlign: TextAlign.center),
//       DatatableHeader(
//           text: "Price",
//           value: "Price",
//           show: true,
//           sortable: true,
//           textAlign: TextAlign.left),
//       DatatableHeader(
//           text: "Quantity",
//           value: "Quantity",
//           show: true,
//           sortable: true,
//           textAlign: TextAlign.left),
//       DatatableHeader(
//           text: "Bonus",
//           value: "Bonus",
//           show: true,
//           sortable: true,
//           textAlign: TextAlign.left),
//       DatatableHeader(
//           text: "In Discount",
//           value: "Discount",
//           show: true,
//           sortable: true,
//           textAlign: TextAlign.left),
//       DatatableHeader(
//           text: "Serial",
//           value: "Serial",
//           show: true,
//           sortable: true,
//           textAlign: TextAlign.left),
//       DatatableHeader(
//           text: "Batch",
//           value: "Batch",
//           show: true,
//           sortable: true,
//           textAlign: TextAlign.left),
//       DatatableHeader(
//           text: "Campaign",
//           value: "Campaign",
//           show: true,
//           sortable: true,
//           textAlign: TextAlign.left),
//       DatatableHeader(
//           text: "Total",
//           value: "Total",
//           show: true,
//           sortable: true,
//           textAlign: TextAlign.left),
//       DatatableHeader(
//           text: "In Points",
//           value: "Points",
//           show: true,
//           sortable: true,
//           textAlign: TextAlign.left),
//       DatatableHeader(
//           text: "Comment",
//           value: "Comment",
//           show: true,
//           sortable: true,
//           textAlign: TextAlign.left),
//       DatatableHeader(
//           text: "Source",
//           value: "Source",
//           show: true,
//           sortable: true,
//           textAlign: TextAlign.left),
//     ];

//     _initializeData();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("RESPONSIVE DATA TABLE"),
//         actions: [
//           IconButton(
//             onPressed: _initializeData,
//             icon: Icon(Icons.refresh_sharp),
//           ),
//         ],
//       ),
//       drawer: Drawer(
//         child: ListView(
//           children: [
//             ListTile(
//               leading: Icon(Icons.home),
//               title: Text("home"),
//               onTap: () {},
//             ),
//             ListTile(
//               leading: Icon(Icons.storage),
//               title: Text("data"),
//               onTap: () {},
//             )
//           ],
//         ),
//       ),
// //       body: SingleChildScrollView(
// //           child: Column(
// //               // mainAxisAlignment: MainAxisAlignment.start,
// //               // mainAxisSize: MainAxisSize.max,
// //               children: [
// //             Container(
// //               padding: EdgeInsets.all(8),
// //               height: MediaQuery.of(context).size.width * .2,
// //               child: ListView(
// //                 children: [
// //                   Padding(
// //                     padding: const EdgeInsets.all(8.0),
// //                     child: Wrap(
// //                       spacing: 20.0, // Adjust horizontal spacing
// //                       runSpacing: 20.0, // Adjust vertical spacing
// //                       children: List.generate(
// //                         15,
// //                         (index) => SizedBox(
// //                           width: MediaQuery.of(context).size.width /
// //                               (MediaQuery.of(context).size.width / 180).floor(),
// //                           child: Column(
// //                             crossAxisAlignment: CrossAxisAlignment.start,
// //                             children: [
// //                               Text(
// //                                 fields[index],
// //                                 style: TextStyle(
// //                                   fontWeight: FontWeight.bold,
// //                                   fontSize: 14,
// //                                 ),
// //                               ),
// //                               SizedBox(
// //                                   height:
// //                                       8), // Add some spacing between label and text field
      // TextField(
      //   decoration: InputDecoration(
      //     border: OutlineInputBorder(),
      //     isDense: true, // Added this
      //     contentPadding: EdgeInsets.all(12),
      //   ),
// //                               ),
// //                             ],
// //                           ),
// //                           // child: Padding(
// //                           //   padding: const EdgeInsets.all(5.0),
// //                           //   child: TextField(
// //                           //     autofocus: true,
// //                           //     decoration: InputDecoration(
// //                           //       border: OutlineInputBorder(),
// //                           //       labelText: fields[index],
// //                           //     ),
// //                           //   ),
// //                           // ),
// //                         ),
// //                       ),
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //               // child: GridView.builder(
// //               //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
// //               //     crossAxisCount: 5,
// //               //     crossAxisSpacing: 5.0,
// //               //     mainAxisSpacing: 5.0,
// //               //   ),
// //               //   shrinkWrap: true,
// //               //   itemCount: 15,
// //               //   itemBuilder: (context, index) {
// //               //     return Container(
// //               //       color: Colors.amber,
// //               //       child: Padding(
// //               //         padding: const EdgeInsets.all(5.0),
// //               //         child: SizedBox(
// //               //           width: 20,
// //               // child: Padding(
// //               //   padding: const EdgeInsets.all(5.0),
// //               //   child: TextField(
// //               //     autofocus: true,
// //               //     decoration: InputDecoration(
// //               //       border: OutlineInputBorder(),
// //               //       labelText: fields[index],
// //               //     ),
// //               //   ),
// //               //           ),
// //               //         ),
// //               //       ),
// //               //     );
// //               //   },
// //               // )

// //               // GridView.builder(
// //               //   itemCount: 15,
// //               //   shrinkWrap: true,
// //               //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
// //               //     crossAxisCount:
// //               //         (MediaQuery.of(context).size.width / 150).floor(),
// //               //     mainAxisSpacing: 2.0,
// //               //     crossAxisSpacing: 0,
// //               //   ),
// //               //   itemBuilder: (context, index) {
// //               // return Padding(
// //               //   padding: const EdgeInsets.all(5.0),
// //               //   child: TextField(
// //               //     autofocus: true,
// //               //     decoration: InputDecoration(
// //               //       border: OutlineInputBorder(),
// //               //       labelText: fields[index],
// //               //     ),
// //               //   ),
// //               // );
// //               //   },
// //               // ),
// //             ),
// //             Container(
// //               margin: EdgeInsets.all(10),
// //               padding: EdgeInsets.all(0),
// //               constraints: BoxConstraints(
// //                 maxHeight: 500,
// //               ),
// //               child: Card(
// //                 elevation: 1,
// //                 shadowColor: Colors.black,
// //                 clipBehavior: Clip.none,
// //                 child: ResponsiveDatatable(
// //                   // title: TextButton.icon(
// //                   //   onPressed: () => {},
// //                   //   icon: Icon(Icons.add),
// //                   //   label: Text("new item"),
// //                   // ),
// //                   // reponseScreenSizes: [ScreenSize.xs],
// //                   // actions: [
// //                   //   if (_isSearch)
// //                   //     Expanded(
// //                   //         child: TextField(
// //                   //       decoration: InputDecoration(
// //                   //           hintText: 'Enter search term based on ' +
// //                   //               _searchKey!
// //                   //                   .replaceAll(new RegExp('[\\W_]+'), ' ')
// //                   //                   .toUpperCase(),
// //                   //           prefixIcon: IconButton(
// //                   //               icon: Icon(Icons.cancel),
// //                   //               onPressed: () {
// //                   //                 setState(() {
// //                   //                   _isSearch = false;
// //                   //                 });
// //                   //                 _initializeData();
// //                   //               }),
// //                   //           suffixIcon: IconButton(
// //                   //               icon: Icon(Icons.search), onPressed: () {})),
// //                   //       onSubmitted: (value) {
// //                   //         _filterData(value);
// //                   //       },
// //                   //     )),
// //                   //   if (!_isSearch)
// //                   //     IconButton(
// //                   //         icon: Icon(Icons.search),
// //                   //         onPressed: () {
// //                   //           setState(() {
// //                   //             _isSearch = true;
// //                   //           });
// //                   //         })
// //                   // ],
// //                   headers: _headers,
// //                   source: _source,
// //                   selecteds: _selecteds,
// //                   showSelect: _showSelect,
// //                   autoHeight: false,
// //                   dropContainer: (data) {
// //                     if (int.tryParse(data['id'].toString())!.isEven) {
// //                       return Text("is Even");
// //                     }
// //                     return _DropDownContainer(data: data);
// //                   },
// //                   onChangedRow: (value, header) {
// //                     /// print(value);
// //                     /// print(header);
// //                   },
// //                   onSubmittedRow: (value, header) {
// //                     /// print(value);
// //                     /// print(header);
// //                   },
// //                   onTabRow: (data) {
// //                     print(data);
// //                   },
// //                   onSort: (value) {
// //                     setState(() => _isLoading = true);

// //                     setState(() {
// //                       _sortColumn = value;
// //                       _sortAscending = !_sortAscending;
// //                       if (_sortAscending) {
// //                         _sourceFiltered.sort((a, b) =>
// //                             b["$_sortColumn"].compareTo(a["$_sortColumn"]));
// //                       } else {
// //                         _sourceFiltered.sort((a, b) =>
// //                             a["$_sortColumn"].compareTo(b["$_sortColumn"]));
// //                       }
// //                       var _rangeTop = _currentPerPage! < _sourceFiltered.length
// //                           ? _currentPerPage!
// //                           : _sourceFiltered.length;
// //                       _source = _sourceFiltered.getRange(0, _rangeTop).toList();
// //                       _searchKey = value;

// //                       _isLoading = false;
// //                     });
// //                   },
// //                   expanded: _expanded,
// //                   sortAscending: _sortAscending,
// //                   sortColumn: _sortColumn,
// //                   isLoading: _isLoading,
// //                   onSelect: (value, item) {
// //                     print("$value  $item ");
// //                     if (value!) {
// //                       setState(() => _selecteds.add(item));
// //                     } else {
// //                       setState(
// //                           () => _selecteds.removeAt(_selecteds.indexOf(item)));
// //                     }
// //                   },
// //                   onSelectAll: (value) {
// //                     if (value!) {
// //                       setState(() => _selecteds =
// //                           _source.map((entry) => entry).toList().cast());
// //                     } else {
// //                       setState(() => _selecteds.clear());
// //                     }
// //                   },
// //                   // footers: [
// //                   //   Container(
// //                   //     padding: EdgeInsets.symmetric(horizontal: 15),
// //                   //     child: Text("Rows per page:"),
// //                   //   ),
// //                   //   if (_perPages.isNotEmpty)
// //                   //     Container(
// //                   //       padding: EdgeInsets.symmetric(horizontal: 15),
// //                   //       child: DropdownButton<int>(
// //                   //         value: _currentPerPage,
// //                   //         items: _perPages
// //                   //             .map((e) => DropdownMenuItem<int>(
// //                   //                   child: Text("$e"),
// //                   //                   value: e,
// //                   //                 ))
// //                   //             .toList(),
// //                   //         onChanged: (dynamic value) {
// //                   //           setState(() {
// //                   //             _currentPerPage = value;
// //                   //             _currentPage = 1;
// //                   //             _resetData();
// //                   //           });
// //                   //         },
// //                   //         isExpanded: false,
// //                   //       ),
// //                   //     ),
// //                   //   Container(
// //                   //     padding: EdgeInsets.symmetric(horizontal: 15),
// //                   //     child:
// //                   //         Text("$_currentPage - $_currentPerPage of $_total"),
// //                   //   ),
// //                   //   IconButton(
// //                   //     icon: Icon(
// //                   //       Icons.arrow_back_ios,
// //                   //       size: 16,
// //                   //     ),
// //                   //     onPressed: _currentPage == 1
// //                   //         ? null
// //                   //         : () {
// //                   //             var _nextSet = _currentPage - _currentPerPage!;
// //                   //             setState(() {
// //                   //               _currentPage = _nextSet > 1 ? _nextSet : 1;
// //                   //               _resetData(start: _currentPage - 1);
// //                   //             });
// //                   //           },
// //                   //     padding: EdgeInsets.symmetric(horizontal: 15),
// //                   //   ),
// //                   //   IconButton(
// //                   //     icon: Icon(Icons.arrow_forward_ios, size: 16),
// //                   //     onPressed: _currentPage + _currentPerPage! - 1 > _total
// //                   //         ? null
// //                   //         : () {
// //                   //             var _nextSet = _currentPage + _currentPerPage!;

// //                   //             setState(() {
// //                   //               _currentPage = _nextSet < _total
// //                   //                   ? _nextSet
// //                   //                   : _total - _currentPerPage!;
// //                   //               _resetData(start: _nextSet - 1);
// //                   //             });
// //                   //           },
// //                   //     padding: EdgeInsets.symmetric(horizontal: 15),
// //                   //   )
// //                   // ],
// //                   headerDecoration: BoxDecoration(
// //                     color: Colors.grey[200],
// //                     borderRadius: BorderRadius.only(
// //                         topLeft: Radius.circular(8),
// //                         topRight: Radius.circular(8)),
// //                   ),
// //                   selectedDecoration: BoxDecoration(
// //                     border: Border(
// //                         bottom:
// //                             BorderSide(color: Colors.green[300]!, width: 1)),
// //                     color: Colors.green,
// //                   ),
// //                   headerTextStyle: TextStyle(color: Colors.black),
// //                   rowTextStyle: TextStyle(color: Colors.green),
// //                   selectedTextStyle: TextStyle(color: Colors.white),
// //                 ),
// //               ),
// //             ),
// //           ])),
// //     );
// //   }
// // }

// // class _DropDownContainer extends StatelessWidget {
// //   final Map<String, dynamic> data;
// //   const _DropDownContainer({Key? key, required this.data}) : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //     List<Widget> _children = data.entries.map<Widget>((entry) {
// //       Widget w = Row(
// //         children: [
// //           Text(entry.key.toString()),
// //           Spacer(),
// //           Text(entry.value.toString()),
// //         ],
// //       );
// //       return w;
// //     }).toList();

// //     return Container(
// //       /// height: 100,
// //       child: Column(
// //         /// children: [
// //         ///   Expanded(
// //         ///       child: Container(
// //         ///     color: Colors.red,
// //         ///     height: 50,
// //         ///   )),
// //         /// ],
// //         children: _children,
// //       ),
// //     );
// //   }
// // }

//       body: HorizontalDataTable(
//         leftHandSideColumnWidth: 100,
//         rightHandSideColumnWidth: 5000,
//         isFixedHeader: true,
//         headerWidgets: _getTitleWidget(),
//         isFixedFooter: true,
//         footerWidgets: _getTitleWidget(),
//         leftSideItemBuilder: _generateFirstColumnRow,
//         rightSideItemBuilder: _generateLeftHandSideColumnRow  ,
//         itemCount: 1,
//         rowSeparatorWidget: const Divider(
//           color: Colors.black38,
//           height: 1.0,
//           thickness: 0.0,
//         ),
//         leftHandSideColBackgroundColor: const Color(0xFFFFFFFF),
//         rightHandSideColBackgroundColor: const Color(0xFFFFFFFF),
//       ),
//     );
//   }

//   List<Widget> _getTitleWidget() {
//     return [
//       _getTitleItemWidget('Item', 100),
//       _getTitleItemWidget('Description', 100),
//       _getTitleItemWidget('Unit', 200),
//       _getTitleItemWidget('Price', 100),
//       _getTitleItemWidget('Quantity', 200),
//       _getTitleItemWidget('Bonus', 100),
//       _getTitleItemWidget('Discount', 100),
//       _getTitleItemWidget('Serial', 200),
//       _getTitleItemWidget('Batch', 100),
//       _getTitleItemWidget('Campaign', 200),
//       _getTitleItemWidget('Total', 100),
//       _getTitleItemWidget('Points', 100),
//       _getTitleItemWidget('Comment', 200),
//       _getTitleItemWidget('Source', 100),
//     ];
//   }

//   Widget _getTitleItemWidget(String label, double width) {
//     return Container(
//       width: width,
//       height: 56,
//       padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
//       alignment: Alignment.centerLeft,
//       child: Text(
//         label,
//         style: const TextStyle(
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//     );
//   }

//   Widget _generateFirstColumnRow(BuildContext context, int index) {
//     return Container(
//         // width: 100,
//         // height: 52,
//         // padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
//         // alignment: Alignment.centerLeft,
//         // child: Text('deema'),
//         // child: TextField(
//         //   decoration: InputDecoration(
//         //     border: OutlineInputBorder(),
//         //     isDense: true, // Added this
//         //     contentPadding: EdgeInsets.all(12),
//         //   ),
//         // ),
//         );
//   }

//   Widget _generateLeftHandSideColumnRow(BuildContext context, int index) {
//     return Row(
//       children: <Widget>[
//         Container(
//           padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
//           alignment: Alignment.centerLeft,
//           child: Text('05999'),
//         ),
//         Container(
//           padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
//           alignment: Alignment.centerLeft,
//           child: Text('05999'),
//         ),
//         Container(
//           padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
//           alignment: Alignment.centerLeft,
//           child: Text('05999'),
//         ),
//         Container(
//           padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
//           alignment: Alignment.centerLeft,
//           child: Text('05999'),
//         ),
//         Container(
//           padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
//           alignment: Alignment.centerLeft,
//           child: Text('05999'),
//         ),
//         Container(
//           padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
//           alignment: Alignment.centerLeft,
//           child: Text('05999'),
//         ),
//         Container(
//           padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
//           alignment: Alignment.centerLeft,
//           child: Text('05999'),
//         ),
//         Container(
//           padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
//           alignment: Alignment.centerLeft,
//           child: Text('05999'),
//         ),
//         Container(
//           padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
//           alignment: Alignment.centerLeft,
//           child: Text('05999'),
//         ),
//         Container(
//           padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
//           alignment: Alignment.centerLeft,
//           child: Text('05999'),
//         ),
//         Container(
//           padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
//           alignment: Alignment.centerLeft,
//           child: Text('05999'),
//         ),
//         Container(
//           padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
//           alignment: Alignment.centerLeft,
//           child: Text('05999'),
//         ),
//         Container(
//           padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
//           alignment: Alignment.centerLeft,
//           child: Text('05999'),
//         ),
//         Container(
//           padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
//           alignment: Alignment.centerLeft,
//           child: Text('05999'),
//         ),
//       ],
//     );
//   }
// }

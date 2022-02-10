class TableChart {
  TableChart({
    required this.tableNames,
  });
  late final List<String> tableNames;
  
  TableChart.fromJson(Map<String, dynamic> json){
    tableNames = List.castFrom<dynamic, String>(json['table_names']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['table_names'] = tableNames;
    return _data;
  }
}


enum TableNamesResponseStates{
  SUCCESS,
  FAILURE,
  DUPLICATE,
  IGNORE,
}
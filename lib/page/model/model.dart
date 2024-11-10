class DropdownItem {
  String? imagePath;
  String? label;

  DropdownItem({required this.imagePath, required this.label});

  DropdownItem.fromJson(Map<String,dynamic>json){
    imagePath = json['image_path'] ?? '';
    label = json['label'] ?? '';
  }

  Map<String,dynamic> toJson(){
    final Map<String,dynamic> data = <String,dynamic>{};
    data['image_path'] = imagePath;
    data['label'] = label;
    return data;
  }

  static List<DropdownItem>? fromJsonList(List list) {
    //if (list == null) return null;
    return list.map((item) => DropdownItem.fromJson(item)).toList();
  }
}

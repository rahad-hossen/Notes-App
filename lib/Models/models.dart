class NotesModel{
  int? id;
  String Title,Body;

  NotesModel({this.id, required this.Title,required this.Body});


  Map<String, dynamic> toMap() {

    return {
      'title' : Title,
      'body' : Body,
    };

  }

  factory NotesModel.fromMap(map){
    
    return NotesModel(
        id: map['id'],
        Title: map['title'],
        Body: map['body']
    );
  }




}
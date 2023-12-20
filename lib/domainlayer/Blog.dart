class Blog {
  int? id;
  int? categoryId;
  String? title;
  String? subTitle;
  String? slug;
  String? description;
  String? image;
  String? video;
  String? date;


  Blog(
      {this.id,
        this.categoryId,
        this.title,
        this.subTitle,
        this.slug,
        this.description,
        this.image,
        this.video,
        this.date,
       });

  Blog.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    title = json['title'];
    subTitle = json['sub_title'];
    slug = json['slug'];
    description = json['description'];
    image = json['image'];
    video = json['video'];
    date = json['date'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_id'] = this.categoryId;
    data['title'] = this.title;
    data['sub_title'] = this.subTitle;
    data['slug'] = this.slug;
    data['description'] = this.description;
    data['image'] = this.image;
    data['video'] = this.video;
    data['date'] = this.date;

    return data;
  }
}
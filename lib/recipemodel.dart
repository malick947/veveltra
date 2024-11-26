class Recipemodel {
  late String applabel;
  late String appimgurl;
  late double appcalories;
  late String appurl;
  Recipemodel(
      {this.appcalories = 0.0,
      this.appimgurl = "Image",
      this.applabel = "label",
      this.appurl = "url"});

  factory Recipemodel.fromMap(Map recipe) {
    return Recipemodel(
        applabel: recipe["label"],
        appcalories: recipe["calories"],
        appimgurl: recipe["image"],
        appurl: recipe["uri"]);
  }
}

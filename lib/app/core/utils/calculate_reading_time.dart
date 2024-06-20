int calculateReadingTime(String content){
  final wordCount =  content.split(RegExp(r'\s+')).length;
  final readimgTime = wordCount / 255;
  return readimgTime.ceil();
}
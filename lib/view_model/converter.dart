class Converter{
  static double width(double w,double h){
    if(h>w){
      return w-(w/10);
    }
    return w/2;
  }
}
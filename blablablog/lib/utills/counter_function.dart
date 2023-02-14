class CounterFunction {
  // static count(final value){
  //   if(value<5){
  //     return value.toString();
  //   }
  //   else if(value>5 && value<=10){
  //     return "5+";
  //   }
  //   else if(value>10 && value<=25){return "10+";}
  //   else if(value>25 && value<=100){return "25+";}
  //   else if(value>100 && value<=500){return "100+";}
  //   else if(value>500 && value<=1000){return "500+";}
  //   else if(value>1000 && value<=10000){return "1000+";}
  //   else if(value>10000 && value<=25000){return "10000+";}
  //   else if(value>25000 && value<=50000){return "25000+";}
  //   else if(value>50000 && value<=100000){return "50000+";}
  //   else if(value>100000 && value<=1000000){return "100000+";}
  //   else "1M+";
  // }
  static countforInt(int value) {
    if (value < 5) {
      return value.toString();
    } else if (value >= 5 && value <= 10) {
      return '5+';
    } else if (value > 10 && value <= 25) {
      return '10+';
    } else if (value > 25 && value <= 100) {
      return '25+';
    } else if (value > 100 && value <= 500) {
      return '100+';
    } else if (value > 500 && value <= 1000) {
      return '500+';
    } else if (value > 1000 && value <= 10000) {
      return '1K+';
    } else if (value > 10000 && value <= 25000) {
      return '10K+';
    } else if (value > 25000 && value <= 50000) {
      return '25K+';
    } else if (value > 50000 && value <= 100000) {
      return '50K+';
    } else if (value > 100000 && value <= 500000) {
      return '100K+';
    } else if (value > 500000 && value <= 1000000) {
      return '500K+';
    } else if (value > 1000000 && value <= 5000000) {
      return '1M+';
    } else if (value > 5000000 && value <= 10000000) {
      return '5M+';
    } else if (value > 10000000) {
      return '10M+';
    }
  }
}

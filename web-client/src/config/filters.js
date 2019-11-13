import Vue from  'vue'

// 人民币过滤器
Vue.filter('moneyFormat', (value)=>{
    return '¥' + Number(value).toFixed(2);
});

// 电话号码过滤器
Vue.filter('phoneFormat', (phone)=>{
    // 1. 转成数组
    let phoneArr = [...phone];
    // 2. 遍历
    let str = '';
    phoneArr.forEach((item, index)=>{
        if(index === 3 || index === 4 ||index === 5 ||index === 6 ){
            str += "*";
        }else {
            str += item;
        }
    });
    return str;
});

// 账号过滤器
Vue.filter('nameFormat', (name)=>{
  // 1. 转成数组
  let nameArr = [...name];
  let len = nameArr.length;
  // 2. 遍历
  let str = '';
  // 判断账号是否是手机号
  if(/^[1][3,4,5,7,8][0-9]{9}$/.test(name)){
    nameArr.forEach((item, index)=>{
      if(index === 3 || index === 4 ||index === 5 ||index === 6 ){
        str += "*";
      }else {
        str += item;
      }
    });
  }else{
    nameArr.forEach((item, index)=>{
      if(index != 0 && index != len-1 ){
          str += "*";
      }else {
          str += item;
      }
    });
  }
  return str;
});

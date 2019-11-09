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
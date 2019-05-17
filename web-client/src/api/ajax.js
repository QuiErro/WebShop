import axios from 'axios'

export default function ajax(url = '', params = {}, type = 'GET') {
     // 1. 定义promise对象
     let promise;
     return new Promise((resolve, reject)=>{
        // 2. 判断请求的方式
        if('GET' === type){
              // 2.1 拼接请求字符串
              let paramsStr = '';
              Object.keys(params).forEach(key =>{
                 paramsStr += key + '=' + params[key] + '&'
              });
              // 2.2 过滤最后的&
              if(paramsStr !== ''){
                 paramsStr = paramsStr.substr(0, paramsStr.lastIndexOf('&'))
              }
              // 2.3 完整路径
              url += '?' + paramsStr;
              // 2.4 发送get请求
              promise = axios.get(url)
        }else if('POST' === type){
              promise = axios.post(url, params)
        }
        // 3. 返回请求的结果
        promise.then((response)=>{
            resolve(response.data)
        }).catch(error => {
           reject(error)
        })
     })
}

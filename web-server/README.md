+ `npm init`

+ `npm i -S express`

+ `配置babel环境`

  1. 新建 `.babelrc`

     ```javascript
     // .babelrc   转换高阶语法
     {
       "presets": [
         "env"
       ]
     }
     ```

  2. `npm i babel-preset-env --save-dev `  `开发环境中需要  生产环境中不需要`

+ `npm i  babel-register --save-dev`    `将es6转换成es5`

+ `main.js`文件

  1. `新建src文件夹，新建app.js和config.js文件`

  2. `新建main.js`文件

     ```javascript
     // main.js  入口文件
     require('babel-register');
     require('./src/app');
     ```

+ `配置 package.json 文件 `

  1. ![1565609127017](C:\Users\yang\AppData\Roaming\Typora\typora-user-images\1565609127017.png)
  2. `npm run dev 和 node main.js都可以启动服务器`

+  `babel命令行转码器`

  1. `npm install -g babel-cli`

  2. `npm install babel-cli --save-dev`

  3. ```javascript
     // 命令行
     babel xxx.js  // 可以看到转换后的js文件
     ```

+ `配置 package.json 文件 `

  ![1565619076953](C:\Users\yang\AppData\Roaming\Typora\typora-user-images\1565619076953.png)

  `babel src -d dist` ` 把src目录下的使用高阶语法的文件转换成低阶语法放在dist目录下`

+ `在node中babel识别不了asnyc await 得使用插件`  

  1. ` npm i babel-plugin-transform-runtime -D`
  2. ![1565838186412](C:\Users\yang\AppData\Roaming\Typora\typora-user-images\1565838186412.png)

+ `npm i -S mongoose`

+ `npm i -S connect-mongo`

+ `npm i -S formidable`

+ `npm i -S cookie-parser`

+ `npm i -S cors`

+ `npm i -S ejs`

+ `npm i -S http-errors`

+ `npm i -S js-base64`

+ `npm i -S moment`

+ `npm i -S morgan`

+ `npm i -S mysql`

+ `npm i -S request`

+ `npm i -S svg-captcha`

+ `npm i -S blueimp-md5`

+ `npm i -S express-session`

+ `设置端口号`

  1. `package.json`

     ![1565839303242](C:\Users\yang\AppData\Roaming\Typora\typora-user-images\1565839303242.png)

  2. `全局src/config.js里记录端口号`

     ![1565839397278](C:\Users\yang\AppData\Roaming\Typora\typora-user-images\1565839397278.png)

  3. `app.js里监听端口号`

     ![1565839469313](C:\Users\yang\AppData\Roaming\Typora\typora-user-images\1565839469313.png)

+ 
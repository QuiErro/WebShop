import express from 'express'
import config from './config'
import indexRouter from '../routes/index'

import createError from 'http-errors'
import cookieParser from 'cookie-parser'
import logger from 'morgan'
import session from 'express-session'

const app = express();

// 使用cors解决跨域问题
import cors from 'cors'
app.use(cors());

app.use(cookieParser());

// 使用express-session保存用户登录状况
app.use(session({
	secret: config.secret,
	resave: false,
	saveUninitialized: true,
	cookie: {
		maxAge: config.maxAge, 
	},
}));


// 请求体
import bodyParser from 'body-parser'
app.use(bodyParser.urlencoded({extended: false}));

// view engine setup
app.set('views', config.viewsPath);
app.set('view engine', 'ejs');

app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(express.static(config.publicPath));

app.use('/', indexRouter);

// catch 404 and forward to error handler
app.use((req, res, next) => {
  next(createError(404));
});

// error handler
app.use((err, req, res, next) => {
  // set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'development' ? err : {};

  // render the error page
  res.status(err.status || 500);
  res.render('error');
});

app.listen(config.port, ()=>{
    console.log(`服务器已经启动, 端口是: ${config.port}`);
});

export default app;

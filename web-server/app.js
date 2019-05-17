const createError = require('http-errors');
const express = require('express');
const path = require('path');
const cookieParser = require('cookie-parser');
const logger = require('morgan');
const session = require('express-session');

const app = express();

app.use(cookieParser());
// 使用express-session保存用户登录状况
app.use(session({
	secret: '123456',
	resave: false,
	saveUninitialized: true,
	cookie: {
        maxAge: 1000 * 60 * 60 * 6, // 保存6个小时
    },
}));

const indexRouter = require('./routes/index');
const usersRouter = require('./routes/users');

// 使用cors解决跨域问题
const cors = require('cors');
app.use(cors());

// 请求体
const bodyParser = require('body-parser');
app.use(bodyParser.urlencoded({extended: false}));

// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'ejs');

app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));

app.use('/', indexRouter);
app.use('/users', usersRouter);

// catch 404 and forward to error handler
app.use(function(req, res, next) {
  next(createError(404));
});

// error handler
app.use(function(err, req, res, next) {
  // set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'development' ? err : {};

  // render the error page
  res.status(err.status || 500);
  res.render('error');
});

module.exports = app;

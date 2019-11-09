import {join} from 'path'

export default {
	viewsPath: join(__dirname, '../views'),  
	publicPath: join(__dirname, '../public'),
	uploadsPath: join(__dirname, '../public/uploads'),  // 上传的图片所放置的文件夹
	port: parseInt(process.env.PORT, 10) || 3000,   // 端口号

	host: '127.0.0.1', // 数据库的地址
    user: 'xxxxx', // 账号
    password: 'xxxxx', // 密码
	database: 'xxxxxx', // 数据库名称
	
	secret: '123456',  // session
	maxAge: 1000 * 60 * 60 * 6  // session保存6个小时
}
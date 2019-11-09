import mysql from 'mysql'
import config from '../src/config'

const  conn = mysql.createConnection({
    host: config.host, // 数据库的地址
    user: config.user, // 账号
    password: config.password, // 密码
    database: config.database, // 数据库名称
    multipleStatements: true,  // 允许多条sql同时查询
});

conn.connect();

export default conn;
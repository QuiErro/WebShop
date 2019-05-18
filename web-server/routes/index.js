const express = require('express');
const router = express.Router();
const conn = require('./../db/db');
const svgCaptcha = require('svg-captcha');
const sms_util = require('./../util/sms_util');
const md5 = require('blueimp-md5');

let users = {}; // 用户信息
let tmp_captcha = '';

/* GET home page. */
router.get('/', function (req, res, next) {
    res.render('index', {title: '西二商城'});
});

/**
 * 获取首页轮播图
 */
router.get('/api/homecasual', (req, res) => {
    // console.log(req.session.captcha);

    // 1.1 数据库查询的语句
    let sqlStr = 'SELECT * FROM homecasual';
    // 1.2 执行语句
    conn.query(sqlStr, (error, results, fields) => {
        if (error) {
            res.json({err_code: 0, message: '请求数据失败'});
        } else {
            res.json({success_code: 200, message: results});
        }
    });
});
/**
 * 获取分类数
 */
router.get('/api/category', (req, res) => {
	
    // 1.1 数据库查询的语句
    let sqlStr = 'SELECT * FROM category';
    // 1.2 执行语句
    conn.query(sqlStr, (error, results, fields) => {
        if (error) {
            res.json({err_code: 0, message: '请求数据失败'});
        } else {
            res.json({success_code: 200, message: results});
        }
    });
});

/**
 * 模糊搜索
 */
router.post('/api/searchgoods', (req, res) => {
    // 1.0 获取参数
    let keywords = req.body.keywords;
	keywords = keywords.replace(/\s+/g, ' ');
	keywords = keywords.replace(/(^\s*)|(\s*$)/g, '');
	let keyArr = keywords.split(' ');
	let resultsArr = [];
	for(let i=0; i<keyArr.length; i++){
		// 1.1 数据库查询的语句
		let sqlStr = 'SELECT * FROM recommend WHERE goods_name LIKE ?';
		let param = [ "%" + keyArr[i] + "%" ];
		// 1.2 执行语句
		conn.query(sqlStr, param, (error, results, fields) => {
			if (!error && results.length) {
				resultsArr = resultsArr.concat(results);
			}
		});
	}
	setTimeout(() => {
        if(resultsArr.length){
			res.json({success_code: 200, message: resultsArr});
		}
    }, 200);
});

/**
 * 获取推荐商品列表
 *  1, 3
 */
router.get('/api/recommendshoplist', (req, res) => {
    // 1.0 获取参数
	let category = req.query.category || 1
    let pageNo = req.query.pageNo || 1;
    let pageSize = req.query.count || 3;

    // 1.1 数据库查询的语句
    let sqlStr = 'SELECT * FROM recommend WHERE category = ' + category + ' LIMIT ' + (pageNo - 1) * pageSize + ',' + pageSize;

    // 1.2 执行语句
    conn.query(sqlStr, (error, results, fields) => {
        if (error) {
			//console.log(error);
            res.json({err_code: 0, message: '请求数据失败'});
        } else {
            res.json({success_code: 200, message: results});
        }
    });
});

/**
 * 获取所有商品
 */
router.get('/api/allgoods', (req, res) => {

    // 1.1 数据库查询的语句
    let sqlStr = 'SELECT * FROM recommend';

    // 1.2 执行语句
    conn.query(sqlStr, (error, results, fields) => {
        if (error) {
			console.log(error);
            res.json({err_code: 0, message: '请求数据失败'});
        } else {
            setTimeout(() => {
                res.json({success_code: 200, message: results});
            }, 200);
        }
    });
});
/**
 * 获取首页商品列表
 */
router.get('/api/homeshoplist', (req, res) => {
	let shopList = [];
	for(let i=0; i<5; i++){
		// 1.1 数据库查询的语句
		let sqlStr = 'SELECT * FROM recommend WHERE category = ' + (i+1) + ' LIMIT 3';
		// 1.2 执行语句
		conn.query(sqlStr, (error, results, fields) => {
			if (!error) {
				shopList[i] = results;
			}
		});
	}
	setTimeout(() => {
        res.json({success_code: 200, message: shopList});
    }, 200);
});
/**
 * 获取商品详细信息
 */
router.get('/api/goodsdetail', (req, res) => {
    // 1.0 获取参数
    let goodsNo = req.query.goodsNo;
	// 1.1 数据库查询的语句
	let sqlStr = 'SELECT * FROM recommend WHERE goods_id = ' + goodsNo;
	// 1.2 执行语句
	conn.query(sqlStr, (error, results, fields) => {
		if (!error) {
			setTimeout(() => {
				res.json({success_code: 200, message: results});
			}, 200);
		}
	});
});
/**
 * 获取商品评价
 */
router.get('/api/goodscomment', (req, res) => {
    // 1.0 获取参数
    let goodsId = req.query.goodsId;
	// 1.1 数据库查询的语句
	let sqlStr = 'SELECT * FROM comments WHERE goods_id = ' + goodsId;
	// 1.2 执行语句
	conn.query(sqlStr, (error, results, fields) => {
		if (!error) {
			setTimeout(() => {
				res.json({success_code: 200, message: results});
			}, 200);
		}
	});
});
/**
  评论商品
*/
router.post('/api/postcomment', (req, res) => {
	// 1.0 获取参数
	let goods_id = req.body.goods_id;
	let comment_detail = req.body.comment_detail;
	let comment_rating = req.body.comment_rating;
	let user_name = req.body.user_name;
    const addSql = "INSERT INTO comments(goods_id, comment_detail, comment_rating, user_name) VALUES (?, ?, ?, ?)";
    const addSqlParams = [goods_id, comment_detail, comment_rating, user_name];
    conn.query(addSql, addSqlParams, (error, results, fields) => {
        results = JSON.parse(JSON.stringify(results));
        console.log(error);
        if (!error) {
			// 3. 更新数据
			let sqlStr = "UPDATE recommend SET comments_count = comments_count + 1 WHERE goods_id = " + goods_id;
			conn.query(sqlStr, (error, results, fields) => {
				if (error) {
					console.log(error);
				} else {
					res.json({success_code: 200, message: "发布成功"});
				}
			});
        }
     });
});
/**
 一次性图形验证码
*/
router.get('/api/captcha', (req, res) => {
    // 1. 生成随机验证码
    let captcha = svgCaptcha.create({
        color: true,
        noise: 3,
        ignoreChars: '0o1iIO',
        size: 4
    });
    // console.log(captcha.text);

    // 2. 保存
    req.session.captcha = captcha.text.toLocaleLowerCase();
    // console.log(req.session.captcha);
	tmp_captcha = captcha.text.toLocaleLowerCase();

    // 3. 返回客户端
    res.type('svg');
    res.send(captcha.data);
});

/**
  发送验证码短信
*/
router.get('/api/send_code', (req, res) => {
    // 1. 获取手机号码
    let phone = req.query.phone;

    // 2. 随机产生验证码
    let code = sms_util.randomCode(6);

    /* sms_util.sendCode(phone, code, function (success) {
        if (success) {
             users[phone] = code;
             res.json({success_code: 200, message: '验证码获取成功!'});
         } else {
             res.json({err_code: 0, message: '验证码获取失败!'});
         }
     });*/

    // 成功
    setTimeout(() => {
        users[phone] = code;
        res.json({success_code: 200, message: code});
    }, 2000);
});

/**
  手机验证码登录
*/
router.post('/api/login_code', (req, res) => {
    // 1. 获取数据
    const phone = req.body.phone;
    const code = req.body.code;

    // 2. 验证验证码是否正确
    if (users[phone] !== code) {
        res.json({err_code: 0, message: '验证码不正确!'});
    }

    // 3. 查询数据
    delete  users[phone];

    let sqlStr = "SELECT * FROM user_info WHERE user_phone = '" + phone + "' LIMIT 1";

    conn.query(sqlStr, (error, results, fields) => {
        if (error) {
            res.json({err_code: 0, message: '请求数据失败'});
			console.log(error);
        } else {
            results = JSON.parse(JSON.stringify(results));
            if (results[0]) {  // 用户已经存在
                // console.log(results[0]);
                req.session.userId = results[0].id;
				console.log(req.session.userId);
                // 返回数据给客户端
                res.json({
                    success_code: 200,
                    message: {
						id: results[0].id,
                        user_name: results[0].user_name,
                        user_phone: results[0].user_phone,
						user_sex: results[0].user_sex,
						user_address: results[0].user_address,
						user_sign: results[0].user_sign,
						user_birthday: results[0].user_birthday
					}
                });
            } else { // 新用户
                const addSql = "INSERT INTO user_info(user_name, user_phone) VALUES (?, ?)";
                const addSqlParams = [phone, phone];
                conn.query(addSql, addSqlParams, (error, results, fields) => {
                    results = JSON.parse(JSON.stringify(results));
                    // console.log(results);
                    if (!error) {
                        req.session.userId = results.insertId;
						console.log(req.session.userId);
                        let sqlStr = "SELECT * FROM user_info WHERE id = '" + results.insertId + "' LIMIT 1";
                        conn.query(sqlStr, (error, results, fields) => {
                            if (error) {
                                res.json({err_code: 0, message: '请求数据失败'});
                            } else {
                                results = JSON.parse(JSON.stringify(results));
                                // 返回数据给客户端
                                res.json({
                                    success_code: 200,
                                    message: {
                                        id: results[0].id,
                                        user_name: results[0].user_name,
                                        user_phone: results[0].user_phone
                                    }
                                });
                            }
                        });
                    }
                });
            }
        }
    });

});

/**
 * 用户名和密码登录
 */
router.post('/api/login_pwd', (req, res) => {
	//console.log(req.session.captcha);
	console.log(tmp_captcha);
    // 1. 获取数据
	const user_name = req.body.name;
    const user_phone = req.body.name; //用手机号代替名字测试
    const user_pwd = md5(req.body.pwd);
    const captcha = req.body.captcha.toLowerCase();

    // 2. 验证图形验证码是否正确
    if (captcha !== tmp_captcha) {
        res.json({err_code: 0, message: '图形验证码不正确!'});
        return;
    }
	tmp_captcha = '';
    // 3. 查询数据
    let sqlStr = "SELECT * FROM user_info WHERE user_phone = '" + user_phone + "' LIMIT 1";
    conn.query(sqlStr, (error, results, fields) => {
        if (error) {
            res.json({err_code: 0, message: '用户名不正确!'});
        } else {
            results = JSON.parse(JSON.stringify(results));
            if (results[0]) {  // 用户已经存在
                // 验证密码是否正确
                if (results[0].user_pwd !== user_pwd) {
                    res.json({err_code: 0, message: '密码不正确!'});
                } else {
                    req.session.userId = results[0].id;
					console.log(req.session.userId);
                    // 返回数据给客户端
                    res.json({
                        success_code: 200,
                        message: {
                            id: results[0].id,
                            user_name: results[0].user_name,
                            user_phone: results[0].user_phone,
							user_sex: results[0].user_sex,
							user_address: results[0].user_address,
							user_sign: results[0].user_sign,
							user_birthday: results[0].user_birthday
                        },
                        info: '登录成功!'
                    });
                }
            } else { // 新用户
                const addSql = "INSERT INTO user_info(user_phone, user_pwd) VALUES (?, ?)";
                const addSqlParams = [user_phone, user_pwd];
                conn.query(addSql, addSqlParams, (error, results, fields) => {
                    results = JSON.parse(JSON.stringify(results));
                    // console.log(results);
                    if (!error) {
                        req.session.userId = results.insertId;
						console.log(req.session.userId);
                        let sqlStr = "SELECT * FROM user_info WHERE id = '" + results.insertId + "' LIMIT 1";
                        conn.query(sqlStr, (error, results, fields) => {
                            if (error) {
                                res.json({err_code: 0, message: '请求数据失败'});
                            } else {
                                results = JSON.parse(JSON.stringify(results));
                                // 返回数据给客户端
                                res.json({
                                    success_code: 200,
                                    message: {
                                        id: results[0].id,
                                        user_name: results[0].user_name,
                                        user_phone: results[0].user_phone
                                    }
                                });
                            }
                        });
                    }
                });
            }
        }
    });
});

/**
*  根据session中的用户id获取用户信息
* */
router.get('/api/user_info', (req, res) => {
    // 1.0 获取参数
   // let userId = req.session.userId;  
   let userId = req.query.user_id;
    // 1.1 数据库查询的语句
    let sqlStr = "SELECT * FROM user_info WHERE id = " + userId + " LIMIT 1";
    conn.query(sqlStr, (error, results, fields) => {
        if (error) {
            res.json({err_code: 0, message: '请求数据失败'});
        } else {
            results = JSON.parse(JSON.stringify(results));
            console.log(results);
            if (!results[0]) {
                delete req.session.userId;
                res.json({error_code: 1, message: '请先登录'});
            } else {
                // 返回数据给客户端
                res.json({
                    success_code: 200,
                    message: results[0]
                });
            }
        }
    });
});

/**
 * 退出登录
 */
router.get('/api/logout', (req, res) => {
    // 1. 清除session中userId
    delete  req.session.userId;
    // 2. 提示用户
    res.json({
        success_code: 200,
        message: "退出登录成功"
    });
});

/**
 * 修改用户信息 
 */
router.post('/api/change_user_msg', (req, res) => {
    // 1. 获取数据
    const id = req.body.user_id;
    const user_name = req.body.user_name || '';
    const user_sex = req.body.user_sex || '';
    const user_address = req.body.user_address || '';
    const user_birthday = req.body.user_birthday || '';
    const user_sign = req.body.user_sign || '';

    // 2. 验证
    if (!id) {
        res.json({err_code: 0, message: '修改用户信息失败!'});
    }

    // 3. 更新数据
    let sqlStr = "UPDATE user_info SET user_name = ? , user_sex = ?, user_address = ?, user_birthday = ?, user_sign = ? WHERE id = " + id;
    let strParams = [user_name, user_sex, user_address, user_birthday, user_sign];
    conn.query(sqlStr, strParams, (error, results, fields) => {
        if (error) {
			console.log(error);
            res.json({err_code: 0, message: '修改用户信息失败!'});
        } else {
            res.json({success_code: 200, message: '修改用户信息成功!'});
        }
    });

});

/**
 * 添加商品到购物车
 */
router.post('/api/add_shop_cart', (req, res) => {
    // 1. 验证用户
     let user_id = req.body.user_id;
    /* if(!user_id || user_id !== req.session.userId){
		 console.log( req.session.userId);
         res.json({err_code:0, message:'非法用户'});
         return;
     }
	*/
    // 2. 获取客户端传过来的商品信息
    let goods_id = req.body.goods_id;
    let goods_name = req.body.goods_name;
    let thumb_url = req.body.thumb_url;
    let price = req.body.price;
    let buy_count = req.body.buy_count;
    let is_pay = 0; // 0 未购买 1购买
	let counts = req.body.counts;

    // 3. 查询数据
    let sql_str = "SELECT * FROM cart WHERE goods_id = " + goods_id + " AND user_id=" + user_id + " LIMIT 1";
    conn.query(sql_str, (error, results, fields) => {
        if (error) {
            res.json({err_code: 0, message: '服务器内部错误!'});
        } else {
            results = JSON.parse(JSON.stringify(results));
            // console.log(results);
            if (results[0]) { // 3.1 商品已经存在
                res.json({success_code: 200, message: '该商品已在购物车中'});
            } else { // 3.2 商品不存在
				let add_sql = "INSERT INTO cart(goods_id, goods_name, thumb_url, price, buy_count, is_pay, user_id, counts) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
				let sql_params = [goods_id, goods_name, thumb_url, price, buy_count, is_pay, user_id, counts];
				conn.query(add_sql, sql_params, (error, results, fields) => {
					if (error) {
						res.json({err_code: 0, message: '加入购物车失败!'});
					} else {
						res.json({success_code: 200, message: '加入购物车成功!'});
					}
				});
            }
        }
    });

});

/**
 * 查询购物车的商品
 */
router.get('/api/cart_goods', (req, res) => {
    // 1.0 获取参数
    let user_id = req.query.user_id;

    // 1.1 数据库查询的语句
    let sqlStr = "SELECT * FROM cart WHERE user_id =" + user_id;
    conn.query(sqlStr, (error, results, fields) => {
        if (error) {
			console.log(error);
            res.json({err_code: 0, message: '请求数据失败'});
        } else {
            // 返回数据给客户端
            res.json({success_code: 200, message: results});
        }
    });
});

/**
 * 修改商品数量 
 */
router.post('/api/change_goods_count', (req, res) => {
    // 1. 获取数据
    const goods_id = req.body.goods_id;
    const buy_count = req.body.count;
	const user_id = req.body.user_id;

    // 2. 更新数据
    let sqlStr = "UPDATE cart SET buy_count = ? WHERE goods_id = " + goods_id + " AND user_id = " + user_id;
    let strParams = [buy_count];
    conn.query(sqlStr, strParams, (error, results, fields) => {
        if (error) {
			console.log(error);
            res.json({err_code: 0, message: '修改商品数量失败!'});
        } else {
            res.json({success_code: 200, message: '修改商品数量成功!'});
        }
    });

});

/**
 * 删除单条商品
 */
router.post('/api/delete_goods', (req, res) => {
    // 1. 获取数据
    const goods_id = req.body.goods_id;
	const user_id = req.body.user_id;
	
    // 2. 更新数据
    let sqlStr = "DELETE FROM cart WHERE goods_id =" + goods_id + " AND user_id = " + user_id;
    conn.query(sqlStr, (error, results, fields) => {
        if (error) {
			console.log(error);
            res.json({err_code: 0, message: '删除失败!'});
        } else {
            res.json({success_code: 200, message: '删除成功!'});
        }
    });

});

/**
 * 删除recommend单条商品
 */
router.post('/api/delete_recom_goods', (req, res) => {
    // 1. 获取数据
    const goods_id = req.body.goods_id;
	
    // 2. 更新数据
    let sqlStr = "DELETE FROM recommend WHERE goods_id =" + goods_id;
    conn.query(sqlStr, (error, results, fields) => {
        if (error) {
			console.log(error);
            res.json({err_code: 0, message: '删除失败!'});
        } else {
			let sqlStr2 = "DELETE FROM cart WHERE goods_id =" + goods_id;
			conn.query(sqlStr, (error, results, fields) => {
				if (error) {
					console.log(error);
					res.json({err_code: 0, message: '删除失败!'});
				} else {
					res.json({success_code: 200, message: '删除成功!'});
				}
			});
        }
    });
});

/**
 * 修改recommend商品信息 
 */
router.post('/api/update_recom_goods', (req, res) => {
    // 1. 获取数据
    const goods_id = req.body.goods_id;
    const goods_name = req.body.goods_name;
    const short_name = req.body.short_name;
    const price = req.body.price;
    const counts = req.body.counts;
    const category = req.body.category;

    // 3. 更新数据
    let sqlStr = "UPDATE recommend SET goods_name = ?, short_name = ?, price = ?, counts = ?, category = ? WHERE goods_id = " + goods_id;
    let strParams = [goods_name, short_name, price, counts, category];
    conn.query(sqlStr, strParams, (error, results, fields) => {
        if (error) {
			console.log(error);
            res.json({err_code: 0, message: '修改失败!'});
        } else {
            res.json({success_code: 200, message: '修改成功!'});
        }
    });

});

/**
 * 添加商品到recommend
 */
router.post('/api/add_shop_recom', (req, res) => {
    // 2. 获取客户端传过来的商品信息
    let goods_id = req.body.goods_id;
    let goods_name = req.body.goods_name;
	let short_name = req.body.short_name;
    let price = req.body.price;
	let normal_price = price + 300;
	let market_price = price + 500;
	let sales_tip = req.body.sales_tip;
	let category = req.body.category;
	let comments_count = 0;
	let counts = req.body.counts;
	let thumb_url = 'http://127.0.0.1:3000/images/loading.jpg';
	let image_url = 'http://127.0.0.1:3000/images/loading.jpg';
	let hd_thumb_url = 'http://127.0.0.1:3000/images/loading.jpg';

    // 3. 查询数据
    let sql_str = "SELECT * FROM recommend WHERE goods_id = " + goods_id;
    conn.query(sql_str, (error, results, fields) => {
        if (error) {
            res.json({err_code: 0, message: '服务器内部错误!'});
        } else {
            results = JSON.parse(JSON.stringify(results));
            if (results[0]) { // 3.1 商品已经存在
                res.json({success_code: 500, message: '该商品已在数据库中'});
            } else { // 3.2 商品不存在
				let add_sql = "INSERT INTO recommend(goods_id, goods_name, short_name, thumb_url, image_url, hd_thumb_url, price, normal_price, market_price, sales_tip, category, counts, comments_count) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
				let sql_params = [goods_id, goods_name, short_name, thumb_url, image_url, hd_thumb_url, price, normal_price, market_price, sales_tip, category, counts, comments_count];
				conn.query(add_sql, sql_params, (error, results, fields) => {
					if (error) {
						console.log(error);
						res.json({err_code: 0, message: '加入失败!'});
					} else {
						let sqlStr = "UPDATE category SET cate_counts = cate_counts + 1  WHERE cate_id = " + category;
						conn.query(sqlStr, strParams, (error, results, fields) => {
							if (error) {
								console.log(error);
							} else {
								res.json({success_code: 200, message: '加入成功!'});
							}
						});
					}
				});
            }
        }
    });

});


/**
 * 删除所有商品
 */
router.post('/api/delete_all_goods', (req, res) => {
    // 1. 获取数据
	const user_id = req.body.user_id;
	
    // 2. 更新数据
    let sqlStr = "DELETE FROM cart WHERE user_id = " + user_id;
    conn.query(sqlStr, (error, results, fields) => {
        if (error) {
			console.log(error);
            res.json({err_code: 0, message: '删除失败!'});
        } else {
            res.json({success_code: 200, message: '删除成功!'});
        }
    });

});

module.exports = router;

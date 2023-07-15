const connection = require('../connection/mysql_connection');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');

exports.getUserLogin = async (req, res) => {
    try {      
        const { username, password } = req.body;
        if (!(username && password)) {
            return res.status(400).send("Please enter your username or password..");
        }
        connection.query("SELECT * FROM users WHERE username=?", [username],async (error, result, fields)  => {
            if (error) {
                console.log(error);
                return res.status(400).send();
            }
            if (result[0] && (await bcrypt.compare(password, result[0].password))) {
                const token = await jwt.sign(
                    { user_id: result[0].user_id, username },
                    process.env.TOKEN_LOGIN,
                    {
                        expiresIn: "30d"
                    }
                )
                if(result[0].token == null) connection.query("UPDATE users SET token=? WHERE username=?", [token,username]);
                res.status(200).json(result[0])           
            }else{
                res.status(404).send("Username or Password wrong!")
            }
        })
        
    } catch (err) {
        console.log(err);
        return res.status(500).send();
    }
}

exports.getUsers = async (req, res) => {
    try {
        connection.query("SELECT * FROM users", (error, result, fields) => {
            if(error) {
                console.log(error);
                return res.status(400).send();
            }
            res.status(200).json(result);
        })
    } catch (err) {
        console.log(err);
        return res.status(500).send();
    }
}

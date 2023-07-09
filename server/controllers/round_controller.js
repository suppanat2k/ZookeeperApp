const connection = require('../connection/mysql_connection');


exports.getround = async (req, res) => {
    try {
        connection.query("SELECT * FROM round_show", (error, result, fields) => {
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

const connection = require('../connection/mysql_connection');

exports.getanimals = async (req, res) => {
    try {
        connection.query("SELECT * FROM animals", (error, result, fields) => {
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



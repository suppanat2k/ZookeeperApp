const connection = require('../connection/mysql_connection');

exports.getstage = async (req, res) => {
    try {
        connection.query("SELECT * FROM performance_stage", (error, result, fields) => {
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

exports.getStageManageUpdate = async (req, res) => {
    const {room_id,seats,unit_price} = req.body;
    try {
        connection.query("UPDATE performance_stage SET seats=?,unit_price=? WHERE room_id=?",[seats,unit_price,room_id], (error, result, fields) => {
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

const connection = require('../connection/mysql_connection');


exports.getround = async (req, res) => {
    try {
        connection.query("SELECT round_show.*,room_name,seats,unit_price,animal_name,type,IFNULL(SUM(tk_seats),0) AS tkseats FROM round_show JOIN performance_stage ON round_show.room_id=performance_stage.room_id JOIN animals ON animals.animal_id=performance_stage.animal_id LEFT OUTER JOIN ticket ON ticket.round_seq=round_show.round_seq GROUP BY round_seq", (error, result, fields) => {
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

exports.getRoundMange = async (req, res) => {
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

exports.getRoundMangeUpdate = async (req, res) => {

    const {round_seq,room_id,time_show} = req.body;
    try {
        connection.query("UPDATE round_show SET time_show=? WHERE round_seq=? AND room_id=?",[time_show,round_seq,room_id], (error, result, fields) => {
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

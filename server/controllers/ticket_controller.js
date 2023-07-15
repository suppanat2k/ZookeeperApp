const { v4: uuidv4 } = require('uuid');
const connection = require('../connection/mysql_connection');

exports.sendTicketData = async (req, res) => {
    const {user_id,round_seq,tk_seats,tk_price} = req.body
    try {
        connection.query("INSERT INTO ticket (tk_code ,user_id, round_seq, tk_seats, tk_price) VALUES (?,?,?,?,?);",[await uuidv4(),user_id,round_seq,tk_seats,tk_price], (error, result, fields) => {
            if(error) {
                console.log(error);
                return res.status(400).send();
            }
            console.log("send complete");
            res.status(201).json(result);
        })
    } catch (err) {
        console.log(err);
        return res.status(500).send();
    }
}

exports.getTicketData = async (req, res) => {
    const {user_id} = req.body
    try {
        connection.query("SELECT tk_code,tk_seats,tk_price,round_name,time_show,animal_name,duration,room_name FROM ticket JOIN round_show ON round_show.round_seq=ticket.round_seq JOIN animals ON animals.animal_id=round_show.animal_id JOIN performance_stage ON performance_stage.room_id=round_show.room_id WHERE user_id=? AND tk_status='N'",[user_id], (error, result, fields) => {
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

exports.getTicketScan = async (req, res) => {
    const {tk_code} = req.body
    // console.log(tk_code);
    try {
        connection.query("SELECT tk_status,tk_code,tk_seats,tk_price,round_name,time_show,animal_name,duration,room_name FROM ticket JOIN round_show ON round_show.round_seq=ticket.round_seq JOIN animals ON animals.animal_id=round_show.animal_id JOIN performance_stage ON performance_stage.room_id=round_show.room_id WHERE tk_code=?",[tk_code], (error, result, fields) => {
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

exports.getTicketAccept = async (req, res) => {
    const {tk_code} = req.body
    // console.log(tk_code);
    try {
        connection.query("UPDATE ticket SET tk_status='Y' WHERE tk_code=?",[tk_code], (error, result, fields) => {
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

const connection = require('../connection/mysql_connection');

exports.getanimals = async (req, res) => {
    try {
        connection.query("SELECT * FROM animals JOIN performance_stage ON animals.animal_id=performance_stage.animal_id", (error, result, fields) => {
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

exports.getAnimalManage = async (req, res) => {
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

exports.getAnimalManageUpdate = async (req, res) => {
    const {animal_id,spicies,type,duration} = req.body
    try {
        connection.query("UPDATE animals SET spicies=?,type=?,duration=? WHERE animal_id=?",[spicies,type,duration,animal_id], (error, result, fields) => {
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





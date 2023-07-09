const express = require('express');
const router = express.Router();
const {getanimals} = require('../controllers/animals_controller');
const {getstage} = require('../controllers/stage_controller');
const {getround} = require('../controllers/round_controller');
const { getUserLogin,getUsers, getUserLogout } = require('../controllers/user_controller');

//user manage
router.post('/users/login',getUserLogin);
// router.post('/users/logout',getUserLogout);
router.get('/users',getUsers);

//all read data
router.get('/animals',getanimals);
router.get('/stage',getstage);
router.get('/round',getround);

//data manage

module.exports = router;
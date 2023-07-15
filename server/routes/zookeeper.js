const express = require('express');
const router = express.Router();
const {getanimals, getAnimalManage, getAnimalManageUpdate} = require('../controllers/animals_controller');
const {getstage, getStageManageUpdate} = require('../controllers/stage_controller');
const {getround, getRoundMange, getRoundMangeUpdate} = require('../controllers/round_controller');
const { getUserLogin,getUsers, getUserLogout } = require('../controllers/user_controller');
const { sendTicketData, getTicketData, getTicketScan, getTicketAccept } = require('../controllers/ticket_controller');

//user manage
router.post('/users/login',getUserLogin);
// router.post('/users/logout',getUserLogout);
router.get('/users',getUsers);

//all read data
router.get('/animals',getanimals);
router.get('/round',getround);

//ticket data
router.post('/ticket/create',sendTicketData);
router.post('/ticket',getTicketData);
router.post('/ticket/scan',getTicketScan);
router.post('/ticket/scan/accept',getTicketAccept);

//admin management
router.get('/animals/management',getAnimalManage);
router.post('/animals/management/update',getAnimalManageUpdate);
router.get('/stage/management',getstage);
router.post('/stage/management/update',getStageManageUpdate);
router.get('/round/management',getRoundMange);
router.post('/round/management/update',getRoundMangeUpdate);


module.exports = router;
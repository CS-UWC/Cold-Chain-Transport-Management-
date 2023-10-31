const express = require('express');
const {registerDriver, loginDriver, getDriverOrder, getDriver, updateDriver, updateDriverOrder, assignOrderToDriver, assignedOrders, getDriverOrders} = require('../controllers/driversController');
const {getAllDrivers} = require('../controllers/adminController');
const router = express.Router();
const validatetoken = require('../middleware/validateUser');

// router.use(validatetoken);
router.post('/register', registerDriver);
router.post('/login', loginDriver);
router.get('/all', getAllDrivers); //from adminController
router.get('/', getDriver);
router.put('/:id', updateDriver);
router.get('/:id', getDriverOrder);
router.get('/:id', updateDriverOrder);




module.exports = router;



const express = require('express');
const { getOrders, createOrders, getOrder, updateOrder, assignedOrders, deleteOrder, getAll} = require('../controllers/ordersController');
// const {AssignDriverToOrder} = require('../controllers/adminController');
const {getDriverOrders} = require('../controllers/adminController');
const router = express.Router();
const validateUsertoken = require('../middleware/validateUser');

router.get('/contain', getDriverOrders); //from adminController


router.use(validateUsertoken);
router.get('/assign', assignedOrders);
router.post('/',createOrders);
router.get('/all', getAll); 
router.get('/', getOrders);
router.get('/:id', getOrder);
router.put('/:id', updateOrder);
router.delete('/:id', deleteOrder);


module.exports = router;

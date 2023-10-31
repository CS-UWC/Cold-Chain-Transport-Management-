const db = require("../config");
const orders = require("../models/orders");
const users = require("../models/users");
const drivers = require("../models/drivers");
const createOrderNumber = require("../middleware/ordernumber");
const assignDriverToOrder = require("../middleware/assigndriver");

const jwt = require('jsonwebtoken');


const { DataTypes } = require("sequelize");

users.hasMany(orders);
orders.belongsTo(users);

drivers.hasMany(orders);
orders.belongsTo(drivers);

// Removed unused variable 'userId'
//@desc     Create a new order
//@route    POST /orders
//@access   private
const createOrders = async (req, res) => {
  console.log('The request body is :', req.body);
  
  const {
    companyName,
    productType,
    productName,
    tempRange,
    pickupLocation,
    dropoffLocation,
    customersName,
    customersNumber,
  } = req.body;

  // const token = req.header('Authorization');
  // console.log(token);

  // const token = req.header('Authorization');
  // const tokenWithoutBearer = token.replace('Bearer ', '');
  // if (token && token.startsWith('Bearer ')) {
  //   // Remove the "Bearer " prefix
  //   const tokenWithoutBearer = token.replace('Bearer ', '');

  //   // Now, `tokenWithoutBearer` contains the token without the "Bearer" prefix
  //   console.log(tokenWithoutBearer);

  //   // You can use `tokenWithoutBearer` for token verification or other purposes
  // }
  // if (!token) {
  //   return res.status(401).json({ success: false, message: 'Unauthorized. Token is missing.' });
  // }
  

  
  const userId = req.user.userId;
  console.log(userId);

  // Perform data validation specific to the 'orders' table here

  // const decoded = jwt.verify(tokenWithoutBearer, process.env.ACCESS_TOKEN_SECRET);
  // const userId = decoded.users.userId;
  // console.log(userId);
  
  orders.create({
    userId: userId,
    orderId: createOrderNumber(userId),
    companyName, 
    productType,
    productName,
    tempRange,
    pickupLocation,
    dropoffLocation,
    customersName,
    customersNumber,
    driverId: null
  }).then((order) => {
    res.json({ success: true, order });
  }).catch((err) => {
    console.error('Error inserting data into the orders table: ' + err.message);
    res.status(500).json({ success: false, error: err.message });
  });
};

//@desc     Get all orders
//@route    GET /orders
//@access   private
const getAll = async (req, res) => {
  orders.findAll().then((orders) => {
    res.json({ success: true, orders });
  }).catch((err) => {
    console.error('Error retrieving data from the orders table: ' + err.message);
    res.status(500).json({ success: false, error: err.message });
  });
}

//@desc     Get all orders of a user
//@route    GET /orders
//@access   private
const getOrders = async (req, res) => {
  const userId = req.user.userId;
  orders.findAll({ where: { userId: userId } }).then((orders) => {
    res.json({ success: true, orders });
  }).catch((err) => {
    console.error('Error retrieving data from the orders table: ' + err.message);
    res.status(500).json({ success: false, error: err.message });
  });
}


//@desc     Get a single order
//@route    GET /orders/:id
//@access   private
const getOrder = async (req, res) => {
  // const userId = req.user.userId;
  const order = await order.find({ _id: req.params.id })
  orders.findByFk(req.params.id).then((order) => {
    if (!order) {
      return res.status(404).json({ success: false, error: 'Order not found' });
    }
    res.json({ success: true, order });
  }).catch((err) => {
    console.error('Error retrieving data from the orders table: ' + err.message);
    res.status(500).json({ success: false, error: err.message });
  });
}

//@desc     Update an order
//@route    PUT /orders/:id
//@access   private
const updateOrder = async (req, res) => {

  orders.findByPk(req.params.id).then(async (order) => {
    if (!order) {
      return res.status(404).json({ success: false, error: 'Order not found' });
    }
    
    const updatedOrder = await order.update(req.body, { where: { id: req.params.id } }, { new: true });
    res.json({ success: true, order });
  }).catch((err) => {
    console.error('Error retrieving data from the orders table: ' + err.message);
    res.status(500).json({ success: false, error: err.message });
  });
}




//@desc     Get all current orders
//@route    GET /orders/current
//@access   private
const assignedOrders = async (req, res) => {
  //get drivers id from the token
  assignDriverToOrder(req, res);
}




//@desc     Delete an order
//@route    DELETE /orders/:id
//@access   private
const deleteOrder = async (req, res) => { 
  orders.findByPk(req.params.id).then(async (order) => {
    if (!order) {
      return res.status(404).json({ success: false, error: 'Order not found' });
    }
    await order.destroy();
    res.json({ success: true, message: 'Order has been cancelled' });
  }).catch((err) => {
    console.error('Error retrieving data from the orders table: ' + err.message);
    res.status(500).json({ success: false, error: err.message });
  });
}

module.exports = { getOrders, createOrders, getOrder, updateOrder, assignedOrders, deleteOrder, getAll };
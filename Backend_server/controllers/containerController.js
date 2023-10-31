const { Order } = require('../models/orders');

const getDriverOrders = async (req, res) => {
   const driverId = req.body
   console.log(driverId); 
   Order.findAll({ where: {driverId: driverId } }).then((orders) => {
       res.json({ success: true, orders });
   }).catch((err) => {
       console.error('Error retrieving data from the orders table: ' + err.message);
       res.status(500).json({ success: false, error: err.message });
   });
}

module.exports = getDriverOrders;
const Driver = require('../models/drivers');
const Order = require('../models/orders');
const Container = require('../models/containers');

//this function should randomly assign a driver(online) to an order (pending)
// const AssignDriverToOrder = async (req, res) => {
//     //get all drivers that are online
//     const drivers = await Driver.findAll({ where: { logginStatus: true } });
//     //get all orders that are pending
//     const orders = await Order.findAll({ where: { status: "pending" } });
//     //randomly assign a driver to an order
//     const driver = drivers[Math.floor(Math.random() * drivers.length)];
//     const order = orders[Math.floor(Math.random() * orders.length)];
//     //assign the driver to the order
//     order.driverId = driver.driverId;
//     order.status = "assigned";
//     await order.save();
//     res.json({ success: true, order: order.driverId, order: order.orderId, order: order.status });
// }

// module.exports = AssignDriverToOrder;
const getAllDrivers = async (req, res) => {
    console.log("Get all drivers");

    Driver.findAll().then((Driver) => {
        res.json({ success: true, Driver});
    }).catch((err) => {
        console.error('Error retrieving data from the driverss table: ' + err.message);
        res.status(500).json({ success: false, error: err.message });
    });
}

const getDriverOrders = async (req, res) => {
   const {conId} = req.query;
    console.log("Received conId: ", conId);

   Order.findAll({ where: {conId: conId } }).then((orders) => {
       res.json({ orders });
   }).catch((err) => {
       console.error('Error retrieving data from the orders table: ' + err.message);
       res.status(500).json({ success: false, error: err.message });
   });
}

module.exports = getDriverOrders;


const AssignDriverToOrder = async (req, res) => {
    // Get all drivers that are online
    const drivers = await Driver.findAll({ where: { logginStatus: true } });
    // Get all orders that are pending
    const orders = await Order.findAll({ where: { status: "pending" } });

    // Filter drivers to include only those who have less than 5 assigned orders
    const availableDrivers = drivers.filter(driver => driver.orders.length < MAX_ORDERS_PER_DRIVER);

    if (availableDrivers.length === 0) {
        return res.json({ success: false, message: 'No available drivers with capacity.' });
    }

    // Randomly assign a driver to an order from the available drivers
    const driver = availableDrivers[Math.floor(Math.random() * availableDrivers.length)];
    const order = orders[Math.floor(Math.random() * orders.length)];

    // Assign a container to the driver
    const container = await Container.create({
        driverId: driver.driverId,
        location: "default", // You can specify the initial location
        temperature: "default", // You can specify the initial temperature
        status: "available", // You can specify the initial status
        batteryLevel: "100%", // You can specify the initial battery level
        iceLevel: "0%", // You can specify the initial ice level
    });

    // Update driver's containerId
    driver.containerId = container.conId;
    await driver.save();

    // Assign the driver and container to the order
    order.driverId = driver.driverId;
    order.containerId = container.conId;
    order.status = "assigned";
    await order.save();

    res.json({ success: true, order: { driverId: driver.driverId, orderId: order.orderId, status: order.status } });
};

module.exports = {AssignDriverToOrder, getAllDrivers, getDriverOrders};

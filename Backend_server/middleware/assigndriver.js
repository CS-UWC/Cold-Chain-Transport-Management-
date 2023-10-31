// const  Driver  = require('../models/drivers.js');
// const  Order  = require('../models/orders.js');
// const  Container  = require('../models/containers.js');


// const MAX_ORDERS_PER_DRIVER = 5;

// const AssignDriverToOrder = async (req, res) => {
//     const driverId = req.driver.driverId;
//     console.log(driverId);

//     // Get the driver by ID
//     const driver = await Driver.findOne({ where: { driverId } });

//     if (driver) {
//         if (driver.conId === null) {
//             console.log("Driver does not have a container");
//             // Assign a container to the driver
//             const newContainer = await Container.create({
//                 driverId: driver.driverId,
//                 location: "default",
//                 temperature: "default",
//                 status: "available",
//                 batteryLevel: "100%",
//                 iceLevel: "0%",
//             });

//             // Update driver's containerId
//             driver.conId = newContainer.conId;
//             console.log(newContainer.conId);
//             await driver.save();
//         }

//         // Get all orders that are pending
//         const orders = await Order.findAll({ where: { status: "pending" } });
//         const driverorders = await Order.findAll({ where: { driverId: driverId } });

//         if (driverorders.length < MAX_ORDERS_PER_DRIVER) {
//             console.log("Driver has a container");
//             const order = orders[Math.floor(Math.random() * orders.length)];
//             order.driverId = driver.driverId;
//             order.conId = driver.conId;
//             console.log("Driver has been assigned to an order");
//             order.status = "assigned";
//             await order.save();

//             // Update the driver's orderId
//             driver.orderId = order.orderId;
//             await driver.save();
//             console.log(JSON.stringify({ success: true, order: { driverId: driver.driverId, orderId: driver.orderId} }, null, 2));


//         } else {
//             console.log("Driver has reached the maximum number of orders");
//             res.json({ success: false, message: 'Driver has reached the maximum number of orders' });
//         }
//     }
    
// };

// module.exports = AssignDriverToOrder;

const  Driver  = require('../models/drivers.js');
const  Order  = require('../models/orders.js');
const  Container  = require('../models/containers.js');


const MAX_ORDERS_PER_DRIVER = 5;

const AssignDriverToOrder = async (req, res) => {
    const driverId = req.driver.driverId;
    console.log(driverId);

    // Get the driver by ID
    const driver = await Driver.findOne({ where: { driverId } });

    if (driver) {
        if (driver.conId === null) {
            console.log("Driver does not have a container");
            // Assign a container to the driver
            const newContainer = await Container.create({
                driverId: driver.driverId,
                location: "default",
                temperature: "default",
                status: "available",
                batteryLevel: "100%",
                iceLevel: "0%",
            });

            // Update driver's containerId
            driver.conId = newContainer.conId;
            console.log(newContainer.conId);
            await driver.save();
        }

        // Get all orders that are pending
        const orders = await Order.findAll({ where: { status: "pending" } });
        let driverOrders = await Order.findAll({ where: { driverId: driverId } });

        while (driverOrders.length != MAX_ORDERS_PER_DRIVER) {
            if (!driver.orders) {
                driver.orders = [];
            }
            console.log("Driver has a container");
            const order = orders[Math.floor(Math.random() * orders.length)];
            order.driverId = driver.driverId;
            order.conId = driver.conId;
            console.log("Driver has been assigned to an order");
            order.status = "assigned";
            await order.save();

            // Update the driver's orderId
            driver.orderId = order.orderId;
            await driver.save();
            
            // Add the order to the driver's orders array
            driver.orders.push(order);
            await driver.save();

            // Fetch the updated driver's orders
            driverOrders = await Order.findAll({ where: { driverId: driverId } });
        }
    }
    Order.findAll({ where: { status: 'assigned', driverId: driverId } }).then((orders) => {
    res.json({ success: true, orders });
    }).catch((err) => {
    console.error('Error retrieving data from the orders table: ' + err.message);
    res.status(500).json({ success: false, error: err.message });
    });
};

module.exports = AssignDriverToOrder;
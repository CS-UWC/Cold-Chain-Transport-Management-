require('dotenv').config;

const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
const db = require('./config');

const app = express();

const port = 3001;
// const port = 3306;

app.use(cors());
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

const ordersRoute = require('./routes/ordersRoute');
app.use('/orders', ordersRoute);

app.get('/', (req, res) => {
  res.send('Hello, World!');
  res.end();
  
});

const usersRoute = require('./routes/usersRoute');
app.use('/users', usersRoute);

const driverRoute = require('./routes/driverRoute');
app.use('/drivers', driverRoute);



app.listen(port, () => {
    console.log(`Server is running on port ${port}`);
  });

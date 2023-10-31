const express = require('express');
const {createUsers, getAllUsers,getUser,updateUser, currentUser,loginUser, getOnlineUsers} = require('../controllers/usersController');
const validatetoken = require('../middleware/validateUser');
const router = express.Router();

// router.use(validatetoken);
router.post('/create',createUsers);
router.get('/', getAllUsers);
router.get('/current', validatetoken, currentUser);
router.get('/:id', getUser);
router.post('/login', loginUser);
router.put('/:id', updateUser);
router.get('/online', getOnlineUsers);




module.exports = router;
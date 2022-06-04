// creaate express app
const express = require('express');
const app = express();
const mongoose = require('mongoose');
const formData = require('express-form-data');
const cors = require('cors')
const http = require('http');
const server = http.createServer(app);

require('dotenv/config');

// middleware
app.use(formData.parse());
app.use(express.json());
app.use(express.urlencoded({extended: true}));
app.options('*', cors())
app.use(cors())

// import routes
const email_register_routes = require('./routes/email_register_routes');

// routes
app.use('/api/email_register',email_register_routes)


app.use((req, res, next) => {
  res.status(200).send({message : "ini dia backend"})
})

// listen to port
server.listen(process.env.PORT, () => {
  console.log("Server running at port " +  process.env.PORT)
})
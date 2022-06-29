const express = require('express');
const bodyParser = require("body-parser");
var cors = require('cors');
const app = express();
require("dotenv").config();


// Postgres Configuration
const { Pool } = require('pg');
const pool = new Pool({
  user: 'postgres',//process.env.DB_USER,
  host:'localhost',// process.env.DB_HOST,
  database: 'trab_seguranca_audit',//process.env.DB_DATABASE,
  password:'postgres', //process.env.DB_PASSWORD,
  port:'5432', //process.env.DB_PORT
});
// the pool will emit an error on behalf of any idle clients
// it contains if a backend error or network partition happens
pool.on('error', (err, client) => {
  console.error('Unexpected Error:', err);
  process.exit(-1);
});

var corsOptions = {
    origin: 'http://localhost:4200',
    optionsSuccessStatus: 200
  };

app.use(cors(corsOptions));

let user = [];
const rootUrl = '/api';

app.use(bodyParser.json());

app.get(`${rootUrl}/user`, (req, res) => { res.json(user); });

app.post(`${rootUrl}/user`, (req, res) => {

    ;(async () => {
        const { rows } = await pool.query('SELECT test(0,1,1) as permissao');
        res.json(rows);
      })().catch(err => {
        res.json(err.stack)
      })

    /*const reqUser = req.body.user;
    user = [];
    user.push(reqUser);
    res.json(user);*/


  });

app.get('/api/status', (req, res) => {
  res.json({info: 'Node.js, Express, and Postgres API'});
});
app.get('/', (req, res) => {
  res.send('Hello  World!');
});
// Listen to the specified port, otherwise 3080
const PORT = process.env.PORT || 3080;
const server = app.listen(PORT, () => {
  console.log(`Server Running: http://localhost:${PORT}`);
});
/**
 * The SIGTERM signal is a generic signal used to cause program 
 * termination. Unlike SIGKILL , this signal can be blocked, 
 * handled, and ignored. It is the normal way to politely ask a 
 * program to terminate. The shell command kill generates 
 * SIGTERM by default.
 */
process.on('SIGTERM', () => {
    server.close(() => {
        console.log('Server Close: Process Terminated!');
    });
});
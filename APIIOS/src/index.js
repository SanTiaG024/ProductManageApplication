const express = require('express');
const morgan = require('morgan');
const app= express();

app.set('port', 3000)
app.set('json spaces', 2)

app.use(morgan('dev'));
app.use(express.urlencoded({extended: false}));
app.use(express.json());

app.use(require('./routes/index'));
app.use(require('./routes/brands'));
app.use(require('./routes/suppliers'));
app.use(require('./routes/products'));



app.listen(app.get('port'), () =>{
    console.log( `Server on port ${app.get('port')}`);
});
const{Router}=require('express');
const router=Router(); 

const supplier=require('../supplier.json');
console.log(supplier);

router.get('/suppliers', (req, res) =>{
    res.json(supplier);
});

router.post('/suppliers', (req, res) =>{
    const{name, code}= req.body;
  if (name && code ){
      const id = supplier.length+1;
      const newSupplier = {id, ...req.body}; 
      supplier.push(newSupplier);
      res.json(supplier);
   }else{
      res.status(500).json({error: 'There was an error.'});
  }
});

module.exports=router;
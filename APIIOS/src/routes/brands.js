const{Router}=require('express');
const router=Router(); 

const brand=require('../brand.json');
console.log(brand);

router.get('/brands', (req, res) =>{
    res.json(brand);
});

router.post('/brands', (req, res) =>{
    const{name, code}= req.body;
  if (name && code ){
      const id = brand.length+1;
      const newBrand = {id, ...req.body}; 
      brand.push(newBrand);
      res.json(brand);
      console.log(product);
   }else{
      res.status(500).json({error: 'There was an error.'});
  }
});

module.exports=router;
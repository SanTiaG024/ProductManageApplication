const{Router}=require('express');
const router=Router(); 

const product=require('../products.json');
console.log(product);

router.get('/products', (req, res) =>{
    res.json(product);
});

router.post('/products', (req, res) =>{
    const{name, barcode, price, amount, brand, supplier}= req.body;
  if (name && barcode && price && amount && brand && supplier){
      const id = product.length+1;
      const newProduct = {id, ...req.body}; 
      product.push(newProduct);
      res.json(product);
      console.log(product);
   }else{
      res.status(500).json({error: 'There was an error.'});
  }
});


module.exports=router;
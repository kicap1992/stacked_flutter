const express = require('express');
const router = express.Router();
const { createUserWithEmailAndPassword, signInWithEmailAndPassword ,updateProfile} = require('firebase/auth');
const { auth } = require('../firebase-config') // jalan


// create '/' get request
router.get('/', async (req, res) => {
  try {
    const email = "test@hotmail.com";
    const password = "password";
    const user = await createUserWithEmailAndPassword(auth, email, password);
    // console.log(user); 
    // auth.createUser({
    //   email: email,
    //   password: password,
    //   emailVerified : true
    // })


    console.log(user);
    res.status(200).send({ message: " ini dia backend router regis email" });
  } catch (err) {

    res.status(500).send({ message: err });
  }

})

router.get('/login', async (req, res) => {
  try {
    const email = "test@hotmail.com";
    const password = "password";
    let user = await signInWithEmailAndPassword(auth, email, password);

    user = auth.currentUser

    // console.log(user); 
    // update user emailVerified to true
    // await user.auth.updateUser(user.user.uid, {
    //   emailVerified: true
    // })
    await updateProfile(user, {
      displayName : "Aran",
      emailVerified: true
    })
    console.log(user);
    res.status(200).send({ message: " ini dia backend router regis email" });
  } catch (err) {

    res.status(500).send({ message: err });
  }

})

module.exports = router;
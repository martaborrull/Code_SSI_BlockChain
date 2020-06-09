# Code_SSI_BlockChain
We are Group 8:
- Virginia Mariné NIA 206107
- Esther Flores NIA 205328
- Candela García NIA 207529
- Marta Borrull NIA 206745
- María Hernández NIA 204479

The aim of our code is to valid the identity of a person that it is registered in the Blockchain. 
This means that any person can validate the identity just by using a DNI and in this way there 
will not be needed any other type of personal information.

Our code has 4 contracts:
- mySSI: it creates a register of identities
  - Inside this contract we have a struct of person which consist in two hashes:
    - a DNI (that acts like a public key).
    - a private key that anyone know.
  - These hashes will have each corresponding keys all private keys are stored in a list.
  - It has a modifier for a function to be accessible just by the owner.
  - This function getHashToAddress returns the address of the person who has the privateHash
  - It is also the function setHashToAddress that stores the private hash to the corresponding address.
  - All this information is related to a person, so for this reason there exist the function setPersonInfo where it is stored the keys, the privatehash and the address related to a DNI and the privatekey.
  - There is the function getPersonInfo where only returns the DNI which, as we said above, is the only public information.
  - Finally, the function isValid. This validates the identity by checking the address of the corresponding DNI.
  
- ERC20Token: it acts as our ERC20 Token
  -It just containg the balances corresponding to an address.
  
- MyToken is ERC20Token: this contract inherits everything within ERC20Token
           
- myContract: this contract allows the owner to buy tokens, 
          and with these tokens to pay for an "imaginary" car rentCar
          The client will be allowed to rent the car only if it has 
          a valid identity in the register

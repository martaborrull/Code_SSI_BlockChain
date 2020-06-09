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
  -Moreover, these 
- ERC20Token: it acts as our ERC20 Token
- MyToken is ERC20Token: this contract inherits everything
           within ERC20Token
           
- myContract: this contract allows the owner to buy tokens, 
          and with these tokens to pay for an "imaginary" car rentCar
          The client will be allowed to rent the car only if it has 
          a valid identity in the register

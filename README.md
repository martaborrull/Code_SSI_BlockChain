# Code_SSI_BlockChain
Group 8 Members:
- Virginia Mariné NIA 206107
- Esther Flores NIA 205328
- Candela García NIA 207529
- Marta Borrull NIA 206745
- María Hernández NIA 204479

The aim of our implementation is to validate the identity of a person that it is registered in the Blockchain network.
This means that any person can validate the identity just by using a DNI and in this way there 
will not be needed any other type of personal information.
Moreover, we just made an example of how our code can be use when we want to check if a person is valid or not. 
So when a client wants to rent a car, this one will show his DNI(public key) and the system will say if the person can proceed to rent a car or not. 

Our code has **4 contracts**:
- **mySSI**: it creates a register of identities
  - Inside this contract we have a struct of person which consist in two parts:
    - a DNI (that acts like a public key).
    - a private key that anyone know.
  - List of people, which receives as input the address and returns as output the person struct.
  - Two hashes will be carried out:
      - privateHash: it will be the result of concatenating DNI and private key and using
        a SHA256 encryptation.
      - publicHash: SHA256 encryptation of DNI.
  - All private keys are stored in a list, which cannot be accessed by anyone.
  - A -modifier- for a function to be accessible just by the owner.
  - The function -getHashToAddress- returns the address of the person who has the corresponding privateHash.
  - There is also the function -setHashToAddress- that maps the private hash to the corresponding address.
  - All this information is related to a person, so for this reason there exists the function -setPersonInfo- where keys, privatehash and address related to a DNI and the privatekey are stored.
  - Function -getPersonInfo- returns the DNI which, as we said above, is the only public information.
  - Finally, function -isValid-. This validates the identity by checking the address of the corresponding DNI.
  
- **ERC20Token**: it acts as our ERC20 Token
  -It just containg the balances corresponding to an address.
  
- **MyToken is ERC20Token**: this contract inherits everything within ERC20Token, adding some functionalities like a function -daysCount()-, which will keep the accounts of how many days the client has rented the car according to how many tokens he transfers.
           
- **myContract**: This contract allows the owner to buy tokens, and with these tokens to pay for an "imaginary" car rentCar. The client will be allowed to rent the car only if it has a valid identity in the register.
The functions that are part from this contract are:
  - buyToken: Where ones the identity is valid, the person will be able to buy token.
  - payRent: it just takes 5 tokens, which are the value to pay for a day of renting.
  - rentCar: validates the identity and call the other functions only if it is valid.

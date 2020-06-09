/*
GROUP 8 
Virginia Mariné NIA 206107
Esther Flores NIA 205328
Candela García NIA 207529
Marta Borrull NIA 206745
María Hernández NIA 204479
*/

/*
    We have 4 contracts: 
    - mySSI: it creates a register of identities
    - ERC20Token: it acts as our ERC20 Token
    - MyToken is ERC20Token: this contract inherits everything
           within ERC20Token
           
    - myContract: this contract allows the owner to buy tokens, 
          and with these tokens to pay for an "imaginary" car rentCar
          The client will be allowed to rent the car only if it has 
          a valid identity in the register
          
*/

pragma solidity 0.5.16;


contract mySSI {

    struct person {

        string privateKey;
        string DNI;

    }
    
    address owner;

    constructor () public {
        owner = msg.sender;
    }
    
    // each person will have two hashes: 
        // 1. publicHash: hash with DNI, 2. privateHash: hash with DNI and private key
    mapping (address => person) people;
  
    // each hash value with DNI and private key of each person, will be the keys to 
    // this "dictionary", which has as values the addresses of the people  
    mapping (string=> address) hashToAddress;


    //all private keys stored in this list
    //this list cannot be seen by anyone
    mapping (string => string) mykeys;

    //whether a person is citizen or not
    mapping (address => bool) isValid;

    
    //Modifier for a function to be accessible just by the owner
    modifier onlyOwner (){
        require(msg.sender == owner);
        _;
    } 
    
    function getOwner() public view returns (address){

        return owner;
    
    }
    

    // This function returns the address of the person who has the privateHash
    
    function getHashToAddress (string memory privateHash) onlyOwner public view 
                returns (address) {
        
        return hashToAddress[privateHash];
    }
    
    
    //Input: privateHash and the address
    //Maps the hashWithkey to the same address
    
    function setHashToAddress (string memory privateHash,  address _address) onlyOwner public {
        
        hashToAddress [privateHash] = _address;
    }
    
  
    // This function sets the information of the client
    // Only accessible by owner
    // Validates person
    
    function setPersonInfo (string memory privateHash, string memory publicHash, 
            string memory _DNI, string memory _privateKey,  address _myAddress) 
            onlyOwner public {
                
                if(isValid[_myAddress]==false){
                    setHashToAddress(privateHash, _myAddress);
                    mykeys [publicHash] = _privateKey;
                
                    people[_myAddress].DNI = _DNI;
                    people[_myAddress].privateKey = _privateKey;

                    isValid[_myAddress] = true;
                }
                
                
        
    }
    
    // Input: privateHash of the client
    //Returns DNI  of the person stored in ledger
    function getPersonInfo (string memory privateHash)  onlyOwner view public 
            returns (string memory){
                address _myAddress = hashToAddress [privateHash];
                person memory p = people [_myAddress];
                return (p.DNI);
        
    }
    

    //Input: address of the person
    //Returns: true if person is valid, false if not
    function isValidPerson (address _myAddress) view public returns (bool){
        return isValid[_myAddress];
    }
    
}




contract ERC20Token { 
    
    string name; 
    mapping(address => uint256) public balances;

    constructor(string memory _name) public { 
        name = _name; 
    
    } 

    function daysCount() public { 
        balances[tx.origin] += 1;
        
    } 
    
} 





contract MyToken is ERC20Token { 
    
    address[] public owners; 
    uint256 public counterDay; 
    string public symbol; 
    
    constructor(string memory _name, string memory _symbol) ERC20Token(_name) public { 
        symbol = _symbol; 
        
    }
    
    // If rent is done, then sum one day in the counterDay (meaning one day with the car)
    function daysCount() public { 
        super.daysCount();
       
        counterDay ++; 
        owners.push(msg.sender);
    
        
    } 
    
}



contract MyContract {
    
    
    uint256 finishTime;
    address payable wallet;
    mapping(address => uint256) public balances;

    address owner;
    address public token; 
    
    
    constructor(address payable _wallet, address _token) public{
        owner = msg.sender;
        finishTime = 1593625269;
        wallet = _wallet;
        token = _token; 
    }
    
    // the user will be able to buy tokens
    function buyToken() public payable onlyWhileOpen{ 
        ERC20Token _token = ERC20Token(address(token));
        _token.daysCount();
        wallet.transfer(msg.value);
        balances[msg.sender] += 1;
    }
    
    // the rent will cost 5 tokens, which is transfered to the wallet
     function payRent() public payable{
        balances[msg.sender] -=5;
        wallet.transfer(msg.value);
    }
        
    function() external payable { 
        buyToken(); 
        
    }
  
    // modifier so that the owner is the only one who can enter the function
    modifier onlyOwner(){
        require(msg.sender == owner);
        _;
    }
    
    //modifier so that it is possible to enter the function only before the time expires
    modifier onlyWhileOpen() {    
        require(block.timestamp <= finishTime);    
        _;
        
    }
    
    mySSI myidentity;

    //if the identity of the person is valid, then proceed with the rent
    function rentCar() public onlyOwner onlyWhileOpen{
            
        
        if (myidentity.isValidPerson(owner) == true){
            
            payRent();
            
        }
        
    }
    
}
    
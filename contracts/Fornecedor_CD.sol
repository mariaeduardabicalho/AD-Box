pragma solidity >=0.4.22 <0.7.0;


/**
 * @title Bank
 * @dev Implements bank system
 */
contract FonecedorCd   {
    uint256 private capital;
    address private owner;

    struct empresa {
        address empresaID;
        uint256 balance;
        uint256 estoque;

    }
 

    mapping(address => empresa) private empresas;
    
    // empresas.price = 10;
    
    // mapping(address => empresa) private fornecedor;

    constructor() public payable {
        owner = msg.sender;
        capital = 0;
    }
    
    
    function depositmon() public payable {
        empresas[msg.sender].empresaID = msg.sender;
        empresas[msg.sender].balance += msg.value;
        
        capital += msg.value;
    }
    
   
    function balance() public view returns (uint256) {
        if (empresas[msg.sender].balance != 0) {
            return empresas[msg.sender].balance;
        }
        return 0;
    }
    
    function estoque() public view returns (uint256) {
        if (empresas[msg.sender].estoque != 0) {
            return empresas[msg.sender].estoque;
        }
        return 0;
    }
    
    function get_capital() public view returns (uint256) {
        require(
            msg.sender == owner,
            "Only banker can see the total cash of the bank."
        );
        return capital;
    }


    function withdraw(uint256 amount) public returns (uint256) {
        if (empresas[msg.sender].balance >= amount) {
            empresas[msg.sender].balance -= amount;
            capital -= amount;
            msg.sender.transfer(amount);
            return amount;
        }
        return 0;
    }
    
    function quantrem(uint256 quantidade)  
        public payable
        returns (bool) {
        empresas[msg.sender].empresaID = msg.sender;
        empresas[msg.sender].estoque += quantidade;
       
        return true;
    }
    
    

   function compra(address beneficiary, uint256 quantidade )
        public payable
        returns (bool)
    {
        uint256  price = 10;
        if (empresas[msg.sender].balance >= quantidade * price ) {
            empresas[msg.sender].balance -= quantidade * price  ;
            empresas[msg.sender].estoque += quantidade;
            

            empresas[beneficiary].empresaID = beneficiary;
            empresas[beneficiary].balance += quantidade * price;
            empresas[msg.sender].estoque -= quantidade;
            
            return true;
        }
        return false;
    }
   
}



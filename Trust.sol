pragma solidity =0.8.1;

contract Trust {
    struct Beneficiary{
        uint amount;
        uint maturity;
        bool paid;
    }
    mapping(address => Beneficiary) public beneficiaries;
    address public admin;
    
    constructor() {
        admin = msg.sender;
    }
    
 function addBeneficiary(address beneficiary, uint timeToMaturity) external payable {
     require(msg.sender == admin, 'only admin');
     require(beneficiaries[msg.sender].amount ==0,'beneficiary already exist');
     beneficiaries[beneficiary] = Beneficiary(msg.value, block.timestamp + timeToMaturity, false);
     }
        
        function withdraw() external {
            Beneficiary storage beneficiary = beneficiaries[msg.sender];
            require(beneficiary.maturity <= block.timestamp, 'too early');
            require(beneficiary.amount >0,'only beneficiary can withdraw');
            require(beneficiary.paid == false, 'paid already');
            beneficiary.paid = true;
            payable (msg.sender).transfer(beneficiary.amount);
            
        }
    }
    
    

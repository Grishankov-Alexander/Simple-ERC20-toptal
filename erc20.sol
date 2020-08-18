pragma solidity ^0.5.10;

contract ERC20Interface {
    function totalSupply() public view returns (uint256);
    function balanceOf(address tokenOwner)
        public view returns (uint256);
    function allowance(address tokenOwner, address spender)
        public view returns (uint256);
    function transfer(address to, uint256 amount)
        public returns (bool success);
    function approve(address spender, uint256 tokens)
        public returns (bool success);
    function transferFrom(address from, address to, uint256 tokens)
        public returns (bool success);
    
    event Approval(address indexed tokenOwner,
        address indexed spender, uint tokens);
    event Transfer(address indexed from,
        address indexed to, uint256 tokens);
}

contract ERC20Token is ERC20Interface {
    string public constant name = "My Custom Token";
    string public constant symbol = "MCT";
    uint8 public constant decimals = 18;
    uint256 totalSupply_;
    mapping(address => uint256) balances;
    mapping(address => mapping (address => uint256)) allowed;
    
    constructor(uint256 initialAmount) public
    {
        totalSupply_ = initialAmount;
        balances[msg.sender] = totalSupply_;
    }
    
    function totalSupply() public view returns (uint256)
    {
        return totalSupply_;
    }
    
    function balanceOf(address tokenOwner)
        public view returns (uint256)
    {
        return balances[tokenOwner];
    }
    
    function allowance(address tokenOwner, address spender)
        public view returns (uint256)
    {
        return allowed[tokenOwner][spender];
    }
    
    function transfer(address to, uint256 amount)
        public returns (bool success)
    {
        require(amount <= balances[msg.sender]);
        balances[msg.sender] -= amount;
        balances[to] += amount;
        emit Transfer(msg.sender, to, amount);
        return true;
    }
    
    function approve(address spender, uint256 tokens)
        public returns (bool success)
    {
        allowed[msg.sender][spender] = tokens;
        emit Approval(msg.sender, spender, tokens);
        return true;
    }
    
    function transferFrom(address from, address to, uint256 tokens)
        public returns (bool success)
    {
        require(tokens <= balances[from]);
        require(tokens <= allowed[from][msg.sender]);
        balances[from] -= tokens;
        allowed[from][msg.sender] -= tokens;
        balances[to] += tokens;
        emit Transfer(from, to, tokens);
        return true;
    }
}

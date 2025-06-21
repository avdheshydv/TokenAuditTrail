// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract TokenAuditTrail {
    address public owner;

    struct TokenTransaction {
        address from;
        address to;
        uint256 amount;
        uint256 timestamp;
    }

    TokenTransaction[] private transactions;

    event TransactionLogged(address indexed from, address indexed to, uint256 amount, uint256 timestamp);
    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Caller is not the owner");
        _;
    }

    function logTransaction(address _to, uint256 _amount) public {
        TokenTransaction memory newTx = TokenTransaction({
            from: msg.sender,
            to: _to,
            amount: _amount,
            timestamp: block.timestamp
        });
        transactions.push(newTx);
        emit TransactionLogged(msg.sender, _to, _amount, block.timestamp);
    }

    function getTransactionCount() public view returns (uint256) {
        return transactions.length;
    }

    function getTransaction(uint256 index) public view returns (address from, address to, uint256 amount, uint256 timestamp) {
        require(index < transactions.length, "Invalid index");
        TokenTransaction memory txInfo = transactions[index];
        return (txInfo.from, txInfo.to, txInfo.amount, txInfo.timestamp);
    }

    function transferOwnership(address newOwner) public onlyOwner {
        require(newOwner != address(0), "New owner is the zero address");
        emit OwnershipTransferred(owner, newOwner);
        owner = newOwner;
    }
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract STKD is Ownable, ERC20 {
    address private _burner;

    modifier onlyBurner() {
        _checkBurner();
        _;
    }

    constructor () ERC20("STKD", "STKD") {
    }

    function transfer(address to, uint256 amount) public onlyOwner override returns (bool) {
        return super.transfer(to, amount);
    }

    function transferFrom(address from, address to, uint256 amount) public onlyOwner override returns (bool) {
        return super.transferFrom(from, to, amount);
    }

    function mint(address to, uint256 amount) external onlyOwner {
        require(to != address(0), "ERROR: Can not mint to the zero address");
        _mint(to, amount);
    }

    function burn(address from, uint256 amount) external onlyBurner {
        require(from != address(0), "ERROR: Can not burn from the zero address");
        _burn(from, amount);
    }

    function setBurner(address burner_) external onlyOwner {
        require(burner_ != address(0), "ERROR: Can not set burner to the zero address");
        _burner = burner_; 
    }

    function burner() public view virtual returns (address) {
        return _burner;
    }

    function _checkBurner() internal view virtual{
        require(_burner == msg.sender, "ERROR: only burner can burn tokens");
    }
}
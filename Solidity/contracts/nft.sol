pragma solidity ^0.6.12;

import "OpenZeppelin/openzeppelin-contracts@3.4.0/contracts/token/ERC721/ERC721.sol";

contract NFT is ERC721 {
    constructor() ERC721("Llama", "LLAMA") public {
    }
}

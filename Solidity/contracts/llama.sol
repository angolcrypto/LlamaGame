pragma solidity ^0.6.12;

import "./nft.sol";
import "OpenZeppelin/openzeppelin-contracts@3.4.0/contracts/math/SafeMath.sol";

contract llama is NFT {

    using SafeMath for uint256;

    struct Llama {
        string name;
        uint256 cooldownHunger;
        uint256 createdOn;
        uint256 fatherId;
        uint256 motherId;
        uint256 level;
    }

    Llama[] public llamas;

    modifier onlyOwnerOf(uint256 _tokenId) {
      require(ownerOf(_tokenId) == msg.sender);
      _;
    }

    function _createLlama(string memory _name, uint256 _fatherId, uint256 _motherId) private returns(uint256) {
        uint256 startLevel = 1;
        uint256 id = llamas.length;
        llamas.push(Llama(_name, now, now, _fatherId, _motherId, startLevel));
        _mint(msg.sender, id);
        _setTokenURI(id, 'https://game.example.gg/metadata.json');

        return(id);
    }

    function _levelUp(uint256 _tokenId) private returns(uint256) {
        llamas[_tokenId].level = llamas[_tokenId].level.add(1);
        return(llamas[_tokenId].level);
    }

    function _triggerCooldown(uint256 _tokenId, uint256 _time) private {
        llamas[_tokenId].cooldownHunger = now + _time;
    }

    function _eatGrass(uint256 _tokenId) private {
        require(now > llamas[_tokenId].cooldownHunger, "Please complete your cooldown.");
        _levelUp(_tokenId);
        _triggerCooldown(_tokenId, 6 hours);
    }

    function createFirstLlama() external returns(uint256) {
        require(balanceOf(msg.sender) == 0);
        return(_createLlama("Llama", 0, 0));
    }

    function feedMyLlama(uint256 _tokenId) external onlyOwnerOf(_tokenId) {
        _eatGrass(_tokenId);
    }

    function getLlamas(address _address) external view returns(uint[] memory) {

        uint256 count = 0;
        uint256[] memory myLlamas;

        for (uint i=0; i<llamas.length-1; i++) {
          if(ownerOf(i) == _address) {
            myLlamas[count] = i;
            count++;
          }
        }

        return myLlamas;
    }

    function getLlama(uint256 id) external view returns(string memory name, uint256 cooldownHunger, uint256 createdOn, uint256 fatherId, uint256 motherId, uint256 level) {
      name = llamas[id].name;
      cooldownHunger = llamas[id].cooldownHunger;
      createdOn = llamas[id].createdOn;
      fatherId = llamas[id].fatherId;
      motherId = llamas[id].motherId;
      level = llamas[id].level;

      return(name, cooldownHunger, createdOn, fatherId, motherId, level);
    }

}

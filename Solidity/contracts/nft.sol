pragma solidity ^0.6.12;

import './erc721.sol';
import './safemath.sol';

contract NFT is ERC721 {

    using SafeMath for uint256;
    using SafeMath16 for uint16;

    mapping (uint256 => address) internal _nftowner;
    mapping (address => uint256) internal _nftbalance;
    mapping (uint256 => address) internal _nftapprovals;

    modifier onlyOwnerOf(uint _tokenId) {
        require(_nftowner[_tokenId] == msg.sender);
        _;
    }

    function _transfer(address _from, address _to, uint256 _tokenId) private {
        _nftowner[_tokenId] = _to;
        _nftbalance[_from] = _nftbalance[_from].sub(1);
        _nftbalance[_to] = _nftbalance[_to].add(1);
        emit Transfer(_from, _to, _tokenId);
    }

    function balanceOf(address _owner) external view returns (uint256) {
        return(_nftbalance[_owner]);
    }

    function ownerOf(uint256 _tokenId) external view returns (address) {
        return(_nftowner[_tokenId]);
    }

    function transferFrom(address _from, address _to, uint256 _tokenId) external payable {
        require (_nftowner[_tokenId] == msg.sender || _nftapprovals[_tokenId] == msg.sender);
        _transfer(_from, _to, _tokenId);
    }

    function approve(address _approved, uint256 _tokenId) external payable onlyOwnerOf(_tokenId) {
      _nftapprovals[_tokenId] = _approved;
      emit Approval(msg.sender, _approved, _tokenId);
    }

}

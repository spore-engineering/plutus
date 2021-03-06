// SPDX-License-Identifier: MIT
pragma solidity ^0.6.8;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract PlutusOptionPosition is ERC721, Ownable {

  struct Position {
    uint256 cost;
    uint256 value;
  }

  using Counters for Counters.Counter;
  Counters.Counter private _tokenIds;

  mapping (uint256 => Position) private _Positions;

  constructor() public ERC721("Plutus Option Position", "POP") { }

  function mint(address payee, uint256 value, uint256 cost) public onlyOwner returns (uint256) {
    _tokenIds.increment();

    uint256 nextPopId = _tokenIds.current();

    _mint(payee, nextPopId);
    _setPosition(nextPopId, cost, value);

    return nextPopId;
  }

  function checkPosition(uint256 tokenId) public view returns (uint256, uint256) {
    require(_exists(tokenId), "ERC721Metadata: URI set of nonexistent token");
    // todo better to do?? -> Position memory position = _Positions[tokenId];
    return (_Positions[tokenId].value, _Positions[tokenId].cost);
  }

  function _setPosition(uint256 tokenId, uint256 _cost, uint256 _value) private {
    require(_exists(tokenId), "ERC721Metadata: URI set of nonexistent token");
    _Positions[tokenId] = Position(_cost, _value);
  }

}
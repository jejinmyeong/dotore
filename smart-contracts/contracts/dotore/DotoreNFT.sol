//SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "../token/ERC20/ERC20.sol";
import "../token/ERC721/ERC721.sol";
import "../utils/Counters.sol";

contract DotoreNFT is ERC721 {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    constructor() ERC721("Dotore NFT", "Acorn") {}

    struct Item {
        string title;
        string description;
        string tokenURI;
        bool isFirst;
    }

    mapping(uint256 => Item) public Items;

    function createToken(string memory title, string memory description, string memory tokenURI, bool isFirst) public returns (uint256) {
        _tokenIds.increment();
        uint256 newItemId = _tokenIds.current();

        _mint(msg.sender, newItemId);
        Items[newItemId] = Item(title, description, tokenURI, isFirst);

        return newItemId;
    }
}
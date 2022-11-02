//SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "../access/Ownable.sol";
import "../token/ERC20/ERC20.sol";
import "../token/ERC721/ERC721.sol";

contract DotoreSaleFactory is Ownable {
    address public admin;
    address [] public sales;

    event CreateNewSale (
        address indexed _saleContract,
        address indexed _owner,
        uint256 _workId
    );

    constructor() {
        admin = msg.sender;
    }

    function createSale(
        uint256 itemId,
        uint256 purchasePrice,
        address nftAddress

    ) public returns (address) {
        DotoreSale newSale = new DotoreSale(
            admin,
            msg.sender,
            itemId,
            purchasePrice,
            nftAddress
        );
        address _address = address(newSale);
        sales.push(_address);

        emit CreateNewSale(_address, msg.sender, itemId);
        return _address;
    }
}

contract DotoreSale {
    address public seller;
    address public buyer;
    address admin;
    uint256 public purchasePrice;
    uint256 public tokenId;
    address public nftAddress;
    bool public ended;

    IERC721 public erc721Contract;

    event SaleEnded(address buyer, uint256 purchasePrice);

    constructor(
        address _admin,
        address _seller,
        uint256 _tokenId,
        uint256 _purchasePrice,
        address _nftAddress
    ) {
        tokenId = _tokenId;
        purchasePrice = _purchasePrice;
        seller = _seller;
        admin = _admin;
        nftAddress = _nftAddress;
        ended = false;
        erc721Contract = IERC721(_nftAddress);
    }

    function purchase() public onlyNotSeller onlyBeforeEnd {
        payable(seller).transfer(purchasePrice);

        _transferNFT(address(this), msg.sender);

        _end();

        buyer = msg.sender;

        emit SaleEnded(buyer, purchasePrice);
    }

    function getSaleInfo() public view returns(
        uint256, uint256, address
    ) {
        return ( purchasePrice, tokenId, nftAddress );
    }

    function cancelSale() public onlyUserPermissioned {
        _transferNFT(address(this), seller);

        _end();
    }

    function _end() internal {
        ended = true;
    }

    function _transferNFT(address from, address to) public {
        erc721Contract.transferFrom(from, to, tokenId);
    }

    modifier onlySeller() {
        require(msg.sender == seller, "Error: You're Not Seller");
        _;
    }

    modifier onlyNotSeller() {
        require(msg.sender != seller, "Error: Seller Can't call this function");
        _;
    }

    modifier onlyBeforeEnd() {
        require(ended == false, "Error: Already Ended Sale");
        _;
    }

    modifier onlyAfterEnd() {
        require(ended == true, "Error: Not Ended Sale");
        _;
    }

    modifier onlyUserPermissioned() {
        require(msg.sender == seller || msg.sender == admin, "Error: You Don't Have Permission");
        _;
    }

}
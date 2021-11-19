//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract EinstienNFT is ERC721, Ownable {
    // Mapping to store token URIs
    mapping(uint256 => string) private _tokenURIs;

    // Base URI of Einstien NFTs
    string private _EbaseURI;

    // State variable for storing the latest minted toke id
    uint256 public currentTokenId;

    constructor() ERC721("Smart Dogs Society", "Einstein") {
        _EbaseURI = "https://gateway.pinata.cloud/ipfs/";
        currentTokenId = 0;
    }

    function baseURI() public view returns (string memory) {
        return _EbaseURI;
    }

    function setBaseURI(string memory uri) public onlyOwner {
        _EbaseURI = uri;
    }

    function tokenURI(uint256 tokenId)
        public
        view
        virtual
        override
        returns (string memory)
    {
        require(_exists(tokenId), "ERC721: URI query for nonexistent token");

        string memory _tokenURI = _tokenURIs[tokenId];
        string memory base = baseURI();

        // If there is no base URI, return the token URI.
        if (bytes(base).length == 0) {
            return _tokenURI;
        }
        // If both are set, concatenate the baseURI and tokenURI (via abi.encodePacked).
        if (bytes(_tokenURI).length > 0) {
            return string(abi.encodePacked(base, _tokenURI));
        }

        return super.tokenURI(tokenId);
    }

    // Special function for setting the URI of special Einstien NFTs
    // @notice This is critical function, should be used carefully
    function setURI(uint256 tokenId, string memory uri) public onlyOwner {
        _tokenURIs[tokenId] = uri;
    }

    function setBatchURI(uint256[] memory ids, string memory _baseURI)
        public
        virtual
        onlyOwner
    {
        require(ids.length > 0, "Invalid ids");
        for (uint256 i = 0; i < ids.length; i++) {
            string memory _uri = string(
                abi.encodePacked(
                    _baseURI,
                    "/",
                    Strings.toString(ids[i]),
                    ".json"
                )
            );
            _tokenURIs[ids[i]] = _uri;
        }
    }

    function mint(address account, string memory uri) public onlyOwner {
        // Check if the complete range is sold
        uint256 tokenId = getNextTokenID();

        _mint(account, tokenId);
        setURI(tokenId, uri);
        _incrementTokenId();
    }

    function mintBatch(
        address account,
        uint256 tokenCount,
        string memory cid
    ) public onlyOwner {
        uint256[] memory ids = new uint256[](tokenCount);
        for (uint256 i = 0; i < tokenCount; i++) {
            uint256 tokenId = getNextTokenID();
            _mint(account, tokenId);
            ids[i] = tokenId;
            _incrementTokenId();
        }
        setBatchURI(ids, cid);
    }

    /**
     * @dev Destroys `tokenId`.
     * The approval is cleared when the token is burned.
     *
     * Requirements:
     *
     * - `tokenId` must exist.
     *
     * Emits a {Transfer} event.
     */
    function burn(uint256 tokenId) public virtual onlyOwner {
        super._burn(tokenId);

        if (bytes(_tokenURIs[tokenId]).length != 0) {
            delete _tokenURIs[tokenId];
        }
    }

    /**
     * @dev Destroys `tokenId`.
     * The approval is cleared when the token is burned.
     *
     * Requirements:
     *
     * - `tokenId` must exist.
     *
     * Emits a {Transfer} event.
     */
    function burnBatch(uint256[] calldata tokenIds) public virtual onlyOwner {
        for (uint256 i = 0; i < tokenIds.length; i++) {
            super._burn(tokenIds[i]);

            if (bytes(_tokenURIs[tokenIds[i]]).length != 0) {
                delete _tokenURIs[tokenIds[i]];
            }
        }
    }

    /**
     * @dev Sets `_tokenURI` as the tokenURI of `tokenId`.
     *
     * Requirements:
     *
     * - `tokenId` must exist.
     */

    /// @notice Returns the chain id of the current blockchain.
    /// @dev This is used to workaround an issue with ganache returning different values from the on-chain chainid() function and
    ///  the eth_chainId RPC method. See https://github.com/protocol/nft-website/issues/121 for context.
    function getChainID() external view returns (uint256) {
        uint256 id;
        assembly {
            id := chainid()
        }
        return id;
    }

    function getNextTokenID() public view returns (uint256) {
        return currentTokenId + 1;
    }

    function _incrementTokenId() private {
        currentTokenId++;
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        virtual
        override(ERC721)
        returns (bool)
    {
        return ERC721.supportsInterface(interfaceId);
    }
}

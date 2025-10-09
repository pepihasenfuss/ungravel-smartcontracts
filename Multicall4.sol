// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

/// @title Multicall4
/// @notice Aggregate results from multiple function calls
/// @dev Multicall & Multicall2 backwards-compatible
/// @dev Aggregate methods are marked `payable` to save 24 gas per call
/// @author Michael Elliot <mike@makerdao.com>
/// @author Joshua Levine <joshua@makerdao.com>
/// @author Nick Johnson <arachnid@notdot.net>
/// @author Andreas Bigger <andreas@nascent.xyz>
/// @author Matt Solomon <matt@mattsolomon.dev>

interface IMulGWP {                                                              // Abstract and access to GWP, Group Wallet Proxy contract, the Voting and Multi-Sig-contract of each group, a proxy, belonging to the GroupWallet Master
  function getIsOwner(address _owner)      external view returns (bool);
  function getOwners()                     external view returns (address[] memory);
  function getTransactionsCount()          external view returns (uint);
  function getTransactionRecord(uint _tNb) external view returns (uint256);
  function getGWF()                        external view returns (address);
  function getAllTransactions()            external view returns (uint256[] memory transArr);
  function getMasterCopy()                                                    external view returns (address);
  function nameAuctionBidBucketLabel(bytes32 labelhash, address deedContract) external;
  function getIntention()                  external   view returns (AbsIntentions);
}

interface IMulENS {                                                              // ENS Registry grants access to domain names and domain name properties
  event NewOwner(bytes32 indexed node, bytes32 indexed label, address owner);
  event Transfer(bytes32 indexed node, address owner);
  event NewResolver(bytes32 indexed node, address resolver);
  event NewTTL(bytes32 indexed node, uint64 ttl);
  event ApprovalForAll(address indexed owner, address indexed operator, bool approved);
  function setSubnodeRecord(bytes32 node, bytes32 label, address sub_owner, address sub_resolver, uint64 sub_ttl) external;
  function setOwner(bytes32 node, address set_owner) external;
  function owner(bytes32 node) external view returns (address);
  function recordExists(bytes32 node) external view returns (bool);
}

abstract contract MulToken {
  function balanceOf(address tokenOwner) external view virtual returns (uint thebalance);
  function name() external view virtual returns (string memory);
  function symbol() external view virtual returns (string memory);
  function owner() external view virtual returns (address);
  function decimals() external view virtual returns (uint8);
  function transfer(address toReceiver, uint amount) external virtual;
  function withdraw(uint256 amount) external virtual;
}

abstract contract USDCToken {
  function balanceOf(address tokenOwner) external view virtual returns (uint thebalance);
  function name() external view virtual returns (string memory);
  function symbol() external view virtual returns (string memory);
  function owner() external view virtual returns (address);
  function decimals() external view virtual returns (uint8);
  function withdraw(uint256 amount) external virtual;
  function transfer(address to, uint256 value) external virtual returns (bool);
}
abstract contract WETHToken {
  function balanceOf(address tokenOwner) external view virtual returns (uint thebalance);
  function name() external view virtual returns (string memory);
  function symbol() external view virtual returns (string memory);
  function owner() external view virtual returns (address);
  function decimals() external view virtual returns (uint8);
  function withdraw(uint256 amount) external virtual;
  function transfer(address to, uint256 value) external virtual returns (bool);
}

contract MulBaseR {                                                             // BaseRegistrar belongs to the ENS - Ethereum Naming Service
  event NameMigrated(uint256 indexed id, address indexed owner, uint expires);
  event NameRegistered(uint256 indexed id, address indexed owner, uint expires);
  event NameRenewed(uint256 indexed id, uint expires);
  bytes32 public baseNode;                                                      // The namehash of the TLD, this registrar owns (eg, .eth, or .arb)
  IMulENS public ens;
}

abstract contract MultiResolver {
  mapping(bytes32=>bytes) hashes;
  event TextChanged(bytes32 indexed node, string indexed indexedKey, string key);
  function text(bytes32 node, string calldata key) external virtual view returns (string memory);
  function setApprovalForAll(address operator, bool approved) virtual external;
  function setText(bytes32 node, string calldata key, string calldata value) external virtual;
  function addr(bytes32 node) external virtual view returns (address);
}

interface MulDefaultResolver {                                                 // ENS Resolver provides the address and properties of domain names, s.a. "your-company.base", it resolves domain names to EVM addresses
  event AddrChanged(bytes32 indexed node, address a);
  event AddressChanged(bytes32 indexed node, uint coinType, bytes newAddress);
  event NameChanged(bytes32 indexed node, string name);
  event ABIChanged(bytes32 indexed node, uint256 indexed contentType);
  event PubkeyChanged(bytes32 indexed node, bytes32 x, bytes32 y);
  event TextChanged(bytes32 indexed node, string indexed indexedKey, string key);
  event ContenthashChanged(bytes32 indexed node, bytes hash);

  function ABI(bytes32 node, uint256 contentTypes) external view returns (uint256, bytes memory);
  function addr(bytes32 node) external view returns (address payable);
  function text(bytes32 node, string calldata key) external view returns (string memory);
  function name(bytes32 node) external view returns (string memory);
  function contenthash(bytes32 node) external view returns (bytes memory);

  function setABI(bytes32 node, uint256 contentType, bytes calldata data) external;
  function setAddr(bytes32 node, address r_addr) external;
  function setAddr(bytes32 node, uint coinType, bytes calldata a) external;
  function setName(bytes32 node, string calldata _name) external;
  function setText(bytes32 node, string calldata key, string calldata value) external;
  function setAuthorisation(bytes32 node, address target, bool isAuthorised) external;
}
abstract contract AbsIntentions {
  function getGWF() public virtual view returns (MulGwf);
  function saveLetterOfIntent(address target, uint nbOfShares) public virtual payable;
}
abstract contract MulRr {                                                     // Reverse Resolver and Reverse Default Resolver give access to the domain name, if only an address is given
  MulDefaultResolver public defaultResolver;
  IMulENS   public immutable ens;
  function node(address addr) external virtual pure returns (bytes32);
  function setName(string memory name) external virtual returns (bytes32);
  function name(bytes32 node) external virtual view returns (string memory);
}
abstract contract NmWrapper {
  function setSubnodeRecord(bytes32 parentNode,string memory label,address owner,address resolver,uint64 ttl,uint32 fuses,uint64 expiry) external virtual returns (bytes32 node);
  function setSubnodeOwner(bytes32 node,string calldata label,address newOwner,uint32 fuses,uint64 expiry) external virtual returns (bytes32);
  function ownerOf(uint256 id) external virtual view returns (address);
  function setApprovalForAll(address operator,bool approved) external virtual;
}
abstract contract MulGwf {                                                    // Group Wallet Factory, GWF, main Ungravel entry point coordinating Ungravel Groups and all activities, deploying ProxyGroupWallet, GWP, and ProxyToken, aka TokenProxy
  MultiResolver                       public  resolverContract;
  IMulENS                             public  ens;
  MulBaseR                            public  base;
  MulRr                               public  reverseContract;
  NmWrapper                           public  ensNameWrapper;

  function getGWProxy(bytes32 _dHash) external view virtual returns (address);
  function getIsOwner(bytes32 _dHash,address _owner) external view virtual returns (bool);
  function getOwner(bytes32 _domainHash) external view virtual returns (address);
  function domainReport(string calldata _dom,uint command) external payable virtual returns (uint256 report, address gwpc, address ptc, address gwfc, bytes memory structure);
  function getGWF() external view virtual returns (address);
  function getProxyToken(bytes32 _domainHash) public view virtual returns (address);
  function getOwners(bytes32 _dHash) external view virtual returns (address[] memory);
}

contract Multicall4 {
    struct Call3Value {
        address target;
        bool allowFailure;
        uint256 value;
        bytes callData;
    }

    struct Result {
        bool success;
        bytes returnData;
    }

    address   public masterCopy; // deployer, owner of this contract
    MulGwf    public GWF;        // GroupWalletFactory Ungravel.com
    USDCToken public USDC;       // USDC token contract
    WETHToken public WETH;       // WETH token contract

    event Deployment(address owner, address theContract);
    event DeploymentMulticall4(address theContract, bytes32 dhash);
    event Deposit(address from, uint256 value);

    uint256 private _guardCounter  = 1;

    modifier nonReentrant() {
      _guardCounter += 1;
      uint256 localCounter = _guardCounter;
      _;
      require(localCounter == _guardCounter,"No re-entrance!");
    }
    modifier onlyGWPorMember() {
      address send = msg.sender;
      bytes32 hash = __nHashFromSender(send); // ************************ node hash === reverse record entry *****
    
      require(__isGroupMember(send) || (hash!=0x0 && __isGwpNameSpace(hash,send) && __isGwpFromSender(send)),"onlyGWPorMem!");
      _;
    }

    function strlen(string memory s) public pure returns (uint) {
        uint len;
        uint i = 0;
        uint bytelength = (bytes(s).length % 32);
        for(len = 0; ((i<bytelength)&&(len<=31)); len++) {
            bytes1 b = bytes(s)[i];
            if(b < 0x80) {
                i += 1;
            } else if (b < 0xE0) {
                i += 2;
            } else if (b < 0xF0) {
                i += 3;
            } else if (b < 0xF8) {
                i += 4;
            } else if (b < 0xFC) {
                i += 5;
            } else {
                i += 6;
            }
        }
        return len;
    }
    function memcpy(uint dest, uint src, uint len) private pure {
        // Copy word-length chunks while possible
        for (; len >= 32; len -= 32) {
            // solium-disable-next-line security/no-inline-assembly
            assembly {
                mstore(dest, mload(src))
            }
            dest += 32;
            src += 32;
        }
        
        if (len==0) return;

        // Copy remaining bytes
        uint mask = 256 ** (32 - len) - 1;
        // solium-disable-next-line security/no-inline-assembly
        assembly {
            let srcpart := and(mload(src), not(mask))
            let destpart := and(mload(dest), mask)
            mstore(dest, or(destpart, srcpart))
        }
    }
    function substring(bytes memory self, uint offset, uint len) public pure returns(bytes memory) {
        require(offset + len <= self.length,"s");

        bytes memory ret = new bytes(len);
        uint dest;
        uint src;

        // solium-disable-next-line security/no-inline-assembly
        assembly {
            dest := add(ret, 32)
            src  := add(add(self, 32), offset)
        }
        memcpy(dest, src, len);

        return ret;
    }
    function delArr(string memory s) private pure returns (uint8[] memory) {
        uint8[] memory delimiter = new uint8[](2);
        
        uint len;
        uint nb = 0;
        uint i = 0;
        uint bytelength = (bytes(s).length % 32);

        if (bytelength==0) return delimiter;

        for(len = 0; ((i < bytelength) && (i<31)); len++) {
            bytes1 b = bytes(s)[i];
            
            if ((b==0x2e)&&(nb<2)) {
              delimiter[nb] = uint8(i);
              nb++;
            }
              
            if(b < 0x80) {
                i += 1;
            } else if (b < 0xE0) {
                i += 2;
            } else if (b < 0xF0) {
                i += 3;
            } else if (b < 0xF8) {
                i += 4;
            } else if (b < 0xFC) {
                i += 5;
            } else {
                i += 6;
            }
        }

        return delimiter;
    }
    function stringMemoryTobytes32(string memory _data) private pure returns(bytes32 a) {
      // solium-disable-next-line security/no-inline-assembly
      assembly {
          a := mload(add(_data, 32))
      }
    }
    function bytes32ToStr(bytes32 _b) public pure returns (string memory) {
      bytes memory bArr = new bytes(32);
      uint256 i;
      
      uint off = 0;
      do { 
        if (_b[i] != 0) bArr[i] = _b[i];
        else off = i;
        i++;
      } while(i<32&&off==0);
      
      
      bytes memory rArr = new bytes(off);
      
      i=0;
      do
       { 
        if (bArr[i] != 0) rArr[i] = bArr[i];
        off--;
        i++;
      } while(i<32&&off>0);
      
      return string(rArr); 
    }
    function bytes32ToBytes32WithLen(bytes32 _b) public pure returns (bytes32) {
      return bytes32( uint256(uint256(_b) & 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff00) + uint256(uint256(strlen(bytes32ToStr(_b)))&0xff) );
    }
    function toLowerCaseBytes32(bytes32 _in) private pure returns (bytes32 _out) {
      uint256 K_TMASK = 0xf000000000000000000000000000000000000000000000000000000000000000;
      if ( uint256(uint256(uint256(_in) & K_TMASK) >> 252) <= 5 ) return bytes32(uint256(uint256(_in) | 0x2000000000000000000000000000000000000000000000000000000000000000 ));
      return _in;
    }
    function mb32(bytes memory _data) private pure returns(bytes32 a) {
      // solium-disable-next-line security/no-inline-assembly
      assembly {
          a := mload(add(_data, 32))
      }
    }

    /// @notice Aggregate calls with a msg value
    /// @notice Reverts if msg.value is less than the sum of the call values
    /// @param calls An array of Call3Value structs
    /// @return returnData An array of Result structs
    function aggregate3Value(Call3Value[] calldata calls) public payable nonReentrant onlyGWPorMember returns (Result[] memory returnData) {
        uint256 valAccumulator;
        uint256 length = calls.length;
        returnData = new Result[](length);
        Call3Value calldata calli;

        require(strlen(reverseDName(IMulGWP(msg.sender)))!=0,"Multicall4: rev err!");
        bytes32 nodeHashGroup = nodeHashOfMember(reverseDName(IMulGWP(msg.sender)));
        require(nodeHashGroup!=0x0,"Multicall4: node err!");
        address _gwp = address(getGWP(nodeHashGroup));
        require(_gwp!=address(0x0)&&domHash(IMulGWP(_gwp))==nodeHashGroup,"Multicall4: dom err!");

        for (uint256 i = 0; i < length;) {
            Result memory result = returnData[i];
            calli = calls[i];
            uint256 val = calli.value;
            // Humanity will be a Type V Kardashev Civilization before this overflows - andreas
            // ~ 10^25 Wei in existence << ~ 10^76 size uint fits in a uint256
            unchecked { valAccumulator += val; }
            (result.success, result.returnData) = calli.target.call{value: val}(calli.callData);
            assembly {
                // Revert if the call fails and failure is not allowed
                // `allowFailure := calldataload(add(calli, 0x20))` and `success := mload(result)`
                if iszero(or(calldataload(add(calli, 0x20)), mload(result))) {
                    // set "Error(string)" signature: bytes32(bytes4(keccak256("Error(string)")))
                    mstore(0x00, 0x08c379a000000000000000000000000000000000000000000000000000000000)
                    // set data offset
                    mstore(0x04, 0x0000000000000000000000000000000000000000000000000000000000000020)
                    // set length of revert string
                    mstore(0x24, 0x0000000000000000000000000000000000000000000000000000000000000017)
                    // set revert string: bytes32(abi.encodePacked("Multicall4: call failed"))
                    mstore(0x44, 0x4d756c746963616c6c333a2063616c6c206661696c6564000000000000000000)
                    revert(0x00, 0x84)
                }
            }
            unchecked { ++i; }
        }
        require(msg.value == valAccumulator, "Multicall4: value mismatch"); // Finally, make sure the msg.value = SUM(call[0...i].value)

        if (USDC.balanceOf(address(this))>0) {
          bool result = USDC.transfer(msg.sender,USDC.balanceOf(address(this)));
          require(result,"USDC balance!");
        }

        if (WETH.balanceOf(address(this))>0) {
          WETH.withdraw(WETH.balanceOf(address(this)));
          require(WETH.balanceOf(address(this))==0,"WETH balance!");
        }

        if (WETH.balanceOf(address(this))>0) {
          bool result = WETH.transfer(msg.sender,WETH.balanceOf(address(this)));
          require(result,"WETH2 balance!");
        }

        if (payable(this).balance>0) {
            (bool succ,bytes memory returnData2) = address(msg.sender).call{ value: payable(this).balance }("");
            require(succ,string(abi.encode(returnData2, returnData2.length)));
        }
    }

    /// @notice Returns the block hash for the given block number
    /// @param blockNumber The block number
    function getBlockHash(uint256 blockNumber) public view returns (bytes32 blockHash) {
        blockHash = blockhash(blockNumber);
    }

    /// @notice Returns the block gas limit
    function getCurrentBlockGasLimit() public view returns (uint256 gaslimit) {
        gaslimit = block.gaslimit;
    }

    /// @notice Returns the (ETH) balance of a given address
    function getEthBalance(address addr) public view returns (uint256 balance) {
        balance = addr.balance;
    }

    /// @notice Gets the base fee of the given block
    /// @notice Can revert if the BASEFEE opcode is not implemented by the given chain
    function getBasefee() public view returns (uint256 basefee) {
        basefee = block.basefee;
    }

    /// @notice Returns the chain id
    function getChainId() public view returns (uint256 chainid) {
        chainid = block.chainid;
    }


    // changes by pepihasenfuss.eth, required for ungravel.com / ChainScript 


    function isContract(address addr) internal view returns (bool) {
      uint size;
      assembly { size := extcodesize(addr) }
      return size > 0;
    }

    function chain_tld(uint chainId) public pure returns (string memory) {
      if (chainId==1)        return ".eth";
      if (chainId==10)       return ".op";
      if (chainId==56)       return ".bsc";
      if (chainId==100)      return ".gnosis";
      if (chainId==130)      return ".uni";
      if (chainId==137)      return ".matic";
      if (chainId==232)      return ".lens";
      if (chainId==324)      return ".zks";
      if (chainId==480)      return ".wc";
      if (chainId==1135)     return ".lisk";
      if (chainId==1868)     return ".son";
      if (chainId==8453)     return ".base";
      if (chainId==41455)    return ".az";
      if (chainId==42161)    return ".one";
      if (chainId==42220)    return ".celo";
      if (chainId==43114)    return ".ava";
      if (chainId==59144)    return ".linea";
      if (chainId==81457)    return ".blast";
      if (chainId==167000)   return ".tko";
      if (chainId==421614)   return ".arb";
      if (chainId==534352)   return ".scroll";
      if (chainId==7777777)  return ".zora";
      if (chainId==11155111) return ".sepeth";
      return "";
    }

    function chain_name(uint chainId) public pure returns (string memory) {
      if (chainId==1)        return "mainnet";
      if (chainId==10)       return "optmain";
      if (chainId==56)       return "bscmain";
      if (chainId==100)      return "gnosis";
      if (chainId==130)      return "unichain";
      if (chainId==137)      return "polygon";
      if (chainId==232)      return "lens";
      if (chainId==324)      return "zksync";
      if (chainId==480)      return "worldchain";
      if (chainId==1135)     return "lisk";
      if (chainId==1868)     return "soneium";
      if (chainId==8453)     return "base";
      if (chainId==41455)    return "alephzero";      
      if (chainId==42161)    return "arbmain";
      if (chainId==42220)    return "celo";
      if (chainId==43114)    return "avalanche";
      if (chainId==59144)    return "linea";
      if (chainId==81457)    return "blast";
      if (chainId==167000)   return "taiko";
      if (chainId==421614)   return "arbitrum";
      if (chainId==534352)   return "scroll";
      if (chainId==7777777)  return "zora";
      if (chainId==11155111) return "sepolia";
      return "";
    }

    function chainName() public view returns (string memory) {                    // name of current chain, s.a. "base", "mainnet"=ethereum, "arbmain"=arbitrum-one
      return chain_name(block.chainid);
    }

    function tld() public view returns (string memory) {                          // top-level-domain, such as ".base" | ".eth" | ".uni"
      return chain_tld(block.chainid);
    }

    function getGWF() public view returns (MulGwf) {                              // get GroupWallet Factory contract
      return GWF;
    }

    function rev() internal view returns (MulRr) {                                // reverse registrar contract, resolving addresses reversely to dnames
      return GWF.reverseContract();
    }

    function nodeHash(string memory dn) internal view returns (bytes32 hash) {    // get domain hash of "arbitrum.arb" | "base.base" | "mainnet.eth"
      return keccak256( abi.encodePacked( MulBaseR(getGWF().base()).baseNode(), keccak256( abi.encodePacked(dn) ) ) );
    }

    function nodeHashOfMember(string memory _dn) public view returns (bytes32) {  // domain name e.g. 'ethereum-foundation.eth'
      return keccak256(abi.encodePacked( MulBaseR(getGWF().base()).baseNode(),keccak256( substring( bytes(_dn), delArr(_dn)[0]+1, delArr(_dn)[1] - delArr(_dn)[0] -1 ) ) ));
    }

    function domHash(IMulGWP gw) internal view returns (bytes32) {                // provide domain name hash of domain name of the GWP - Group Wallet Proxy contract, s.a. hash("my-company.one")
      address gwfc = gw.getGWF();
      require(address(gwfc)!=address(0x0)&&address(getGWF())==gwfc,"gwfc");
      return bytes32(gw.getTransactionRecord(uint256(uint160(gwfc))));
    }

    function getGWP(bytes32 _dhash) internal view returns (IMulGWP) {             // get GroupWallet Proxy contract address of Group(_dhash)
      address gwp = getGWF().getGWProxy(_dhash);
      require(gwp!=address(0x0)&&isContract(gwp),"GW");
      return IMulGWP(gwp);
    }

    function reverseDName(IMulGWP _g) private view returns (string memory) {      // reverse the address to get the domain name, s.a. "vitalik.ens.eth"
      return string(rev().defaultResolver().name(rev().node(address(_g))));
    }

    /// @notice May receive ERC1155 to create subnodes for domains
    function onERC1155Received(address,address,uint256,uint256,bytes calldata) public pure returns (bytes4 r) { // 0xf23a6e61 callback selector
      return this.onERC1155Received.selector;
    }

    // avatar utilities for setting avatar pictures to resolver() contract
    function setAvatarPicture(bytes32 _dHash, MultiResolver resolver) public payable {     // default avatar url
      resolver.setText(_dHash,'avatar','https://www.ungravel.com/ung.png');
    }

    function setInlineSpaceAvatar(bytes32 _dHash, MultiResolver resolver) public payable { // inline avatar picture, astronaut
      resolver.setText(_dHash,'avatar','data:image/gif;base64,R0lGODdhIAAgANUAAAAAAAIFCgQIDgULEwcOGQcQGwgRHQoVJAwXKQwYKg8eMxMnRBQpRhYsTBcvURgvUhgxVRo1XB06ZB8+ayBAbyFDcyRJfiZLgihRiytWlCxYly1bnC9eojBgpTJjqzVptjdtvDhvvzpzxT570z9+2EB/2UGB3kOF5USH6UWJ7EeN9EiP9kmQ9////wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACH5BAkAAC4ALAAAAAAgACAAAAb/QIBwSCwaj8ikcslsOp/QqHT6PFA4H87kQB0GKqbViiU2VQJdjEq1YrtVGGpExXK32/WIFEJagSYRgYETICsjEFAFYSMERwQjKyaNTgcoKx0AAhdGHisnXJQoKh4GGycYAkQeKp9VJ4YGESMMRAOQJwZQGCkqEwENRRQqKXFRFysoFANDAxUpKxZTA4UqIx8eHyRsH8tTBqtk4aO5VAMCEB4jJyMeEALdUQIVIxkK7wTmChkjZ1AD4CtSiOCQgYOIZ3U6wGOi4c4dO2zuZHDSIEW4NsMysgmXghaTVXdCLFBAkuQCEQ8xLRkQhsyKCAOAAfglQIIYMiUWHknACyOELQWtCHxAMMdNClBJDIx487PVTABF2zBiksDBAwcODMREM8QA1qsIuogdS5ZJEAA7');
    }

    function setInlineUNGAvatar(bytes32 _dHash, MultiResolver resolver) public payable {   // inline avatar picture UNG logo
      resolver.setText(_dHash,'avatar','data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABYAAAAWCAMAAADzapwJAAAACXBIWXMAAAsTAAALEwEAmpwYAAACBFBMVEUfV3IgWXUgWnYgXXsgYIAgYX4hXHkhXXshXXwhXnwhX34hYH4hYH8hYIAhYYAhYYEhYoAhZIMiXnwiX30iX34iX4AiYH4iYH8iYX8iYYAiYYEiYoAiYoEiYoIiY4IiY4MiY4QiZIMiZYQiZYYjZYUjZocjZ4kjaIkjaYojaowja44kaIkkaYkka40ka44kbI4kbI8kb5EkcJUla44lbI4lbpIlcJMlcJQlcZQlcZUlcZYlcpYlc5gmbZAmbpEmbpImb5ImcJUmcZQmcZUmcpYmc5cncJQncZUndJkndZondZsndZwndpwnd5wneJ4neaApfqYpgakqfqYqgKgqhK4rfqYrgKorgakrhrArh7Esi7cti7gtjbotkL0ukL8ukcAuksEulMMvkcAvk8IvlMMvlMQvlsUwlMMwlcQwmMgxlsUxmcoxmswxm8wxnM4ync4yntAyn9EyoNIyodQyo9YzodQzotQzotUzpts0otY0o9k0pdo0p9s0qd40rOE1qd01qd41quA1rOE1reQ2qeA2quA2q+E2rOM2reM2reQ2ruU2r+U2r+Y2r+c2sOc2seg3reQ3ruU3r+Y3sOc3sOg3sek3sus3s+s3s+w4seo4suo4sus4s+s4s+w4tOw4tO04te44t/I5te05te45te85t/A5t/I5uPI5uvU6ufM6ufQ6uvVRQ1/bAAABJElEQVQY02MQZeWVxAQMrLxYhXlZ+LAJS2IFuITFgYS4OARDCAlxcXEGWQFxKVlZaUl5OQlJaVkZSUkuHiVVFYZ0DzbT+AxD3dQ0F3aDuAR9TrWQvNIChkXhjH6Tl/pYzV1dpuLUN81dNWdhe3k3w8xgJt/OOV6Wk5fMj7aqm+QQuLjXX9EcJOwDEp4yb057TG23c9LKYhnHCIaZQQyeHXO9zWfXJ07v6W82Sl5VJB7ZzTAjiids6ixX87kN1rlLF3SYRS5vMtMPZVjWldeyskTZZkm7lnPjikluBhUrK2OzGLJrJrRmWjJbVOVrcgRUF9oJmae0TWxjUNCwNRbkEpfTUecXl9FWk5Pgljex12PgEREWA3kZREiAWeIiIiIkhiA1hAG43mMnWbA/YQAAAABJRU5ErkJggg==');
    }

    // UUNS security and authentication methods

    function __dNameFromSender(address _sender) public view returns (string memory) {      // domain name of msg.sender from reverse registry
      return string(MulDefaultResolver(rev().defaultResolver()).name( rev().node(_sender) ));
    }
    function __nHashFromSender(address _sender) public view returns (bytes32) {            // node hash of msg.sender from reverse registry
      return rev().node(_sender);
    }
    function __hashFromGWP(IMulGWP _gwp) public view returns (bytes32) {                   // domain hash from GWP contract
      if (address(_gwp)==address(0))            return bytes32(0x0);
      if (!isContract(address(_gwp)))           return bytes32(0x0);
      if (address(_gwp.getGWF())!=address(GWF)) return bytes32(0x0);
      
      require(address(_gwp)!=address(0)&&isContract(address(_gwp)),"__hashFromGWP!");
      require(address(_gwp.getGWF())==address(GWF),                "__hashFromGWP2");
      return  bytes32(_gwp.getTransactionRecord(uint256(uint160(address(GWF)))));
    }
    function __ownerFromHash(bytes32 _dHash) public view returns (address) {               // owner address from domain hash
      require(_dHash!=0,"__ownerFromHash");
      return address(GWF.getOwner(_dHash));
    }
    function __gwpFromHash(bytes32 _dHash) public view returns (IMulGWP) {                 // GWP contract address from domain hash
      require(_dHash!=0,"__gwpFromHash");
      return IMulGWP(GWF.getOwner(_dHash));
    }
    function __tokenFromHash(bytes32 _dHash) public view returns (MulToken) {              // TP=TokenProxy contract address from domain hash
      require(_dHash!=0,"__tokenFromHash");
      return MulToken(GWF.getProxyToken(_dHash));
    }
    function __tokenContract(IMulGWP _gwp) public view returns (MulToken) {                // TokenProxy contract from GWP contract
      return __tokenFromHash( __hashFromGWP(_gwp) );
    }
    function __ownersFromHash(bytes32 _dHash) public view returns (address[] memory) {     // owners (ARRAY) from domain hash of GWP, using GWF
      require(_dHash!=0,"__ownersFromHash");
      return GWF.getOwners(_dHash);
    }
    function __isOwnerFromHash(bytes32 _dHash,address _owner) public view returns (bool) { // is owner of domain hash
      require(_dHash!=0,"__isOwnerFromHash");
      require(_owner!=address(0),"__isOwnerFromHash2");
      return (address(__gwpFromHash(_dHash))==_owner && GWF.getGWProxy(_dHash)==_owner);
    }
    function __getDomainHash(string memory _d) public view returns (bytes32) {             // domain hash of domain name, s.a. "group.lisk"
      if (strlen(_d)==0)        return bytes32(0x0);
      if (delArr(_d).length!=2) return bytes32(0x0);
      if (delArr(_d)[0]!=0)     return bytes32(0x0);
      if (delArr(_d)[1]!=0)     return bytes32(0x0);

      require(strlen(_d)!=0,"__getDomainHash");
      require(delArr(_d).length==2,"__getDomainHash2");
      require(delArr(_d)[0]==0,"__getDomainHash3");
      require(delArr(_d)[1]==0,"__getDomainHash4");
      return keccak256(abi.encodePacked(MulBaseR(GWF.base()).baseNode(),keccak256(bytes(_d))));
    }
    function __isGwpFromSender(address _sender) public view returns (bool) {               // is sender a GWP contract, belongs to UUNS
      require(_sender!=address(0), "__isGwp");

      bytes32 node = __nHashFromSender(_sender);
      bytes32 hash = __hashFromGWP(IMulGWP(_sender));

      return ( _sender!=address(0) && isContract(_sender) && node!=0x0 && MulBaseR(GWF.base()).ens().recordExists(node) && hash!=0x0 && (_sender==address(__gwpFromHash(hash))) && (GWF.getGWProxy(hash)==_sender) );
    }
    function __isNameSpace(bytes32 _dHash) public view returns (bool) {                    // _dHash belongs to EVM Name Space, e.g. ENS Name Space on Ethereum
      require(_dHash!=0,"__isNameSpace");
      return (_dHash!=0x0 && MulBaseR(GWF.base()).ens().recordExists(_dHash));
    }
    function __ensOwner(bytes32 _dHash) public view returns (address) {                    // provide resolved group owner of domain name hash s.a. "ethereum.lisk"
      if (_dHash==0) return address(0); 
      require(_dHash!=0,"__ensOwner");
      return MultiResolver(GWF.resolverContract()).addr(_dHash);                           // return resolvedAddress() from group domain name hash
    }
    function __isGwpNameSpace(bytes32 _dHash,address _sender) public view returns (bool) { // _dHash / _sender belong to EVM and Ungravel Unified Name Space, UUNS
      require(_dHash!=0,          "__isGwpNameSpace");
      require(_sender!=address(0),"__isGwpNameSpace2");
      require(isContract(_sender),"__isGwpNameSpace3");                                    // GWP or member of group
      return (__isNameSpace(_dHash) && __ensOwner(_dHash)==_sender);                       // and msg.sender is GWP or group member and is belonging to UUNS
    }
    function __ungravelDomain() public view returns (string memory) {                      // "ungravel.base" | "ungravel.lisk"
      bytes32 tld32 = mb32(bytes(tld()));                                                  // tld ".base" | ".eth" | ".lisk"
      return string(abi.encodePacked('ungravel',bytes32ToStr(tld32)));                     // domain name e.g. "my-group.base" | "rose-ill.arb"
    }
    function __isUngravelWaddr(address _sender) public view returns (bool) {               // msg.sender UUNS, is an Ungravel working address
      // __domName() == "deployer.ungravel.lisk". || "ppa.ungravel.lisk" || "acc1.ungravel.base"
      
      uint len = (strlen(__dNameFromSender(_sender)) % 32);
      bytes32 domain32   = stringMemoryTobytes32(__dNameFromSender(_sender));              // e.g. 0x6465706C6F7965722E756E67726176656C2E6C69736B00000000000000000000 32 bytes = "deployer.ungravel.lisk"
      bytes32 ungravel32 = stringMemoryTobytes32(__ungravelDomain());                      // e.g. "ungravel.lisk" | "ungravel.base"

      uint i;
      for(i=0; i<len; i++) {
        if (uint256(domain32) & uint256(ungravel32) == uint256(ungravel32)) return true;
        ungravel32 = bytes32(uint256(uint256(ungravel32)>>8));
      }
      return false;
    }
    function __groupNameFromSender(address _sender) public view returns (string memory) {  // returns "somegroup" from "harry.somegroup.base"
      require(_sender!=address(0),"__groupNameFromSender");
      string memory dn = __dNameFromSender(_sender);

      uint nb0 = delArr(dn)[0]; // first  delimiter
      uint nb1 = delArr(dn)[1]; // second delimiter

      if ((nb0==0)&&(nb1==0)) return dn;
      if (nb0==0)             return dn;

      if (nb1>nb0) return string( substring( bytes(dn), nb0+1, nb1 - nb0-1 ) );

      return string( substring( bytes(dn), 0, nb0-1 ) );
    }
    function __isMemberOfGroup(IMulGWP _gwp,address _member) public view returns (bool) {  // member address is a member of the Ungravel GWP, thus UUNS
      require(_member!=address(0),"__isMemberOfGroup");
      require(address(_gwp)!=address(0),"__isMemberOfGroup2");
      return _gwp.getIsOwner(_member);
    }
    function __isGroupMember(address _sender) public view returns (bool) {                 // _sender is member of GWP
      require(_sender!=address(0),"__isGM");
      string memory dn = __groupNameFromSender(_sender);                                   // "somegroup" from "harry.somegroup.base"
      if (strlen(dn)==0) return false;

      bytes32 hash = __getDomainHash(dn);                                                  // domain hash of somegroup.base | somegroup.lisk

      IMulGWP gwp = __gwpFromHash(hash);                                                   // GWP of sender
      return ((strlen(dn)!=0) && hash!=0x0 && __isNameSpace(hash) && address(gwp)!=address(0) && __isGwpFromSender(address(gwp)) && __ensOwner(hash)==address(gwp) && __isMemberOfGroup(gwp,_sender)); // is UUNS
    }
    function __isGwpOrMember(address _sender) public view returns (bool) {                 // GWP or member of group, is UUNS
      return ( _sender!=address(0) && (__isGwpFromSender(_sender) || __isGroupMember(_sender)) );
    }
    function __resolveToAddress(string memory _d) public view returns (address) {          // resolve domain name to address
      return __ensOwner(__getDomainHash(_d));
    }
    function __subdomainHash(string memory dn) public view returns (bytes32) {             // hash of subdomain domain name, s.a. "pepsi.ungravel.lisk"
      
      bytes32 hash = keccak256( abi.encodePacked( MulBaseR(getGWF().base()).baseNode(), 
                        keccak256( substring( bytes(dn), delArr(dn)[0]+1, delArr(dn)[1] - delArr(dn)[0] -1 ) ) ) ); // domain e.g. 'ethereum-foundation'

      return keccak256( abi.encodePacked( hash, keccak256( substring( bytes(dn), 0, delArr(dn)[0] ) ) ) );          // label  e.g. 'vitalik'
    }
    function __resolveSubDomain(string memory _d) public view returns (address) {          // resolve subdomain name to address, e.g. "pepsi.ungravel.lisk"
      return __ensOwner(__subdomainHash(_d));
    }
    function __validAddress(address ct) private pure returns (bool) {                      // checks for 0x0 addresses
      return ct!=address(0);
    }
    function __validIntentionsContract(address a) public view returns (AbsIntentions intent) { // get Intentions contract address from GWP
      intent = IMulGWP(a).getIntention();
      require(__validAddress(a)&&__validAddress(address(intent)),"U");                 // _validAddress
      return intent;
    }
    function __callerExists(address _caller) public view returns (bool) {                  // check reverse name node of sender address, e.g. "silvias-bakery.eth"
      return MulRr(GWF.reverseContract()).ens().recordExists(MulRr(GWF.reverseContract()).node(_caller)); // check if ENS entry of node exists: true | false
    }
    function __calledByMember(address _sender) public view returns (bool) {                // check if calling sender is member of a group
       require(__isGroupMember(_sender),"N");
       return true;
    }     
    function __ungravelGW(bytes32 _hash) public view {                                     // _hash belongs to a domain name that belongs to Ungravel Unified Name Space
      // _hash belongs to a domain name that belongs to Ungravel - 
      // protecting the call to only accept calls from inside the unified name space, UUNS

      IMulGWP gwp = IMulGWP(GWF.getOwner(_hash));                                       // *** hash of aseed *** _hash = auction label hash

      bytes32 hsh  = __hashFromGWP(gwp);                                                // hsh = GroupWallet domain hash
      address gwfc = gwp.getGWF();                                                      // GWF contract, derived from GWP
      require(__callerExists(address(gwp)) && hsh!=0x0 && __validAddress(gwfc) && MulGwf(gwfc).getOwner(hsh)==address(gwp),"R");
    }                                   
    function __getGasPrice() public view returns (uint256 gasPrice) {
      assembly { gasPrice := gasprice() }
    }
    function __calculateMinAuctionPrice() public view returns (uint64 minP) {
      minP = uint64(uint64(__getGasPrice()) * uint(2433123) * 100) / 10;
      if (minP<=0.001 ether) minP += 0.001 ether;
      return minP;
    }
    function __auctionTRecord(IMulGWP gwp) public view returns (address,uint) {
      uint256 K_TYPEMASK    = 0xf000000000000000000000000000000000000000000000000000000000000000;
      uint256 K_ADDRESSMASK = 0x000000000000000000000000ffffffffffffffffffffffffffffffffffffffff; 

      uint256 t;
      uint i = gwp.getTransactionsCount();
      require(i!=0,"0");

      do {
        i--;
        t = gwp.getTransactionRecord(i);
      } while( (i!=0) && (t!=0) && ((t & K_TYPEMASK) != K_TYPEMASK) );

      require(address(uint160(t & K_ADDRESSMASK))==address(this),"n");
      return (address(uint160(t & K_ADDRESSMASK)),i);
    }
    function __getLabelBytes32(IMulGWP gw,uint _tNb) internal view returns (bytes32) {
      return bytes32(uint256(gw.getTransactionRecord(_tNb) & 0x000000000000ffffffffffff0000000000000000000000000000000000000000)<<48);  // e.g. label name "seed"
    }
    function __addBucketNbToLabel(bytes32 label32,uint nb) internal pure returns (bytes32) { // *** only one byte *** 
      return bytes32( uint256(uint256(uint256(nb+96))<<248) + uint256(uint256(label32)>>8) );
    }
    function __nextBucketLabel(IMulGWP gw) public view returns (bytes32 b) {
      address gwfc = gw.getGWF();
      require(address(gwfc)!=address(0),"f");
      
      IMulENS ens = MulGwf(gwfc).ens();
      
      (address auctionTAddr,uint tNb) = __auctionTRecord(gw);
      require(address(ens)!=address(0) && auctionTAddr!=address(0)&&tNb!=0,"*");

      bytes32 label    = __getLabelBytes32(gw,tNb);
      bytes32 ldomHash = __hashFromGWP(gw);
      bytes32 labelHash;
      bytes32 dhash;
      
      uint i = 0;
      do {
        i++;
        labelHash  = keccak256(bytes(bytes32ToStr( __addBucketNbToLabel(label,i) )));
        dhash      = keccak256(abi.encodePacked(ldomHash,labelHash));
      } while(ens.recordExists(dhash)&&i<=26);
      
      if (!ens.recordExists(dhash)) {
        if ((address(MulGwf(gwfc).ensNameWrapper())==address(0))) return labelHash;  
        else          return bytes32ToBytes32WithLen(__addBucketNbToLabel(label,i));
      }

      require(false,"bb"); // *** max. 26 different labels *** a-z
    }

    function __unit_tests() private view returns (bool) {
      require(__isUngravelWaddr(address(this)),"u1");
      require(__nHashFromSender(address(this))!=0,"u2");
      require(__isNameSpace(__nHashFromSender(address(this))),"u3");

      address agroup = 0x49b88dd2aA4636d8F279613F08fbD34be4364833;
      bytes32 testHash = __hashFromGWP(IMulGWP(agroup));
      require(testHash!=0,"u4");
      require(strlen(__dNameFromSender(agroup))!=0,"u5");
      require(__ownerFromHash(testHash)==agroup,"u6");
      require(address(__gwpFromHash(testHash))==agroup,"u7");
      require(address(__tokenFromHash(testHash))!=address(0),"u8");
      require(__ownersFromHash(testHash).length!=0,"u9");

      address onemem = 0x00f1894BA9cc2A88aB76417404f1d9053f24b83a;
      require(__isOwnerFromHash(testHash,agroup),"u10");
      require(__getDomainHash(string('hockey-plate'))==testHash,"u11");
      require(__isGwpFromSender(agroup),"u12");
      require(__ensOwner(testHash)==agroup,"u13");
      require(__isGwpNameSpace(testHash,agroup),"u14");
      require(strlen(__ungravelDomain())!=0,"u15");

      require( __isGroupMember(onemem),"u17");
      require(!__isGroupMember(0xDadaDadadadadadaDaDadAdaDADAdadAdADaDADA),"u17b");
      require(!__isGroupMember(0x3b2F32d32fAaBd8d94DF36AfB956bd4D34bf905c),"u17c");
      require(!__isGroupMember(agroup),"u17d");

      require(strlen(__groupNameFromSender(agroup))!=0,"u16");

      require(__isMemberOfGroup(IMulGWP(agroup),onemem),"u18");
      require(!__isMemberOfGroup(IMulGWP(agroup),0x3b2F32d32fAaBd8d94DF36AfB956bd4D34bf905c),"u18b");
      require(!__isMemberOfGroup(IMulGWP(agroup),0xDadaDadadadadadaDaDadAdaDADAdadAdADaDADA),"u18c");

      require( __isGwpOrMember(0x49b88dd2aA4636d8F279613F08fbD34be4364833),"u19");
      require( __isGwpOrMember(0x00f1894BA9cc2A88aB76417404f1d9053f24b83a),"u20");
      require(!__isGwpOrMember(0xDadaDadadadadadaDaDadAdaDADAdadAdADaDADA),"u21");
      require(!__isGwpOrMember(0x3b2F32d32fAaBd8d94DF36AfB956bd4D34bf905c),"u22");

      require(__resolveToAddress('hockey-plate')==0x49b88dd2aA4636d8F279613F08fbD34be4364833,"u24");

      require(__isUngravelWaddr(address(__resolveSubDomain('factory.ungravel.lisk'))),"u25");
      require(__isUngravelWaddr(address(__resolveSubDomain('gwallet.ungravel.lisk'))),"u26");
      require(__isUngravelWaddr(address(__resolveSubDomain('tokenmaster.ungravel.lisk'))),"u27");
      require(__isUngravelWaddr(address(__resolveSubDomain('auctionmaster.ungravel.lisk'))),"u28");
      require(__isUngravelWaddr(address(__resolveSubDomain('intentions.ungravel.lisk'))),"u29");
      require(__isUngravelWaddr(address(__resolveSubDomain('global.ungravel.lisk'))),"u30");

      return true;
    }

    function version() public pure returns(uint256 v) {
      return 20010319;
    }

    fallback() external payable {
      if (msg.value > 0) {
        emit Deposit(msg.sender, msg.value);
        return;
      }
      require(false,"fb Multicall4!");
    }

    receive() external payable {
      emit Deposit(msg.sender, msg.value);
    }

    constructor (address _gwf, address _USDC, address _WETH) payable
    { 
      require(strlen(tld())>0&&address(_gwf)!=address(0x0)&&isContract(_gwf),"Multicall4 CONST!");
      require(strlen(chainName())>0,"Multicall4 CHAIN!");
      require(version()>20010000,"Multicall4 VERS!");

      if (address(_USDC)!=address(0x0)) {
        require(isContract(_USDC),"Multicall4 USDC!");
        USDC        = USDCToken(_USDC);
      }

      if (address(_WETH)!=address(0x0)) {
        require(isContract(_WETH),"Multicall4 WETH!");
        WETH        = WETHToken(_WETH);
      }

      masterCopy  = msg.sender;
      GWF         = MulGwf(_gwf);

      MulRr(GWF.reverseContract()).setName(string(abi.encodePacked('multifour.ungravel',tld()))); // assigning reverse resolver record ENS / EVM Names

      //__unit_tests(); // performed unit_tests during development, with known group and member addresses

      emit Deployment(msg.sender, address(this));
      emit DeploymentMulticall4(address(this), bytes32(nodeHash(string(abi.encodePacked(chainName())))));
    }
}

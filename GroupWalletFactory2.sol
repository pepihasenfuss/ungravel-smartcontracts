// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.30;

// ungravel.eth, GroupWalletFactory, GroupWalletMaster, GroupWallet, ProxyWallet, TokenMaster, ProxyToken, PrePaidContract, AuctionMaster, BiddingProxy, intDeedMaster, extDeedMaster, IntDeedProxy, Invitations by pepihasenfuss.eth 2017-2025, Copyright (c) 2025

// GroupWallet and Ungravel is entirely based on Ethereum Name Service, "ENS", the domain name registry.
// Although, Ungravel extends ENS to 16 different chains: EVM Names across chains create an Ungravel Unified Name Space, UUNS.

//   ENS, ENSRegistryWithFallback, PublicResolver, Resolver, FIFS-Registrar, Registrar, AuctionRegistrar, BaseRegistrar, ReverseRegistrar, DefaultReverseResolver, ETHRegistrarController,
//   PriceOracle, SimplePriceOracle, StablePriceOracle, ENSMigrationSubdomainRegistrar, CustomRegistrar, Root, RegistrarMigration are contracts of "ENS", by Nick Johnson and team.
//
//   Copyright (c) 2018, True Names Limited / ENS Labs Limited
//
//   Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//   The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

// GroupWalletFactory creates groups, installs the group share proxy contract, 
// ProxyToken (PT), and the group wallet proxy contract, ProxyGroupWallet (GWP).
// It assigns all required group member names and account addresses, it saves group structure, the shareholder structure.
// In addition, domainReport() collects all information required to load an existing group. This optimizes RPC API calls while dApp loading.
// GroupWalletFactory handles the migration and replication of entire groups, e.g. from one chain to another.
// GroupWalletFactory is the main entry point to create and to load Ungravel Groups.

interface IEnsF {
  event NewOwner(bytes32 indexed node, bytes32 indexed label, address owner);
  event Transfer(bytes32 indexed node, address owner);
  event NewResolver(bytes32 indexed node, address resolver);
  event NewTTL(bytes32 indexed node, uint64 ttl);
  event ApprovalForAll(address indexed owner, address indexed operator, bool approved);

  function setRecord(bytes32 node, address owner, address resolver, uint64 ttl) external;
  function setSubnodeRecord(bytes32 node, bytes32 label, address owner, address resolver, uint64 ttl) external;
  function setSubnodeOwner(bytes32 node, bytes32 label, address owner) external returns(bytes32);
  function setResolver(bytes32 node, address resolver) external;
  function setOwner(bytes32 node, address owner) external;
  function setTTL(bytes32 node, uint64 ttl) external;

  function owner(bytes32 node) external view returns (address);
  function resolver(bytes32 node) external view returns (address);
  function ttl(bytes32 node) external view returns (uint64);
  function recordExists(bytes32 node) external view returns (bool);
  function isApprovedForAll(address ensowner, address operator) external view returns (bool);
}
abstract contract AbstractGwfEns {
  event NewOwner(bytes32 indexed node, bytes32 indexed label, address owner);
  event Transfer(bytes32 indexed node, address owner);
  event NewTTL(bytes32 indexed node, uint64 ttl);
  event ApprovalForAll(address indexed owner, address indexed operator, bool approved);
  function setRecord(bytes32 node, address owner, address resolver, uint64 ttl) external virtual;
  function setSubnodeRecord(bytes32 node, bytes32 label, address owner, address resolver, uint64 ttl) external virtual;
  function setSubnodeOwner(bytes32 node, bytes32 label, address owner) external virtual returns(bytes32);
  function setResolver(bytes32 node, address resolver) external virtual;
  function setOwner(bytes32 node, address owner) external virtual;
  function owner(bytes32 node) public view virtual returns (address);
  function recordExists(bytes32 node) external virtual view returns (bool);
  function isApprovedForAll(address ensowner, address operator) external virtual view returns (bool);
}
abstract contract AbstractGwfReverseRegistrar {
  AbstractGwfResolver public defaultResolver;
  function claim(address owner) external virtual returns (bytes32);
  function claimWithResolver(address owner, address resolver) external virtual returns (bytes32);
  function setName(string memory name) external virtual returns (bytes32);
  function node(address addr) external virtual pure returns (bytes32);
}
abstract contract AbstractBaseRegistrar {
  event NameMigrated(uint256 indexed id, address indexed owner, uint expires);
  event NameRegistered(uint256 indexed id, address indexed owner, uint expires);
  event NameRenewed(uint256 indexed id, uint expires);
  bytes32 public baseNode;   // The namehash of the TLD this registrar owns eg, (.)eth
  IEnsF public ens;
}
abstract contract AbsIntentionsGwf {
  function saveLetterOfIntent(address target, uint nbOfShares) public virtual payable;
  function hashOfGWP(AbstractGwfGwp _gwp) internal virtual view returns (bytes32);
  function getIntendedLOIShares(address target, address investor) public virtual view returns (uint);
  function chain_name(uint chainId) public virtual pure returns (string memory);
}
abstract contract AbstractGwfGwp {
  function getGWF() external view virtual returns (address);
  function getIsOwner(address _owner) external virtual view returns (bool);
  function getOwners()                external virtual view returns (address[] memory);
  function newProxyGroupWallet_j5O(address[] calldata _owners) external virtual payable;
  function reverseENS(string calldata _domain, address _reverse) external virtual;
  function getTransactionsCount() external view virtual returns (uint);
  function getTransactionRecord(uint _tNb) external view virtual returns (uint256);
  function getIntention() public virtual view returns (AbsIntentionsGwf);
}
interface ITokenProxy {
  function newToken(uint256[] calldata _data) external payable;
}
abstract contract AbstractEthRegController {
  mapping(bytes32 domainHash =>uint theCommitment) public commitments;
  uint public minCommitmentAge;
  uint public maxCommitmentAge;
  address public nameWrapper;
  event NameRegistered(string name, bytes32 indexed label, address indexed owner, uint cost, uint expires);
  event NameRenewed(string name, bytes32 indexed label, uint cost, uint expires);
  event NewPriceOracle(address indexed oracle);
  function rentPrice(string memory name, uint duration) view external virtual returns(uint);
  function makeCommitmentWithConfig(string memory name, address owner, bytes32 secret, address resolver, address addr) pure external virtual returns(bytes32);
  function commit(bytes32 commitment) external virtual;
  function register(string calldata name, address owner, uint duration, bytes32 secret) external virtual payable;
  function registerWithConfig(string memory name, address owner, uint duration, bytes32 secret, address resolver, address addr) external virtual payable;
  function available(string memory name) external virtual view returns(bool);
  function register(string calldata name,address owner,uint256 duration,bytes32 secret,address resolver,bytes[] calldata data,bool reverseRecord,uint16 ownerControlledFuses) external virtual payable;
}
abstract contract AbstractGwfResolver {
  mapping(bytes32 domainHash => bytes hash) hashes;
  event AddrChanged(bytes32 indexed node, address a);
  event AddressChanged(bytes32 indexed node, uint coinType, bytes newAddress);
  event NameChanged(bytes32 indexed node, string name);
  event ABIChanged(bytes32 indexed node, uint256 indexed contentType);
  event PubkeyChanged(bytes32 indexed node, bytes32 x, bytes32 y);
  event TextChanged(bytes32 indexed node, string indexed indexedKey, string key);
  event ContenthashChanged(bytes32 indexed node, bytes hash);
  function ABI(bytes32 node, uint256 contentTypes) external virtual view returns (uint256, bytes memory);
  function addr(bytes32 node) external virtual view returns (address);
  function addr(bytes32 node, uint coinType) external virtual view returns(bytes memory);
  function name(bytes32 node) external virtual view returns (string memory);
  function text(bytes32 node, string calldata key) external virtual view returns (string memory);
  function supportsInterface(bytes4 interfaceId) external virtual view returns (bool);
  function setApprovalForAll(address operator, bool approved) virtual external;
  function setABI(bytes32 node, uint256 contentType, bytes calldata data) external virtual;
  function setAddr(bytes32 node, address r_addr) external virtual;
  function setAddr(bytes32 node, uint coinType, bytes calldata a) external virtual;
  function setName(bytes32 node, string calldata _name) external virtual;
  function setText(bytes32 node, string calldata key, string calldata value) external virtual;
}
abstract contract AbstractGwf {
  AbstractGwfResolver             public  resolverContract;
  AbstractEthRegController        public  controllerContract;
  AbstractBaseRegistrar           public  base;
  AbstractGwfEns                  public  ens;
  AbstractGwfReverseRegistrar     public  reverseContract;
  address                         public  GWFowner;
  mapping(uint64 timeStamp => uint256 installId) private installations;         // installTime +  proxyTokenAddr
  mapping(bytes32 hash => uint256 aCommitment)   private commitments;           // commitment  +  ownerAddr
  function version() public pure virtual returns(uint256 v);
  function getOwner(bytes32 _domainHash) external virtual view returns (address);
  function importGWP(bytes32 _dHash, uint256 commitment, uint256 installation) external virtual payable;
  function getGWProxy(bytes32 _dHash) public virtual view returns (address);
  function getProxyToken(bytes32 _domainHash) public virtual view returns (address p);
}
interface IGwpc {
  function getMasterCopy() external view returns (address);
}
abstract contract AbsAuctionRegistrar {
  function startAuction_ge0(bytes32 _hash, uint revealP) public virtual payable;
  function intentionsFromGWP(bytes32 _hash) public virtual returns (AbsIntentionsGwf);
}
abstract contract NameWrapper {
  function setSubnodeRecord(bytes32 parentNode,string memory label,address owner,address resolver,uint64 ttl,uint32 fuses,uint64 expiry) external virtual returns (bytes32 node);
  function setSubnodeOwner(bytes32 node,string calldata label,address newOwner,uint32 fuses,uint64 expiry) external virtual returns (bytes32);
  function setApprovalForAll(address operator,bool approved) external virtual;
  function setRecord(bytes32 node, address owner, address resolver, uint64 ttl) public virtual;
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
interface IMulGWP {                                                              // Abstract and access to GWP, Group Wallet Proxy contract, the Voting and Multi-Sig-contract of each group, a proxy, belonging to the GroupWallet Master
  function getIsOwner(address _owner)      external view returns (bool);
  function getOwners()                     external view returns (address[] memory);
  function getTransactionsCount()          external view returns (uint);
  function getTransactionRecord(uint _tNb) external view returns (uint256);
  function getGWF()                        external view returns (address);
  function getAllTransactions()            external view returns (uint256[] memory transArr);
  function getMasterCopy()                                                    external view returns (address);
  function nameAuctionBidBucketLabel(bytes32 labelhash, address deedContract) external;
}
abstract contract AbsMultiFour {
  address     public masterCopy; // deployer, owner of this contract
  AbstractGwf public GWF;        // GroupWalletFactory Ungravel.com
  event Deployment(address owner, address theContract);
  event DeploymentMulticall4(address theContract, bytes32 dhash);
  event Deposit(address from, uint256 value);
  function tld() public virtual view returns (string memory);
  function chainName() public virtual view returns (string memory);

  function __dNameFromSender(address _sender) public virtual view returns (string memory);
  function __nHashFromSender(address _sender) public virtual view returns (bytes32);
  function __hashFromGWP(IMulGWP _gwp) public virtual view returns (bytes32);
  function __ownerFromHash(bytes32 _dHash) public virtual view returns (address);
  function __gwpFromHash(bytes32 _dHash) public virtual view returns (IMulGWP);
  function __tokenFromHash(bytes32 _dHash) public virtual view returns (MulToken);
  function __ownersFromHash(bytes32 _dHash) public virtual view returns (address[] memory);
  function __isOwnerFromHash(bytes32 _dHash,address _owner) public virtual view returns (bool);
  function __getDomainHash(string memory _d) public virtual view returns (bytes32);
  function __isGwpFromSender(address _sender) public virtual view returns (bool);
  function __isNameSpace(bytes32 _dHash) public virtual view returns (bool);
  function __ensOwner(bytes32 _dHash) public virtual view returns (address);
  function __isGwpNameSpace(bytes32 _dHash,address _sender) public virtual view returns (bool);
  function __ungravelDomain() public virtual view returns (string memory);
  function __isUngravelWaddr(address _sender) public virtual view returns (bool);
  function __groupNameFromSender(address _sender) public virtual view returns (string memory);
  function __isMemberOfGroup(IMulGWP _gwp,address _member) public virtual view returns (bool);
  function __isGroupMember(address _sender) public virtual view returns (bool);
  function __isGwpOrMember(address _sender) public virtual view returns (bool);
  function __resolveToAddress(string memory _d) public virtual view returns (address);
  function __subdomainHash(string memory dn) public virtual view returns (bytes32);
  function __resolveSubDomain(string memory _d) public virtual view returns (address);
}

/// @title Proxy - Generic proxy contract allows to execute all transactions applying the code of a master contract.
/// @author Stefan George - <stefan@gnosis.pm> /// ProxyToken adapted and applied for shares and token by pepihasenfuss.eth
pragma solidity 0.8.30;
contract ProxyToken {
    address internal masterCopy;

    bytes32 internal name32;
    uint256 private ownerPrices;

    mapping (address shareHolder => uint256 balance) private balances;
    mapping (address shareHolder => mapping (address targetContract => uint256 nbOfShares)) private allowed;

    event Deposit(address from, uint256 value);
    event UpgradePT(address thisPT, address newMaster);

    constructor(address _master, string memory _domainName, AbstractGwfReverseRegistrar _reverse) payable
    {
      masterCopy = _master;
      _reverse.setName(_domainName); // reverse resolver of address(this) provides e.g. "token.thisproject.eth", aka to claim ENS name
    }

    fallback () external payable
    {   
        // solium-disable-next-line security/no-inline-assembly
        assembly {
            let master := and(sload(0), 0xffffffffffffffffffffffffffffffffffffffff)
            if eq(calldataload(0), 0xa619486e00000000000000000000000000000000000000000000000000000000) {
                mstore(0, master)
                return(0, 0x20)
            }

            let ptr := mload(0x40)
            calldatacopy(ptr, 0, calldatasize())
            let success := delegatecall(gas(), master, ptr, calldatasize(), 0, 0)
            returndatacopy(0, 0, returndatasize())
            if eq(success, 0) { 
              if eq(returndatasize(),0) { revert(0, 0x404) }
              revert(0, returndatasize())
            }
            return(0, returndatasize())
        }
    }

    //modifier onlyByTokenMaster(address master) {
    //  require(master!=address(0) && masterCopy==msg.sender,"on");
    //  _;
    //}

    function upgrade(address master) external payable { // replace TokenMaster of this TokenProxy
      require(masterCopy==msg.sender,"p!");
      masterCopy = master;
      emit UpgradePT(address(this), master);
    }

    function onERC1155Received(address,address,uint256,uint256,bytes calldata) public pure returns (bytes4) { // 0xf23a6e61
      return this.onERC1155Received.selector; // gas-efficient Multiple Token standard, accepting ERC20, ERC721
    }
    
    receive() external payable { // *** PTC may receive payments ***
      emit Deposit(msg.sender, msg.value);
    }
}

/// @title Proxy - Generic proxy contract allows to execute all transactions applying the code of a master contract.
/// @author Stefan George - <stefan@gnosis.pm> /// ProxyGroupWallet adapted and applied for GroupWallet by pepihasenfuss.eth
pragma solidity 0.8.30;
contract ProxyGroupWallet {
    address public masterCopy;

    mapping(uint256 transId => uint256 transRecord)   private tArr;
    address[]                                       private owners;
    
    address internal GWF;                                                       // GWF - GroupWalletFactory contract
    mapping(uint256 hash => bytes storageBytes) private structures;
  
    event Deposit(address dep_from, uint256 dep_value);
    event UpgradeGWP(address thisGWP, address newMaster);

    modifier onlyByTokenMaster() {
      require(IGwpc( AbstractGwf(GWF).getProxyToken( bytes32(tArr[uint256(uint160(GWF))]) ) ).getMasterCopy()==msg.sender,"own");
      _;
    }
    
    constructor(address _masterCopy, string memory _domainName, AbstractGwfReverseRegistrar _reverse) payable
    { 
      masterCopy = _masterCopy;
      _reverse.setName(_domainName);
    }
    
    fallback () external payable
    {   
        // solium-disable-next-line security/no-inline-assembly
        assembly {
            let master := and(sload(0), 0xffffffffffffffffffffffffffffffffffffffff)
            if eq(calldataload(0), 0xa619486e00000000000000000000000000000000000000000000000000000000) {
                mstore(0, master)
                return(0, 0x20)
            }

            let ptr := mload(0x40)
            calldatacopy(ptr, 0, calldatasize())
            let success := delegatecall(gas(), master, ptr, calldatasize(), 0, 0)
            returndatacopy(0, 0, returndatasize())
            if eq(success, 0) { 
              if eq(returndatasize(),0) { revert(0, 0x504) }
              revert(0, returndatasize())
            }
            return(0, returndatasize())
        }
    }
    
    function upgrade(address master) external onlyByTokenMaster payable { // substituting GWM of GWP
      require(master!=address(0),"gw");
      masterCopy = master;
      emit UpgradeGWP(address(this), master);
    }

    function onERC1155Received(address,address,uint256,uint256,bytes calldata) public pure returns (bytes4) { // 0xf23a6e61
      return this.onERC1155Received.selector; // gas-efficient Multiple Token standard, accepting ERC20, ERC721
    }

    receive() external payable { // *** GWP can sell common shares to TokenProxy, thus it may receive payments ***
      emit Deposit(msg.sender, msg.value);
    }
}

// GroupWalletFactory by pepihasenfuss.eth 2017-2025
contract GroupWalletFactory {
    event TestReturn(uint256 v1, uint256 v2, uint256 v3, uint256 v4);
    event Deposit(address from, uint256 value);
    event PrePaidAccountReady(address from, uint256 value);
    event StructureDeployed(bytes32 domainHash);
    event ColorTableSaved(bytes32 domainHash);
    event EtherScriptSaved(bytes32 domainHash,string key);
    event ProxyTokenCreation(ProxyToken proxy);
    event ProxyGroupWalletCreation(ProxyGroupWallet proxy);
    event SetPrices(bytes32 domainHash);
    event TransferOwner(bytes32 domainHash);
    event FreezeToken(bytes32 domainHash);
    event Transfer(address indexed from, address indexed to, uint256 value);
    
    uint256 constant K_AMASK        = 0x000000000000000000000000ffffffffffffffffffffffffffffffffffffffff; // 160 bits, address mask
    uint256 constant K_COMMITMASK   = 0xffffffffffffffffffffffff0000000000000000000000000000000000000000; // mask out lower 160 bits
    uint256 constant K_COMMIT2Mask  = 0x0000000000000000000000000000000000000000ffffffffffffffffffffffff; // 12 bytes mask, only commitment
    uint256 constant K_LOCKEDMASK   = 0x0000000000000000000000010000000000000000000000000000000000000000; // 1 bit mask used for a locked structure
    
    bytes32 constant K_ABI80        = 0x0000000000000000000000000000000000000000000000000000000000000080; // 32 bytes = abi80 word, used for generating ABI
    uint256 constant K_RENTMASK     = 0x00000000000000000000000000000000ffffffffffffffffffffffffffffffff; // mask of 16 bytes
    uint256 constant K_LC           = 0x2000000000000000000000000000000000000000000000000000000000000000; // toLowerCase() for first char
    bytes32 constant K_TKLABELHASH  = keccak256(bytes('token'));                                          // hash ("token")

    address constant k_add00        = address(0);
    uint constant private MAX_OWNER_COUNT = 31;                                                           // group may have 2 ot up to 31 members

    uint256 private _guardCounter = 1;                                                                    // used for reentrancy checks

    AbstractGwfResolver             public  immutable resolverContract;                                   // ENS / EVM Names resolver
    AbstractEthRegController        public  immutable controllerContract;                                 // ENS / EVM EthRegController sells domain names
    AbstractBaseRegistrar           public  immutable base;                                               // ENS / EVM Base organizes tld, such as ".lisk"
    AbstractGwfEns                  public  immutable ens;                                                // ENS / EVM name registry, storing domain name hashes
    AbstractGwfReverseRegistrar     public  immutable reverseContract;                                    // ENS / EVM reverse registry provides domain name from address
    address                         public  immutable GWFowner;                                           // Ungravel GWF owner / deployer address
    NameWrapper                     public  immutable ensNameWrapper;                                     // ENS / EVM NameWrapper wraps domain name items into NFTs (only Ethereum mainnet)
    AbsAuctionRegistrar             public            auctionContract;                                    // Ungravel AuctionMaster organizes Funding Auctions, this can easily be updated
    AbsMultiFour                    public            multifourContract;                                  // Ungravel MultiCall4 contract, provides chain names and tld
    
    // Hint: These are the only memory slots saving all required identifiers and information for every single Ungravel Group

    mapping(uint64 timeStamp => uint256 installId)   private installations;                               // installTime +  proxyTokenAddr in a single memory slot
    mapping(bytes32 hash     => uint256 aCommitment) private commitments;                                 // commitment  +  ownerAddr      in a single memory slot

    // ---------------------------------------------------------------------------------------------------------------------

    modifier nonReentrant() {                                                   // reentrancy watchdog
      _guardCounter += 1;
      uint256 localCounter = _guardCounter;
      _;
      require(localCounter == _guardCounter,"r");
    }
    modifier onlyByMemberOrDeployer(bytes32 _dHash) {                           // used for: update_P5q()
       my_require(_dHash!=0x0 && ( __isInitiator(_dHash) || __isMember(_dHash) ), "i");
      _;
    }
    modifier onlyByOwner() {                                                    // used by: withdraw(), setAuctionsContract()
      my_require(GWFowner==msg.sender,"own");
      _;
    }
    modifier onlySameDeployers(address _ctr) {                                  // used by: upgradeGWF()
      my_require(__sameDeployers(_ctr),"gf");
      _;
    }
    modifier onlyUUNSgwp(bytes32 _dHash) {                                      // used by: upgradeGWF()
      // _dHash is a GWP that belongs to Ungravel Unified Name Space, UUNS, returns: true | false 
      my_require(
                  _dHash==__getdHash(AbstractGwfGwp(msg.sender))                                    && // GWP uses GWF contract, GWP owns dName, s.a. "silvias-bakery.eth" 
                  getOwner(_dHash)==msg.sender                                                      && // msg.sender is a GWP because _dHash is linked to the same address
                  AbstractGwfGwp(msg.sender).getGWF()==address(this)                                && // GWF of GWP is this contract, the GWF | GWF is calling itself
                  __isNameSpace(_dHash)                                                             && // _dHash belongs to EVM Name space in general, domain name is assigned
                  __ensOwner(_dHash)==msg.sender,                                                      // msg.sender owns _dHash, therefore valid GWP belonging to UUNS
            "GM");
      _;
    }
    modifier notLocked(bytes32 _c) {                                            // used by: lock_dfs()
      my_require(_c!=0x0 && installations[ uint64( (uint256(uint256(_c) & K_COMMITMASK)>>160) & K_COMMIT2Mask ) ]==0x0,"r3"); // NOT yet locked getInstallTime(c), getCommitment(c) 
      _;
    }
    modifier initiatorOrThisGWF(bytes32 _dHash) {                               // used for: register_ki_(), lock_dfs(), registerAndLock_x3x(), inviteInstallToken_q31n()
      my_require(__initOrThisGwf(_dHash), "ow3");
      _;
    }
    modifier onlyInitiator(bytes32 _dHash) {                                    // used for: setTokenPrices(), transferOwner(), transferToken(), transferTokenFrom()
      my_require(_dHash!=0x0 && __isInitiator(_dHash),"in");
      _;
    }
    modifier ungravelUUNS(bytes32 _dHash) {                                     // used for: reserve_replicate(), importGWP()
      // Assert that this is called by a valid GWF contract and _dHash belongs to UUNS.
      // UUNS = Ungravel Unified Name Space aka unified group domain names, s.a. "somegroup.uni" | "mygroup.lisk"
      // across 16 different target chains (and counting)
      my_require(_dHash!=0x0 && __isEVMNameSpacedGWF(_dHash),"ns");
      _;
    }
    modifier groupOrPPA() {                                                     // used for: reserve_replicate()
      my_require(multifourContract.__isGwpFromSender(msg.sender) || multifourContract.__isUngravelWaddr(msg.sender),"gO"); // is GWP | ungravel working address s.a. ppa, deployer
      _;
    }
    modifier onlyGWPorOwner(address _sender,bytes32 _dHash) {                   // used for: replicate_group_l9Y()
      my_require(msg.value>0 && ( __isSenderGWP(_sender) || __isHashOwner(_dHash) ),"dm");
      _;
    }

    // low-level methods, used internally, all private(ly)
    function __domName() private view returns (string memory) {                 // domain name of msg.sender from reverse registry
      return AbstractGwfResolver(reverseContract.defaultResolver()).name( reverseContract.node(msg.sender) );
    }
    function __isUngravelUUNS() private view returns (bool) {                   // msg.sender UUNS EOA address
                                                                                // __domName() == "deployer.ungravel.lisk". || "ppa.ungravel.lisk" || "acc1.ungravel.base"

      bytes32 domain32   = stringMemoryTobytes32(__domName());                  // e.g. 0x6465706C6F7965722E756E67726176656C2E6C69736B00000000000000000000 32 bytes
      bytes32 ungravel32 = 0x2E756E67726176656C2E00000000000000000000000000000000000000000000; // ".ungravel."

      uint i;
      for(i=0; i<32; i++) {
        if (domain32 & ungravel32 == ungravel32) return true;                   // mask if found, then returns true
        domain32 = domain32<<8;
      }

      return false;
    }
    function __proxyToken(bytes32 _dHash) private view returns (address) {      // derives proxyToken contract address from domain name hash of the group
      return address( uint160( uint256( installations[ uint64( (uint256( commitments[_dHash] & K_COMMITMASK )>>160) & K_COMMIT2Mask ) ] ) & K_AMASK ) );
    }
    function __isMember(bytes32 _dHash) private view returns (bool) {           // msg.sender is valid member of the group, identified with _dHash
      address[] memory memArr = __getOwnersFromCommitment( commitments[_dHash] );
      uint l = (memArr.length & MAX_OWNER_COUNT);
      uint i = 0;
      
      do {
        if (memArr[i] == msg.sender) return true;
        i++;
      } while(i<l);
      
      return false;
    }
    function __isInitiator(bytes32 _dHash) private view returns (bool) {        // msg.sender = initiator, i.e. owner of the commitment is calling
      return ( _dHash!=0x0 && address(uint160(commitments[_dHash] & K_AMASK))==msg.sender );
    }
    function __isHashOwner(bytes32 _dHash) private view returns (bool) {        // msg.sender owns the domain name hash
      return __isInitiator(_dHash);
    }
    function __sameDeployers(address _ctr) private view returns (bool) {        // this GWF contract was deployed by the same deployer than _ctr contract
      return (_ctr!=address(0) && GWFowner==AbstractGwf(_ctr).GWFowner());
    }
    function __timeStamp() private view returns (uint64) {                      // get a time stamp from the current block
      return uint64(block.timestamp);
    }
    function __time() private view returns (uint64) {                           // formatting time stamp, mask lower bits
      return uint64(__timeStamp()*1000)&uint64(0xffffffffffff0000);          // time % 0x1000 - masking time record
    }
    function __originator() private view returns (address) {                    // originator of call
      return address(tx.origin);
    }
    function __selfbalance() private view returns (uint self) {                 // returns the balance of this contract
        assembly {
          self :=selfbalance()
        }
    }
    function __ensOwner(bytes32 _hash) private view returns (address) {         // provide resolved group owner of domain name hash s.a. "ethereum.lisk"
      return resolverContract.addr(_hash);                                      // return resolvedAddress() from group domain name hash
    }
    function __isNameSpace(bytes32 _dHash) private view returns (bool) {        // _dHash belongs to EVM Name Space, e.g. ENS Name Space on Ethereum
      return (_dHash!=0x0 && base.ens().recordExists(_dHash));
    }
    function __isGwpNameSpace(bytes32 _dHash) private view returns (bool) {     // _dHash belongs to EVM and Ungravel Unified Name Space, UUNS
      return (__isNameSpace(_dHash) && __ensOwner(_dHash)==msg.sender);         // and msg.sender is GWP belonging to UUNS
    }
    function __isEVMNameSpacedGWF(bytes32 _dHash) private view returns (bool) { // msg.sender is a GWF, _dHash belongs to EVM Name Space = UUNS
                                                                                // GWP derived from EVM Name Space == GWP derived from GWF
       return (                                                                 // Asserts that _dHash==domain name that belongs to UUNS.
                __isNameSpace(_dHash)                                        && // _dHash of a domain name belongs into the EVM Name Space, in general
                __ensOwner(_dHash)!=address(0)                               && // GWP, derived from _dHash is a valid contract address
                __ensOwner(_dHash)==AbstractGwf(msg.sender).getOwner(_dHash) && // both GWP derived from different sources represent the same GWP contract
                __sameDeployers(msg.sender)                                     // this GWF deployer/owner is identical to the calling GWF deployer/owner
                                                                                // therefore, QED: This is called by a valid GWF contract belonging to Ungravel!
              );
    }
    function __senderIsThisGwf() private view returns (bool) {                  // msg.sender is this contract, the GWF
      return  msg.sender==address(this);
    }
    function __initOrThisGwf(bytes32 _dHash) private view returns (bool) {      // msg.sender derived from _dHash is initiator | msg.sender is this contract
      return (_dHash!=0x0 && ( __isInitiator(_dHash) || __senderIsThisGwf() ));
    }
    function __getdHash(AbstractGwfGwp gw) private view returns (bytes32) {     // get dHash from GWP and Ungravel GWF, using GroupWalletProxy, GWP
      // each GWP = GroupWalletProxy contract, saves the domain hash of its own EVM Name
      // e.g. the group "mygroup.eth" owns the domain name hash of 'mygroup.eth', identifying the group
      // In addition, the GWF identifies group structure using the hash as an id.
      // The group domain name hash is unique, such as "ethererum.eth", or "bitcoin.lisk".
      // Ungravel Unified Name Space provides unique hash ids of groups and members across 16 chains.
      // Therefore, "vitalik.ethererum.eth" may send a bonus to "finney.bitcoin.lisk" x-chain, perhaps.
      // Since every group owns its group domain name the very second of it‘s creation, it is safe.
      // Unique domain name hashes of "factory.ungravel.lisk" or "gwallet.ungravel.eth" make
      // Ungravel infrastructure safe as well: The domain name hash of this GWF is unique,
      // the hash of the GroupWalletMaster, GWM, is unique. Using the reverseRegistrar across chains,
      // Ungravel infrastructure contracts have a unique, safe, fingerprint that identifies 
      // contract and contract address as valid members of UUNS, the Ungravel Unified Name Space.

      return bytes32(gw.getTransactionRecord(uint256(uint160(gw.getGWF()))));   // domain hash, s.a. hash of "mygroupwallet.eth"
    }
    function __isSenderGWP(address _sender) private view returns (bool) {
      return multifourContract.__isGwpFromSender(_sender);
    }

    function getGWF() external view returns (address) {
      return address(this);                                                     // needed, to call GroupWallet or GroupWalletFactory transparently
    }

    function getCommitment(bytes32 _domainHash) private view returns (uint64) {
      return uint64( (uint256( commitments[_domainHash] & K_COMMITMASK )>>160) & K_COMMIT2Mask );
    }
    
    function getOwner(bytes32 _domainHash) public view returns (address) {
      return address( uint160( commitments[_domainHash] & K_AMASK ) );
    }
    
    function saveOwner(address _iToken, bytes32 _domainHash) private { // only for illustration, not used
      my_require(_iToken!=address(0),"on");
      commitments[ _domainHash ] = uint256(uint160(_iToken)) + uint256( commitments[_domainHash] & K_COMMITMASK);
    }

    function saveCommitment(bytes32 input, bytes32 _domainHash) private { // only for illustration, not used
      commitments[_domainHash] = uint256( (uint256(input)<<160) & K_COMMITMASK ) + uint256( commitments[_domainHash] & K_AMASK);
    }

    function getInstallTime(bytes32 _domainHash) public view returns (uint256) {
      uint256 i = uint256(installations[ getCommitment(_domainHash) ]);
      return uint256( (uint256( i & K_COMMITMASK )>>160) & K_COMMIT2Mask );
    }

    function getProxyToken(bytes32 _domainHash) public view returns (address) {
      return address( uint160( uint256( uint256(installations[ getCommitment(_domainHash) ]) ) & K_AMASK ) );
    }

    function getGWProxy(bytes32 _dHash) public view returns (address) {
      return address( uint160( commitments[_dHash] & K_AMASK ) );
    }

    function saveProxyToken(address _iOwner, bytes32 _domainHash) private { // only for illustration, not used
      uint64 hsh  = getCommitment(_domainHash);
      uint256 i = uint256(installations[ hsh ]);
      installations[ hsh ] = uint256(uint160(_iOwner)) + uint256(i & K_COMMITMASK);
    }

    function saveInstallTime(uint256 input, bytes32 _domainHash) private { // only for illustration, not used
      uint64 hsh  = getCommitment(_domainHash);
      uint256 i   = uint256(installations[ hsh ]);
      installations[ hsh ] = uint256( (uint256(input)<<160) & K_COMMITMASK ) + uint256(i & K_AMASK);
    }

    // -------------------  owners ---------------------------------------------
    
    function __getOwnersFromCommitment(uint256 c) private view returns (address[] memory) {
      // commitment leads to a GWP of this group
      // reply Array of owner addresses of group, GWP
      AbstractGwfGwp gw = AbstractGwfGwp(address( uint160( c & K_AMASK ) ));               // right after registration, gw is NOT YET deployed! 
      if ((address(gw)!=__originator())&&(address(gw)!=address(0))) return gw.getOwners(); // checking if gw is yet valid and deployed, otherwise, no owners yet
      
      address[] memory empty;
      return empty;
    }

    function getIsOwner(bytes32 _dHash, address _owner) external view returns (bool) {
      address theGWPcontract = address( uint160( commitments[_dHash] & K_AMASK ) );
      if (theGWPcontract==msg.sender) return false; // if is initiator calling, no owners list yet
      return AbstractGwfGwp( theGWPcontract ).getIsOwner(_owner);
    }

    function getOwners(bytes32 _dHash) external view returns (address[] memory) {
      return __getOwnersFromCommitment( commitments[_dHash] );
    }
    
    // -------------------  strings ---------------------------------------------

    function char(bytes1 b) private pure returns (bytes1) {
        if (uint8(b) < uint8(10)) return bytes1(uint8(b) + 0x30);
        return bytes1(uint8(b) + 0x57);
    }
    
    function strlen(string memory s) private pure returns (uint len) {
        uint i = 0;
        uint bytelength = bytes(s).length;
        for(len = 0; i < bytelength; len++) {
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
    
    function bytesToStr(bytes32 _b, uint len) private pure returns (string memory) {
      bytes memory bArr = new bytes(len);
      uint256 i;
      
      do
       { 
        bArr[i] = _b[i];
        i++;
      } while(i<len&&i<32);
      
      return string(bArr); 
    }
    
    function concat(bytes32 _b, string memory _str) private pure returns (string memory) {
      uint len  = strlen(_str);

      uint8 i   = 0;
      uint8 off = 0;

      do
      { 
        (_b[i]!=0) ? len++ : off = i;
        i++;
      } while(off==0&&i<32);


      bytes memory bArr = new bytes(len);


      i   = 0;
      off = 0;

      do
      { 
        if (_b[i]!=0) {
          bArr[i] = _b[i];
        }
        else {
          off = i;
        }

        i++;
      } while(off==0&&i<32);
      

      len = strlen(_str);
      i = 0;
      
      do
      { 
        bArr[off+i] = bytes(_str)[i];
        i++;
      } while(i<len);

      return string(bArr);
    }

    function stringMemoryTobytes32(string memory _data) private pure returns(bytes32 a) {
      // solium-disable-next-line security/no-inline-assembly
      assembly {
          a := mload(add(_data, 32))
      }
    }
    
    function mb32(bytes memory _data) private pure returns(bytes32 a) {
      // solium-disable-next-line security/no-inline-assembly
      assembly {
          a := mload(add(_data, 32))
      }
    }
    
    // function memcpy(uint dest, uint src, uint len) private pure {
    //     // Copy word-length chunks while possible
    //     for (; len >= 32; len -= 32) {
    //         // solium-disable-next-line security/no-inline-assembly
    //         assembly {
    //             mstore(dest, mload(src))
    //         }
    //         dest += 32;
    //         src += 32;
    //     }
        
    //     if (len==0) return;

    //     // Copy remaining bytes
    //     uint mask = 256 ** (32 - len) - 1;
        
    //     // solium-disable-next-line security/no-inline-assembly
    //     assembly {
    //         let srcpart := and(mload(src), not(mask))
    //         let destpart := and(mload(dest), mask)
    //         mstore(dest, or(destpart, srcpart))
    //     }
    // }

    // function substring(bytes memory self, uint offset, uint len) private pure returns(bytes memory ret) {
    //     my_require(offset + len <= self.length,"s");

    //     ret = new bytes(len);
    //     uint dest;
    //     uint src;

    //     // solium-disable-next-line security/no-inline-assembly
    //     assembly {
    //         dest := add(ret, 32)
    //         src  := add(add(self, 32), offset)
    //     }
    //     memcpy(dest, src, len);

    //     return ret;
    // }

    function fromBytes32(bytes32 _label) private pure returns (string memory) {
      return bytesToStr(_label,uint(_label)&0xff);
    }

    function getDomainHash(string memory _d) private view returns (bytes32) {
      return keccak256(abi.encodePacked(base.baseNode(), keccak256(bytes(_d))));
    }

    // -------------------  GWF ---------------------------------------------

    function my_require(bool b, string memory str) private pure {
      require(b,str);
    }
    
    function reserve_ogn(bytes32 _domainHash,bytes32 _commitment,bytes calldata data) external nonReentrant payable {
      (bool success, bytes memory returnData) = address(0xDadaDadadadadadaDaDadAdaDADAdadAdADaDADA).call{value: 0}(data);
      
      my_require(_domainHash!=0 && data.length>0 && success && returnData.length==0 && _commitment!=0x0 && commitments[ _domainHash ]==0,"O");
      emit StructureDeployed(_domainHash);
      
      controllerContract.commit(_commitment);
      commitments[ _domainHash ] = uint256( (uint256(_commitment)<<160) & K_COMMITMASK ) + uint256( uint160(msg.sender) & K_AMASK ); // saveOwner initiator = owner
    }

    function reserve_replicate(bytes32 _domainHash,bytes32 _commitment) external groupOrPPA payable { // 0x4651a1ef
      my_require(_domainHash!=0&&_commitment!=0 && commitments[ _domainHash ]==0,"R");
      controllerContract.commit(_commitment);
      commitments[ _domainHash ] = uint256( (uint256(_commitment)<<160) & K_COMMITMASK ) + uint256( uint160(msg.sender) & K_AMASK ); // saveOwner = commitment + initiator = owner
    }

    // ENS V3 2023 methods

    function isENSV3() private view returns (bool) { // this depends on deployment constructor arg
      // Chains with full ENSV3 support come with a NameWrapper contract != 0x0
      // Chains that do only support ENSV2 come with NameWrapper == 0x0
      return (address(ensNameWrapper)!=k_add00);
    }

    function onERC1155Received(address,address,uint256,uint256,bytes calldata) public pure returns (bytes4) { // 0xf23a6e61
      return this.onERC1155Received.selector; // gas-efficient Multiple Token standard, accepting ERC20, ERC721
    }

    function _allowNameWrapperAndResolver(address _owner) private {
      NameWrapper(controllerContract.nameWrapper()).setApprovalForAll(_owner,true); // GWP gets approved for NameWrapper
      resolverContract.setApprovalForAll(_owner,true);                              // GWP gets approved for PublicResolver
    }

    function _register(bytes32 _dHash,uint256 _rent,string memory _name,uint256 _dur,bytes32 _secret) private {
      my_require(_secret!=0&&_dur!=0&&controllerContract.available(_name),"Y");

      if (isENSV3()) {                                                                                                                  // register ENS V3
        bytes[] memory cmd = new bytes[](1);
        cmd[0] = abi.encodePacked( bytes4(0x8b95dd71), _dHash, uint256(0x3c), uint256(0x60), uint256(0x14), uint256(uint256(uint160(address(this)))<<96) );

        (bool success, bytes memory rdata) = 
        address(controllerContract).call{value:_rent}
                                        ( abi.encodeWithSignature("register(string,address,uint256,bytes32,address,bytes[],bool,uint16)",
                                          _name,address(this),_dur,_secret,address(resolverContract),cmd,false,0)
                                        );

        my_require(success&&rdata.length==0,string(rdata));

        address l_ProjectOwner = address(uint160( commitments[_dHash] & K_AMASK ));
        if (l_ProjectOwner==msg.sender) _allowNameWrapperAndResolver(l_ProjectOwner);
      } else
      {
        controllerContract.registerWithConfig{value: _rent}(_name,address(this),_dur,_secret,address(resolverContract),address(this));  // register ENS V2
      }

      resolverContract.setName(_dHash,string(abi.encodePacked(_name,tld())));
    }

    function _setAvatar(bytes32 _dHash, string memory _avatar) private {
      if (strlen(_avatar)==0) _avatar = 'https://www.ungravel.com/ung.png'; // e.g. default: https://www.ungravel.com/ung.png
      resolverContract.setText(_dHash,'avatar',_avatar);
    }

    function _setOwner(bytes32 _domHash,address _owner,bytes32 _label,bytes32 _dHash) private {
      resolverContract.setAddr(_domHash,_owner);                                                                          // e.g. _domHash = hash "vitalik.ethereum.eth"

      if (_label==0) _setAvatar(_dHash,'');                                                                               // set default group avatar UNG logo

      if (!isENSV3()) {
        base.ens().setOwner(_domHash,_owner);
      }
      else 
      {
        if (_label==0) _allowNameWrapperAndResolver(_owner);
        else NameWrapper(controllerContract.nameWrapper()).setSubnodeOwner(_dHash,fromBytes32(_label),_owner,0,0);        // member label ownership
      }
    }

    function register_ki_(bytes32[] calldata _m) external nonReentrant initiatorOrThisGWF(_m[0]) payable { 
                                                                                // _m[0] _domainHash
                                                                                // _m[1] _secret
                                                                                // _m[2]  duration / rent
                                                                                // _m[3]  domainName with length byte

      _register(_m[0], uint256(_m[2]) & K_RENTMASK, fromBytes32(_m[3]), uint256(_m[2])>>128, _m[1]);
    }
    
    function _updateStructure(bytes32 _dHash,bytes calldata _data32) private {
      resolverContract.setABI(_dHash,32,abi.encodePacked(_data32));              // structure
      emit StructureDeployed(_dHash);
    }

    function update_P5q(bytes32 _dHash,bytes calldata data32) external onlyByMemberOrDeployer(_dHash) payable {
      _updateStructure(_dHash,data32);
    }

    function lock_dfs(bytes32 _dHash, bytes calldata data32) external initiatorOrThisGWF(_dHash) notLocked(_dHash) payable {
      uint64 hsh         = uint64( (uint256(commitments[_dHash] & K_COMMITMASK)>>160) & K_COMMIT2Mask );
      installations[hsh] = uint256( installations[hsh] & K_AMASK ) + K_LOCKEDMASK;
      _updateStructure(_dHash,data32);
    }
    
    function registerAndLock_x3x(bytes32[] calldata _m, bytes calldata data32) external nonReentrant initiatorOrThisGWF(_m[0]) payable {
      bytes32 c = _m[0];                                                        // _m[0] = _domainHash
                                                                                // _m[1] = _secret
                                                                                // _m[2] = duration/rent
                                                                                // _m[3] = domainName with length byte
      // ---------------------------- register domain --------------------------

      _register(c, uint256(_m[2]) & K_RENTMASK, fromBytes32(_m[3]), uint256(_m[2])>>128, _m[1]);    

      // ---------------------------- lock group structure----------------------
            
      uint64 hsh = uint64( (uint256(uint256(c) & K_COMMITMASK)>>160) & K_COMMIT2Mask );
      installations[hsh] = uint256( installations[hsh] & K_AMASK ) + K_LOCKEDMASK;
      _updateStructure(c,data32);
    }
    
    function domainReport(string calldata _dom,uint command) external payable returns (uint256 report, address gwpc, address ptc, address gwfc, bytes memory structure) { 
      uint256 stamp      = 0;
      uint    nb         = 32;
      bytes memory abi32;
      
      bytes32 dHash      = getDomainHash(_dom);                                                                          // domain hash, ENS
      address owner      = base.ens().owner(dHash);                                                                      // ENS domain owner
      bool hasCommitment = uint64(getCommitment(dHash))>0x0;                                                             // hasCommitment
      
                                                                                report = uint256(getInstallTime(dHash) & 0x1);// locked group ? getInstallTime() =  domain install time (GWF)
      if (!base.ens().recordExists(dHash))                                      report = uint256(uint(report)+2);        // domain available - NOT existing
      if (owner == address(getGWProxy(dHash)) || owner == address(this))        report = uint256(uint(report)+4);        // domain contracted, GroupWalletProxy or this GWF contract is OWNER of domain
      if (base.ens().resolver(dHash) == address(resolverContract))              report = uint256(uint(report)+8);        // resolverContract is resolving domain, valid resolver
      if (hasCommitment)                                                        report = uint256(uint(report) + 16);     // domain with commitment
      if (resolverContract.addr(dHash) == address(this))                        report = uint256(uint(report) + 64);     // domain ENS resolves to the GWF contract, this contract

      {
      string memory colTableTxt = resolverContract.text(dHash,"use_color_table");
      if ((!isENSV3()&&(uint256(stringMemoryTobytes32(colTableTxt))!=0x0000000f7573655f636f6c6f725f7461626c6500000000000000000000000000)) || (isENSV3()&&strlen(colTableTxt)>0))
                                                                                report = uint256(uint(report)+2048);     // has colorTable
      }
      if (getProxyToken(dHash) != k_add00)                                      report = uint256(uint(report)+4096);     // has proxyToken contract
      if (owner == k_add00)                                                     report = uint256(uint(report)+256);      // domain NOT owned owner = 0x000000000000000000000000000
      if (controllerContract.available(_dom))                                   report = uint256(uint(report)+512);      // domain is available
      if (owner == __originator())                                              report = uint256(uint(report)+1024);     // domain owned by default account

      if (isENSV3() && (owner == controllerContract.nameWrapper()))             report = uint256(uint(report)+8196);     // 8192+4 owner is NameWrapper, belonging to ENS V3, domain contracted
      
      if (hasCommitment) {                                                                                               // hasCommitment
        (nb, abi32) = resolverContract.ABI(dHash,128);                                                                   // isABI128
        if ((nb==128)&&(abi32.length>=224)&&((abi32.length%32)==0))             report = uint256(uint(report)+128);

        (nb, abi32) = resolverContract.ABI(dHash,32);                                                                   // isABIstructure, ABI32
        if ((nb==32)&&(abi32.length>32)&&(abi32.length<0x1000))                 report = uint256(uint(report)+32);
        
        nb = __getOwnersFromCommitment( commitments[ dHash] ).length;                                                    // nb of members in group

        stamp = uint256(stringMemoryTobytes32(resolverContract.text(dHash,"use_timeStamp")));
        if (!isENSV3()&&(stamp==0x0000000d7573655f74696d655374616d70000000000000000000000000000000)) stamp = 0;          // timeStamp "use_timeStamp" == 0d 7573655f74696d655374616d70
      }
      
      report = uint256(stamp) + uint256(uint256(report)<<128) + uint256(nb << 64) + uint256(getInstallTime(dHash));      // nb of members in group
    
      if (command == 0) return (report,   getGWProxy(dHash),getProxyToken(dHash),address(this),abi32);                   // complete GWF domain report
      if (command == 1) return (stamp,    getGWProxy(dHash),getProxyToken(dHash),address(this),abi32);                   // only timeStamp of installation
    }
    
    function _assignMemberDomainNames(bytes32[] memory _mem) private returns (address[] memory, uint256[] memory) {
      bytes32 _dHash            = _mem[0]; 
      uint l                    = _mem.length-5;                                                          // 5 words
      uint256 amount            = uint256(uint256(msg.value) / uint256((l/5) + 3));                       // ether transferred to each member, 1 for PT, 1 for PGW, 1 remains for GWF

      address[] memory GWowners = new address[](l/5);                                                     // create array of owners()
      uint256[] memory GTowners = new uint256[]((l/5)+2);                                                 // create array of tokenOwner
      bytes memory abiCmd       = abi.encodePacked(K_ABI80,K_ABI80,K_ABI80,bytes32(uint256((l/5)+1)<<5)); // setABI 128

      {
        address o;
        bytes32 d;
        
        uint i=5;
        uint nb = 0;
        do {
          o = address(uint160(uint256(_mem[i+2]) & K_AMASK));                   // owner address 
          d = _mem[i+1];                                                        // domainLabel hash 6, 11, 16...  _mem[i+1] = domain label hash 'vitalik.ethereum.eth'
          
          my_require(o!=k_add00 && _mem[i]!=0x0 && d!=0x0, "v4");               // 5, 9, 13... _mem[i] = label hash 'vitalik' || ENSV3: label str with length (bytes32)
          
          GWowners[nb] = o;                                                     // array of nb owners()
          GTowners[nb] = uint256(_mem[i+2]);                                    // _mem[i+2] array of tokenOwner uint256 contains share and address
          
          abiCmd       = abi.encodePacked(abiCmd,_mem[i+3]);                    // _mem[i+3] + 1 abi extra word 8, 13, 18... 

          my_require(payable(address(uint160(o))).send(amount),"v5");           // member gets funded
          emit Deposit(address(uint160(o)),amount);
          
          if (!isENSV3()) base.ens().setSubnodeRecord(_dHash,_mem[i],address(this), address(resolverContract), __time()); // assign ENS name e.g. vitalik.ethereum.eth
          else                    _setSubnodeRecordV3(_dHash,_mem[i],address(this),0);
          
          _setAvatar(d, bytesToStr(_mem[i+4],32));                              // _mem[i+4]  avatar url
          _setOwner(d,o,_mem[i],_dHash);                                        // _mem[i+0] labelHash | labelStr, depending on isENSV3()

          nb++;
          i = i+5;
        } while ((i-5)<l&&i<=160);
      }

      resolverContract.setABI(_dHash,128,abi.encodePacked(abiCmd,_mem[2]));     // member addresses to ABI, one extra ABI 128 word
      return (GWowners,GTowners);
    }

    function inviteInstallToken_q31n(bytes32[] memory _mem) public nonReentrant initiatorOrThisGWF(_mem[0]) payable {      
      bytes32 _dHash = _mem[0];                                                                         // _mem[0] domain hash identifying project/group, s.a. "silvias-bakery.eth"
      bytes32 dlHash = keccak256(abi.encodePacked(_dHash,K_TKLABELHASH));                               // hash of "token.silvias-bakery.eth" | "token.bakery.lisk"
      uint l         = _mem.length-5;                                                                   // 5 words
      uint256 amount = uint256(uint256(msg.value) / uint256((l/5) + 3));                                // ether transferred to each member, 1 for PT, 1 for PGW, 1 remains for GWF
      uint256 c      = commitments[_dHash];                                                             // low 160 bits = owner address, getGWProxy()
      my_require(l>=10 && l<=160 && address(uint160(uint256(_mem[1])))!=address(0) && msg.value>0,"w"); // msg.sender, l = l*5, masterCopy, value
      
      (address[] memory GWowners, uint256[] memory GTowners) = _assignMemberDomainNames(_mem);          // owners addresses, tokenOwners contains share + address


      ProxyGroupWallet proxyGW = new ProxyGroupWallet(address(uint160(uint256(_mem[4]))),                          // _mem[4] = masterCopy === GroupWalletMaster GWM
                                                      concat(bytes32( uint256(_mem[3]) | K_LC ), tld()),           // _mem[3] --> domainname.toLowerCase(), s.a. "melody-woman.lisk"
                                                      reverseContract);                                            // reverse registry

      {
        AbstractGwfGwp(address(proxyGW)).newProxyGroupWallet_j5O{value: amount}( GWowners );                       // initialize list of owners
        
        if (!isENSV3()) {                                                                                          // Only EVM Names === ENSV2, no NameWrapper, UUNS
          base.ens().setSubnodeRecord(_dHash,K_TKLABELHASH,address(this),address(resolverContract), __time());     // assign ENS name, s.a. "token.bakery.lisk", temp. owned by GWF
          _setAvatar(dlHash,'');                                                                                   // proxyToken contract with default avatar
        }

        commitments[_dHash] = uint256(uint160(address(proxyGW)) & K_AMASK) + uint256(c & K_COMMITMASK);            // save initiator = GWP-GroupWalletProxy owner
        emit ProxyGroupWalletCreation(proxyGW);
      }

      {
        string memory dName = string(abi.encodePacked('token.',concat(bytes32( uint256(_mem[3]) | K_LC ),tld()))); // e.g. token domain name: "token.silvias-bakery.lisk"
        ProxyToken proxy    = new ProxyToken( address(uint160(uint256(_mem[1]))),dName,reverseContract );          // install ProxyToken contract: masterCopy, domain name, reverse
        

        if (isENSV3()) {                                                                                           // Only ENS on Ethereum mainnet, NameWrapped ENS
          _setSubnodeRecordV3_token(_dHash, address(this));                                                        // assign ENS name, s.a. "token.silvias-bakery.eth", temp. owned by GWF
          _setAvatar(dlHash,'');                                                                                   // proxyToken contract with default avatar
          resolverContract.setAddr(dlHash,address(proxy));                                                         // assign proxyToken resolved address = tokenProxy
          _setSubnodeRecordV3_token(_dHash,address(proxy));                                                        // proxyToken owns "token.silvias-bakery.eth", finally owned by proxy

          ensNameWrapper.setRecord(_dHash,address(proxyGW),address(resolverContract),0);                           // transfer ownership from the GWF to the group GWP
        }
        else
        {
          resolverContract.setAddr(dlHash,address(proxy));                                                         // assign proxyToken resolved address = tokenProxy
          base.ens().setOwner(dlHash,address(proxy));                                                              // proxyToken owns "token.bakery.lisk", finally owned by proxy
        }
       
        
        _setOwner(_dHash,address(proxyGW),0x0,_dHash);                                                             // set resolved address, default avatar url


        GTowners[(l/5)+0] = uint256(_mem[3]);                                                                      // tokenName = domain name, e.g. "Mydomain.eth"
        GTowners[(l/5)+1] = uint256(uint160(address(proxyGW)));                                                    // GroupWalletProxy contract address, GWP

        ITokenProxy(address(proxy)).newToken{value: amount}( GTowners );                                           // call proxy, assign group shares to members, GWP amd TP
      
        installations[ uint64( (uint256(c & K_COMMITMASK)>>160) & K_COMMIT2Mask ) ] = 
                       uint256( uint160(address(proxy)) ) + 
                       uint256( (uint256(__time()+1)<<160) & K_COMMITMASK );                                       // saveProxyToken(proxy,_dHash) && saveInstallTime(time+1,_dHash)
        
        emit ProxyTokenCreation(proxy);     
      }
    }

    function _setSubnodeRecordV3(bytes32 _dHash,bytes32 _labelStr,address _owner,uint64 _timeStamp) private {
      ensNameWrapper.setSubnodeRecord(_dHash,fromBytes32(_labelStr),_owner,address(resolverContract),_timeStamp,0,0);
    }

    function _setSubnodeRecordV3_token(bytes32 _dHash, address _owner) private {
       ensNameWrapper.setSubnodeRecord(_dHash,'token',_owner,address(resolverContract),0,0,0); 
    }

    // Upgrade mechanism: GroupWalletFactory may have changed, perhaps a bug fix. Therefore, upgradeGWF() reallocates GWP of _dHash 

    // importGWP() gets only called by another GWF, the one that will be updated and replaced by a newer one.

    function importGWP(bytes32 _dHash, uint256 commitment, uint256 installation) external nonReentrant ungravelUUNS(_dHash) { // gets called by another GWF      
      address _GWP = AbstractGwf(msg.sender).getGWProxy   (_dHash);                                           // GWP from sending GWF
      address _PT  = AbstractGwf(msg.sender).getProxyToken(_dHash);                                           // PT  from sending GWF

      my_require( version()>AbstractGwf(msg.sender).version()                                             &&  // only version upgrades allowed
                  installations[ uint64( (uint256(commitment & K_COMMITMASK)>>160) & K_COMMIT2Mask ) ]==0 &&  // no Group entry yet
                  address(uint160(commitment & K_AMASK))==_GWP &&                                             // commitment   contains GWP = GroupWalletProxy contract
                  address(uint160(uint256(installation) & K_AMASK))==_PT &&                                   // installation contains PT  = ProxyToken       contract
                  commitments[_dHash]==0,                                                                     // no commitment with this _dHash
             "y"); 

      installations[ uint64( (uint256(commitment & K_COMMITMASK)>>160) & K_COMMIT2Mask ) ] = installation;    // store installation slot
      commitments[_dHash] = uint256(uint160(_GWP) & K_AMASK) + uint256(commitment & K_COMMITMASK);            // store commitments  slot
    }

    // Group votes on upgrade, then GWP calls upgradeGWF(). Even the GWF upgrade requires a majority vote.

    function upgradeGWF(bytes32 _dHash, address _GWF) external onlySameDeployers(_GWF) onlyUUNSgwp(_dHash) payable { // *** MUST be called by a GWP contract belonging to UNGRAVEL UUNS ***
      uint256 c = commitments[_dHash];                                              // commitment word
      my_require(_dHash!=0x0 && address( uint160(c & K_AMASK) )==msg.sender,"u");   // called by GWP that owns commitment
      AbstractGwf(_GWF).importGWP(_dHash,c,installations[ getCommitment(_dHash) ]); // call remote GWF to import current GWP
    }
    
    function replicate_group_l9Y(bytes32[] calldata _m, bytes calldata data32, bytes32[] calldata _mem) external onlyGWPorOwner(msg.sender,_m[0]) payable { // gets called by initiator / default account | by GWP confirmSpinOffGroup_L51b()
      // This function performs a replication of an entire group.
      // OR: This function performs the spin-off of a new group, completing a split group.
      uint256 v = 0;
    
      if (_m.length==4) {                                                       // replicate group, called from outside, sendReplicateGroup_GWF() called by collectAvatarsReplicate_GWF() by Replicate Group(4) run by 'replicating' ChainScript
        v = uint256(_m[2]) & K_RENTMASK;
        my_require(msg.value>0 && v>0 && msg.value>v && __isInitiator(_m[0]),"G");
        (this).registerAndLock_x3x{value: v}( _m, data32 );
      }
      
      if (_m.length==1) {                                                       // confirm spin-off group, called by GWP, confirmSpinOffGroup_L51b()  executeSpinOffProcessing()
        my_require(__isSenderGWP(msg.sender)&&__isHashOwner(_mem[0]),"rH");     // isSenderGWP() --> msg.sender leads to a GWP, GWP is msg.sender   spinoff hash = _mem[0], owned by GWP
        (this).lock_dfs(_mem[0], data32);
      }
      
      v = msg.value/25;                                                         // 4% contract provision, Ungravel funding
      (this).inviteInstallToken_q31n{value: uint256(msg.value)-v}( _mem );
    }
    

    // setTokenPrices(), transferOwner(), transferToken(), transferTokenFrom() : methods that may be called by the GWP only, since GWP owns _dHash

    //function transferOwner_v3m(bytes32 _dHash, bytes memory data) public onlyInitiator(_dHash) payable {     // calls TP, transferOwnership_m0(address): 0x0000e7f1 *** only during development and debugging ***
    //  address tProxy = __proxyToken(_dHash);
    //  // solium-disable-next-line security/no-inline-assembly
    //  assembly {
    //    if eq(call(gas(), tProxy, 0, add(data, 0x20), mload(data), 0, 0), 0) { revert(0, 0) }
    //  }
    //  emit TransferOwner(_dHash); 
    //}

    //function setTokenPrices_dgw(bytes32 _dHash, bytes memory data) public onlyInitiator(_dHash) payable {    // calls TP, setPrices_7d4(uint256,uint256) 0x000084f3 *** only during development and debugging ***
    //  address tProxy = __proxyToken(_dHash);
    //  // solium-disable-next-line security/no-inline-assembly
    //  assembly {
    //    if eq(call(gas(), tProxy, 0, add(data, 0x20), mload(data), 0, 0), 0) { revert(0, 0) }
    //  }
    //  emit SetPrices(_dHash);
    //}
  
    //function TransferToken_8uf(bytes32 _dHash, bytes memory data) public onlyInitiator(_dHash) payable {     // calls TP, transfer_G8l(address,uint256) 0x0000c771 *** only during development and debugging ***
    //  address tProxy = __proxyToken(_dHash);
    //  // solium-disable-next-line security/no-inline-assembly
    //  assembly {
    //    if eq(call(gas(), tProxy, 0, add(data, 0x20), mload(data), 0, 0), 0) { revert(0, 0) }
    //  }
    //  emit Transfer(address(this), address( uint160(uint256( uint256(mb32(substring(data,4,32))) & K_AMASK ))), uint256( mb32(substring(data,36,32)) ) / 100);
    //}

    //function TransferTokenFrom_VCv(bytes32 _dHash, bytes memory data) public onlyInitiator(_dHash) payable { // calls TP, transferFrom_78S(address,address,uint256) 0x00008711 *** only during development and debugging ***
    //  address tProxy = __proxyToken(_dHash);
    //  // solium-disable-next-line security/no-inline-assembly
    //  assembly {
    //    if eq(call(gas(), tProxy, 0, add(data, 0x20), mload(data), 0, 0), 0) { revert(0, 0) }
    //  }
    //  emit Transfer(address( uint160(uint256( uint256(mb32(substring(data,4,32))) & K_AMASK ))), address( uint160(uint256( uint256(mb32(substring(data,36,32))) & K_AMASK ))), uint256( mb32(substring(data,68,32)) ) / 100);
    //}
    
    //

    function withdraw() external onlyByOwner {
      payable(msg.sender).transfer(__selfbalance()-1);
    }

    function setAuctionsContract(AbsAuctionRegistrar auctCtr) external onlyByOwner payable {
      my_require(address(auctCtr)!=address(0),"oO");
      auctionContract = auctCtr;
    }

    function setMultifourContract(AbsMultiFour multiCtr) external onlyByOwner payable {
      my_require(address(multiCtr)!=address(0),"oM");
      multifourContract = multiCtr;
    }

    function tld() public view returns (string memory) {
      return multifourContract.tld();
    }
    
    function version() public pure returns(uint256) {
      return 20010136;
    }
    
    function receivePayment() external payable returns(bool) {                  // receive e.g. ungravel license fees
      emit Deposit(msg.sender, msg.value);
      return true;
    }

    receive() external payable {      
      if (msg.value==0) return;                                                 // no payment at all
      emit Deposit(msg.sender, msg.value);
    }

    constructor ( AbstractEthRegController  _controller,
                  AbstractGwfResolver         _resolver, 
                  AbstractBaseRegistrar           _base,
                  AbstractGwfEns                   _ens,
                  AbstractGwfReverseRegistrar  _reverse, 
                  NameWrapper                 _nwrapper,
                  AbsAuctionRegistrar    _auctionMaster,
                  AbsMultiFour               _multifour
                ) payable
    {

      require(address(_controller)!=address(0) && address(_resolver)!=address(0) && address(_base)!=address(0) && address(_multifour)!=address(0) &&
              address(_ens)!=address(0)        && address(_reverse)!=address(0)  && address(_auctionMaster)!=address(0),"CON");

      GWFowner                          = msg.sender;
      
      controllerContract                = _controller;
      resolverContract                  = _resolver;
      base                              = _base;
      ens                               = _ens;
      reverseContract                   = _reverse;
      ensNameWrapper                    = _nwrapper;
      auctionContract                   = _auctionMaster;
      multifourContract                 = _multifour;

      // ENS reverse resolver entry of address(this) ---> "factory.ungravel.eth" | "factory.ungravel.lisk"
      _reverse.setName(string(abi.encodePacked('factory.ungravel',multifourContract.tld()))); // claiming / assigning reverse resolver record
    }
}

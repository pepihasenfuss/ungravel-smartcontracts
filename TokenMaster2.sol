// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.30;

//   ungravel.eth, GroupWalletFactory, GroupWalletMaster, GroupWallet, ProxyWallet, TokenMaster, ProxyToken, PrePaidContract, AuctionMaster, BiddingProxy, 
//   intDeedMaster, extDeedMaster, IntDeedProxy, Intentions, UngravelGlobalToken by pepihasenfuss.eth 2017-2025, Copyright (c) 2025

//   GroupWallet and ungravel is entirely based on Ethereum Name Service, "ENS", the domain name registry.
//   inspired by parity sampleContract, Consensys-ERC20 and openzeppelin smart contracts

//   ENS, ENSRegistryWithFallback, PublicResolver, Resolver, FIFS-Registrar, Registrar, AuctionRegistrar, BaseRegistrar, ReverseRegistrar, 
//   DefaultReverseResolver, ETHRegistrarController, PriceOracle, SimplePriceOracle, StablePriceOracle, ENSMigrationSubdomainRegistrar, CustomRegistrar,  
//   Root, RegistrarMigration are contracts of "ENS", by Nick Johnson and team.
//
//   Copyright (c) 2018, True Names Limited / ENS Labs Limited
//
//   Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), 
//   to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, 
//   and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//
//   The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
//   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, 
//   WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


//   TokenMaster2 creates group shares, ERC20 token. It is a master contract for Ungravel ProxyToken.

//   Each Ungravel Group deploys its own group share token contract, a ProxyToken contract.

//   TokenMaster handles the distribution of shares, selling and buying within a group, sending and
//   transferring of group shares. In the beginning, group shares have only symbolic value, while their
//   distribution reflects the shareholder structure. Group shares are important to balance the 
//   structure of the group, they can be used to promote members, to incentivize member activity,
//   to provide liquidity to the group wallet and to incentivize member deposits to fund the group.
//   Later, group shares are offered for sale to external investors, therefore, groups may become valuable.


interface IntGwp {
  function getIsOwner(address _owner)      external view returns (bool);
  function getOwners()                     external view returns (address[] memory);
  function getTransactionsCount()          external view returns (uint);
  function getTransactionRecord(uint _tNb) external view returns (uint256);
  function getGWF()                        external view returns (address);
  function getAllTransactions()            external view returns (uint256[] memory transArr);
  function getMasterCopy()                                                    external view returns (address);
  function nameAuctionBidBucketLabel(bytes32 labelhash, address deedContract) external;
  function reserveAuctionENSname(uint _tId, uint _pay, address deedContract) external;
}
contract AbstractBaseR {
  event NameMigrated(uint256 indexed id, address indexed owner, uint expires);
  event NameRegistered(uint256 indexed id, address indexed owner, uint expires);
  event NameRenewed(uint256 indexed id, uint expires);
  bytes32 public baseNode;                                                      // The namehash of the TLD this registrar owns (eg, .eth)
}
interface IAbstractTmEns {
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
interface ITmResolver {
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
abstract contract AbstractTmReverseRegistrar {
  IAbstractTmEns public ens;
  ITmResolver public defaultResolver;
  function setName(string memory name) external virtual returns (bytes32);
  function node(address addr) external virtual pure returns (bytes32);
}
abstract contract AbstractRr {
  ITmResolver public defaultResolver;
  function node(address addr) external virtual pure returns (bytes32);
}
abstract contract AbsTmNameWrap { // NameWrapper is used by the ENS on Ethereum mainnet or Sepolia, only needed on ENS3 compatible chains
  function setSubnodeRecord(bytes32 parentNode,string memory label,address owner,address resolver,uint64 ttl,uint32 fuses,uint64 expiry) external virtual returns (bytes32 node);
  function setSubnodeOwner(bytes32 node,string calldata label,address newOwner,uint32 fuses,uint64 expiry) external virtual returns (bytes32);
  function ownerOf(uint256 id) external virtual view returns (address);
  function setApprovalForAll(address operator,bool approved) external virtual;
}
abstract contract AbstractGwf {
  ITmResolver                     public  resolverContract;
  IAbstractTmEns                  public  ens;
  AbstractBaseR                   public  base;
  AbstractRr                      public  reverseContract;
  AbsTmNameWrap                   public  ensNameWrapper;
  address                         public  GWFowner;
  function getProxyToken(bytes32 _domainHash) external view virtual returns (address p);
  function getGWProxy(bytes32 _dHash) external view virtual returns (address);
  function getIsOwner(bytes32 _dHash,address _owner) external view virtual returns (bool);
  function getOwner(bytes32 _domainHash) external view virtual returns (address);
  function domainReport(string calldata _dom,uint command) external payable virtual returns (uint256 report,address gwpc,address ptc,address gwfc,bytes memory structure);
  function getGWF() external view virtual returns (address);
  function tld() public view virtual returns (string memory);
}
abstract contract AbstractTm {
  address internal masterCopy;
  bytes32 internal name32;
  uint256 private ownerPrices;                                                  // buyPrice, sellPrice, owner address
  mapping(address => uint256)                     private balances;
  mapping(address => mapping(address => uint256)) private allowed;
  AbstractTmReverseRegistrar public reverse;                                   // ENS reverse registry contract

  function getMemberBalances(bytes32 hash,address gwfc) external view virtual returns (uint[] memory);
  function balanceOf(address tokenOwner) external view virtual returns (uint thebalance);
  function sellPrice() external view virtual returns (uint256 sp);
  function buyPrice() external view virtual returns (uint256 bp);
  function name() external view virtual returns (string memory);
  function owner() external view virtual returns (address ow);
  function getMasterCopy() external view virtual returns (address);
}
abstract contract AbstractTpc {
  address public masterCopy;
  function upgrade(address master) external virtual payable;
  function version() public pure virtual returns(uint256 v);
  function name() external view virtual returns (string memory);
}
abstract contract AbstractGwpc {
  function getMasterCopy() external view virtual returns (address);
  function upgrade(address master) external virtual payable;
}
abstract contract AbsMultiFour {
  address     public masterCopy; // deployer, owner of this contract
  AbstractGwf public GWF;        // GroupWalletFactory Ungravel.com
  event Deployment(address owner, address theContract);
  event DeploymentMulticall4(address theContract, bytes32 dhash);
  event Deposit(address from, uint256 value);
  function tld() public virtual view returns (string memory);
  function chainName() public virtual view returns (string memory);
}
//---------------------------------------------------------------------------------------------
// The PrePaid Account (PPA) is a concept to fund a brand-new, self-managed ethereum address,
// without involving any third-party wallet, plug-in or bridge. A PPA is self-managed funding of 
// a fresh Ungravel working address to use Ungravel independently.

// Therefore, this PrePaidContract gets deployed, waiting for funding that instantly gets forwarded
// to the new address. PPA and address are created by user interaction using the Ungravel dApp.

// The PrePaid Account concept allows funding without importing any wallet file, pKey and
// without "connecting" third-party products to the dApp. We consider this a concept
// of enhencing overall security and improving independence. Practically, it renders third party 
// wallets obsolete while using Ungravel. All it needs, is a single transaction from anywhere,
// completely wallet-agnostic, independed from any account or wallet product.
// You may use a managed account from an exchange, s.a. kraken or coinbase, to fund the PPA.
// You my also use a self-custody account to fund the PPA.

// We believe that PPA simplifies dApp adoption and enhances user experience.
// Hint: Ungravel exports your PPA to a safe wallet file and stores the file locally on your computer.
// Ungravel allows to export and to import account information, using key files, aka wallet files.

pragma solidity 0.8.30;
contract PrePaidContract {
    address public immutable  pp_account;                                       // brand-new Prepaid Account address, waiting to be funded
    address private immutable pp_owner;                                         // Ungravel deployer
    event PrePaidCreated(address indexed);                                      // event triggers PrePaid modal dialog
    event DepositPrePayment(address from, uint256 value);                       // event triggers PrepPaid Account init & use, dApp makes ppa the working account
    
    uint256 private _guardCounter  = 1;

    modifier nonReentrant() {
      _guardCounter += 1;
      uint256 localCounter = _guardCounter;
      _;
      require(localCounter == _guardCounter,"r");
    }

    function __balance() private view returns(uint) {
      return address(this).balance;
    }

    constructor(address _account, string memory _ppaName, AbstractTmReverseRegistrar reverse) payable {
      assert(_account!=address(0)&&address(reverse)!=address(0));
      pp_account = _account;                                                    // a fresh (and empty) EVM account, self-managed by dApp
      pp_owner   = AbstractTm(AbstractTpc(msg.sender).masterCopy()).getMasterCopy(); // msg.sender is ProxyToken contract, master of master is Ungravel deployer
      emit PrePaidCreated(address(this));                                       // event triggers PrePaid - wait-for-funding - modal dialog
      reverse.setName(_ppaName);                                                // only on mainnet|unichain|lisk, adjust registerPrePaidBucket() call for other chains
    }

    receive() external nonReentrant payable {                                   // catch all calls and forward any payment to PrePaid Account
      if (msg.value==0) return;                                                 // no payment at all
      uint256 gasPrice;
      assembly { gasPrice := gasprice() }                                       // compute cost of PrePaidContract deployment
      payable(pp_account).transfer(msg.value-uint(gasPrice*630296));            // compensate Ungravel deployer for deployment cost
      payable(pp_owner).transfer(address(this).balance);                        // forwarding deposit/funding minus cost of transaction
      require(__balance()==0,"p");                                              // security check
      emit DepositPrePayment(msg.sender, msg.value);                            // event triggers PrepPaid Account initialization of the dApp
    }
}
//---------------------------------------------------------------------------------------------
// TokenMaster2 creates group shares, ERC20 token. It is a master contract for Ungravel ProxyToken.

// Each Ungravel Group deploys its own group share token contract, a ProxyToken contract.

// TokenMaster handles the distribution of shares, selling and buying within a group, sending and
// transferring group shares. In the beginning, group shares have only symbolic value, while their
// distribution reflects the shareholder structure. Group shares are important to balance the 
// structure of the group, they can be used to promote members, to incentivize member activity,
// to provide liquidity to the group wallet.

// Each Ungravel Group comes with a Voting Contract 
// that holds 100,000 shares and a ProxyToken contract, called "the reserve", holding another
// 100,000 group shares. Inside a group, members can buy and sell group shares, mainly to 
// make it as easy as possible to deposit funding for common affairs. Each group controls its 
// own funding and common assets in their GroupWallet, aka a multi-sig-wallet. 

// Group shares are the capital of each group, symbolic capital of informal groups IS capital.

// The very nature of informal team building is fragility and insecurity. Therefore, Ungravel
// stabilizes emerging teams by granting group shares, ENS domain names, a GroupWallet for 
// voting, a common group name and group description and the ENS group name itself.

// All assets belong to the group, they are common goods of each group, subject to majority vote.
// In case a group maturates and becomes valuable or renown, symbolic group shares may turn
// into convertible assets providing liquidity to the group.

// In this sense, group shares are needed from day one to enable Auction Funding and 
// investments into any group, in the future. Ungravel is a safe fund raising and
// investment tool that comes built into the DNA of each group from day one.

// Yet, any group may operate and work together without offering group shares at all.

// Ungravel is not preferring any type of group structure or use, hence, fund raising and 
// Funding Auctions are considered very powerful tools for every group, if needed.

// This TokenMaster contract also organizes PrePaid Accounts, PPA, a safe and straight-forward
// method to get started with a bit of funding without depending on third-party wallets.
// PrePaid Accounts offer an easy way to explore Ungravel without disclosing any account
// information. A simple transaction to the PPA is enough to enter Ungravel.

contract TokenMaster2 {
    address internal masterCopy;

    bytes32 internal name32;
    uint256 private ownerPrices;                                                                            // buyPrice, sellPrice, owner address
    mapping(address shareHolder => uint256 balance)                                       private balances;
    mapping(address shareHolder => mapping(address targetContract => uint256 nbOfShares)) private  allowed;
    AbstractTmReverseRegistrar public immutable reverse;                                                    // ENS reverse registry
    
    uint256 constant K_BUYPR        = 1 ether / 1e4;                                                        // price per share
    uint256 constant K_SELLPR       = K_BUYPR - (K_BUYPR/10);
    uint256 constant K_SELLBUY      = uint256( (uint256(uint256(K_BUYPR)<<160) + uint256(uint256(K_SELLPR)<<208)) & KPMASK );
    uint256 private _guardCounter   = 1;
    
    uint256 constant CONTRATSHARE   = uint256(1000000*10*2); // 10% ProxyToken contract reserve, 10% GroupWallet contract reserve
    uint256 constant CONTRATSHARE2  = uint256(1000000*10*1);
        
    uint256 constant KAMASK         = 0x000000000000000000000000ffffffffffffffffffffffffffffffffffffffff;
    uint256 constant KSMASK         = 0xffffffffffff0000000000000000000000000000000000000000000000000000;
    uint256 constant KBMASK         = 0x000000000000ffffffffffff0000000000000000000000000000000000000000;
    uint256 constant KMASK          = 0x0000000000000000000000000000000000000000000000000000ffffffffffff;
    uint256 constant KPMASK         = 0xffffffffffffffffffffffff0000000000000000000000000000000000000000;
    uint256 constant KSHAREMASK     = 0x0000000000000000000000000000000000000000ffffffffffffffffffffffff;
    bytes32 constant KLOWERCASE     = 0x2000000000000000000000000000000000000000000000000000000000000000;

    event TestReturn(uint256 v1, uint256 v2, uint256 v3, uint256 v4);
    event Transfer(address indexed from, address indexed to, uint256 value);
    event FrozenFunds(address target, bool frozen);
    event Deposit(address from, uint256 value);
    event Deployment(address owner, address theContract);
    event Approval(address indexed owner,address indexed spender,uint256 value);
    event UpgradeTokenMaster(address tokenProxy, address newMasterContract);
    event UpgradeGWallet(address gwp, address newMasterContract);
    event PrePaidBucketInstalled(address theContract, address receiver);

    modifier nonReentrant() {
      _guardCounter += 1;
      uint256 localCounter = _guardCounter;
      _;
      require(localCounter == _guardCounter,"r");
    }
    modifier onlyByGWF() {
      // in case of a proxy call, this is the owner of the tokenProxy contract, aka GWF contract
      // in case of a master call, to this master contract, this is the deployer address.
      my_require(msg.sender == __owner(),"R"); 
      _;
    }
    modifier sameDeployer(address _master) {
      my_require(_master!=address(0) && AbstractTm(masterCopy).owner()==AbstractTm(_master).owner(),"D");
      _;
    }
    modifier onlyGWP(bytes32 _dHash) { // Assert that GWP belongs to Ungravel Unified Name Space (UUNS)
      my_require(__onlyByGWP(_dHash),"Q");
      _;
    }
    modifier onlyGWF() { // deploying and initializing a new tokenProxy contract
      my_require(ownerPrices==0 && AbstractGwf(msg.sender).getGWF()==msg.sender,"F");
      _;
    }
    modifier onlyAuction(bytes32 _dHash) {
      (address auctContractAddr, uint tNb) = auctionTransactionRecord(_dHash);
      my_require(auctContractAddr==msg.sender && tNb>=0,"d");
      _;
    }
    modifier onlyPPADeployer(bytes32 _dHash) {
      // check for the address of the prepaid account deployer, aka ppa_deployer
      // node "ppa.ungravel.eth" | "ppa.ungravel.uni" | "ppa.ungravel.lisk"  ---- getting ppa deployer address from Unified Name Space
      address ppa_deployer = ITmResolver(_gwf().resolverContract()).addr(getNodeHash(string(abi.encodePacked('ppa.ungravel',_gwf().tld())), address(_gwf())));

      IntGwp gwp      = _getGwProxyDmHash(_dHash);

      my_require(                                                                                                      // GWP transactions && GWM deployer===initiator
                 ((msg.sender==IntGwp(gwp.getMasterCopy()).getMasterCopy()) || (msg.sender==ppa_deployer)) &&
                 gwp.getTransactionsCount()>0,
             "V");
       _;
    }
    modifier onlyGroupMember() {
      my_require(__member()||(address(_getGwProxyDmHash(__gwHash()))==msg.sender),"O");
      _;
    }
    modifier hasShares(address _receiver) {
      my_require(_receiver!=address(0) && balances[msg.sender]!=0,"T");
      _;
    }

    // low-level functions

    function __owner() private view returns (address) {
      return address(uint160(ownerPrices & KAMASK)); // ProxyToken returns GWF, TokenMaster deployer
    }
    function __gwHash() private view returns (bytes32) {
      return keccak256( abi.encodePacked( AbstractBaseR(_gwf().base()).baseNode(), keccak256( abi.encodePacked( bytes32ToStr( bytes32(name32 | KLOWERCASE) ) ) ) ) );
    }
    function __member() private view returns (bool) {
      return _getGwProxyDmHash(__gwHash()).getIsOwner(msg.sender);
    }
    function __onlyByGWP(bytes32 _dHash) private view returns (bool) {
      return(
              _dHash!=0x0                                                                                 &&   // GWP has ENS reverseRegistry entry,
              reverse.ens().recordExists( reverse.node(msg.sender) )                                      &&   // ens registry node / record exists,
              IntGwp(msg.sender).getGWF()==address(_gwf())                                                &&   // GWF contract as is expected,
              bytes32(IntGwp(msg.sender).getTransactionRecord(uint256(uint160(address(_gwf())))))==_dHash &&   // dHash of GWP is valid as is expected,
              _gwf().getOwner(_dHash)==msg.sender                                                                   // msg.sender fits _dHash, is GWP
            );
    }

    function my_require(bool b, string memory str) private pure {
      require(b,str);
    }
    
    // ----------------------- ERC20 -------------------------------------------

    function getMasterCopy() public view returns (address) {
      return masterCopy;
    }
    
    function owner() external view returns (address) {
      return address(uint160(ownerPrices & KAMASK));              // ProxyToken returns GWF, TokenMaster deployer
    }

    function _gwf() private view returns (AbstractGwf) {
      return AbstractGwf(address(uint160(ownerPrices & KAMASK))); // ProxyToken returns GWF, TokenMaster deployer
    }
    
    function name() public view returns (string memory) {
      return bytes32ToStr(name32);
    }
    
    function standard() external pure returns (string memory) {
      return 'ERC-20';
    }
    
    function symbol() external pure returns (string memory) {
      return 'shares';
    }
    
    function decimals() external pure returns (uint8) {
      return  2;
    }
    
    function totalSupply() external pure returns (uint256) {
      return 1.2e8;
    }
    
    function sellPrice() external view returns (uint256) {
      return uint256( (uint256( ownerPrices & KSMASK )>>208) & KMASK );
    }
    
    function buyPrice() external view returns (uint256) {
      return uint256( (uint256( ownerPrices & KBMASK )>>160) & KMASK );
    }
    
    function balanceOf(address tokenOwner) external view returns (uint) {
      return balances[tokenOwner]>>1;
    }
    
    function tokenAllow(address tokenOwner,address spender) external view returns (uint256) {
      my_require(tokenOwner!=address(0)&&spender!=address(0),"T");
      return allowed[tokenOwner][spender];
    }
    
    function saveOwner(uint256 buyP,uint256 sellP,address own) private pure returns (bytes32 o) {
      return bytes32( uint256(uint256(buyP)<<160) + uint256(uint256(sellP)<<208) + uint256(uint160(own)) );
    }
    
    function getResolverReport(bytes32 hash) external view returns(address rslv_owner,address gwp,bytes memory abi32_,bytes memory abi128_,address[] memory GWPowners ) {
      AbstractGwf gwfc = _gwf();                                                      // GWF - GroupWalletFactory contract
      IntGwp      gwpc = IntGwp(gwfc.getGWProxy(hash));
      
      (, bytes memory abi32 ) = gwfc.resolverContract().ABI(hash,32 );
      (, bytes memory abi128) = gwfc.resolverContract().ABI(hash,128);
            
      return (gwfc.ens().owner(hash), address(gwpc), abi32, abi128, gwpc.getOwners());
    }
    
    function tokenReportBalances(bytes32 hash) external view returns (uint256[] memory, address[] memory GWPowners, uint[] memory balArr ) {      
      AbstractGwf gwfc  = _gwf();                                      // GWF - GroupWalletFactory contract
      address     gwpc  = gwfc.getGWProxy(hash);                       // GWP - GroupWalletProxy contract
      
      GWPowners = IntGwp(gwpc).getOwners();
      
      uint256[] memory token = new uint256[](10);
      
      token[0] = uint256(uint160(address(gwfc)));
      token[1] = uint256(uint160(gwpc));
      token[2] = 2;
      token[3] = uint256( (uint256( ownerPrices & KSMASK )>>208) & KMASK );
      token[4] = uint256( (uint256( ownerPrices & KBMASK )>>160) & KMASK );
      token[5] = uint256(balances[address(this)]>>1);
      token[6] = uint256(balances[gwpc]>>1);
      token[7] = uint256(bytes32(name32 | KLOWERCASE));
      token[8] = uint256(gwpc.balance);
      token[9] = uint256(address(this).balance);
      
      balArr = AbstractTm(address(this)).getMemberBalances(hash,address(gwfc));

      return ( token, GWPowners, balArr );
    }
    
    function getMemberBalances(bytes32 hash, address gwfc) external view returns (uint[] memory) {
      address gwpc = AbstractGwf(gwfc).getGWProxy(hash);                        // GWP - GroupWalletProxy contract
      address ptc  = AbstractGwf(gwfc).getProxyToken(hash);                     // PT  - ProxyToken contract

      address[] memory l_ownerArr = IntGwp(gwpc).getOwners();                   // owners
            
      uint m               = l_ownerArr.length*2;
      uint t               = IntGwp(gwpc).getTransactionsCount();
      uint[] memory balArr = new uint[](m+t);
      
      uint[] memory tArr   = IntGwp(gwpc).getAllTransactions();
      
      address memAddr;
      uint i=0;
      do {
        memAddr         = l_ownerArr[i];
        
        balArr[i*2]     = uint(memAddr.balance);                                // ETH or GLMR, native crypto currency of chain
        balArr[(i*2)+1] = uint(AbstractTm(ptc).balanceOf(memAddr));             // shares of TokenProxy contract
        
        i++;
      } while(i<l_ownerArr.length);

      if (tArr.length==0) return balArr;

      i=0;
      do {
        balArr[i+m] = uint256(tArr[i]);
        i++;
      } while(i<tArr.length);

      return balArr;
    }
    
    function getNodeHash(string memory dn, address gwfc) internal view returns (bytes32) {
      
      bytes32 hash = keccak256( abi.encodePacked( AbstractBaseR(AbstractGwf(gwfc).base()).baseNode(), 
                        keccak256( substring( bytes(dn), delArr(dn)[0]+1, delArr(dn)[1] - delArr(dn)[0] -1 ) ) ) ); // domain e.g. 'ethereum-foundation'

      return keccak256( abi.encodePacked( hash, keccak256( substring( bytes(dn), 0, delArr(dn)[0] ) ) ) );          // label  e.g. 'vitalik'
    }

    function _hasKeyValue(address _gwfc, string memory _nm, string memory _label) private view returns (bool) {
      return ( bytes( AbstractGwf(_gwfc).resolverContract().text( getNodeHash( _nm, _gwfc ), _label) ).length > 0 );
    }

    function getMemberReverseRecords(address gwpc, address gwfc) private view returns (uint256) {
      my_require(gwpc!=address(0x0),"MR");

      address[] memory owners = IntGwp(gwpc).getOwners();  // owners() - taken from GWPC

      bytes32 node;
      string memory nm;
      
      uint256 result = 0;
      uint256 m = 1;
      uint256 n = 1<<32;
      uint256 l = 1<<64;
      uint256 j = 1<<96;

      for (uint i = 0; i < owners.length; i++) {
        node = AbstractGwf(gwfc).reverseContract().node(owners[i]);
        nm   = ITmResolver(AbstractRr(AbstractGwf(gwfc).reverseContract()).defaultResolver()).name( node );
        
        if (( i<=31 ) && ( node != 0 )) result += j;
        
        if ( ( strlen(nm) > 0 ) && (i<32) ) {
          result += m;
          if ( _hasKeyValue(gwfc, nm, 'avatar') )       result += n;
          if ( _hasKeyValue(gwfc, nm, 'me_statement') ) result += l;
        }
      
        m = m*2;
        n = n*2;
        l = l*2;
        j = j*2;
      }
      
      return uint256( result );
    }
    
    function getDomainReport(string calldata _domain, address gwfc, bytes32 hash) external payable returns (uint256[] memory token, bytes memory structure, address[] memory GWPowners, uint[] memory balArr, bytes memory abi128_) {
      {
        if ( (gwfc==address(0x0)) || (gwfc!=address(AbstractGwf(gwfc).getGWF())) )
           return (new uint256[](0), bytes("gwfc!"), new address[](0), new uint[](0), bytes("gwfc!"));
      }
      
      (uint256 report_,address gwpc_,address ptc_,address gwfc_,bytes memory structure_) = 
         AbstractGwf(gwfc).domainReport(_domain,0);                             // GWF - Report on Domain, including structure abi32
      
      uint256[] memory tokenRep = new uint256[](15);

      {
        tokenRep[10] = report_;                                                 // report record with all flags
        tokenRep[11] = uint256(uint160(gwpc_));                                 // gwpc - GroupWalletProxy contract from the report
        tokenRep[12] = uint256(uint160(ptc_));                                  // ptc  - ProxyToken contract
        tokenRep[13] = uint256(uint160(gwfc_));                                 // gwfc - GroupWalletFactory contract
      
        if ( (gwpc_==address(0x0)) || (ptc_==address(0x0)) || (gwpc_==address(msg.sender)) ) {
          tokenRep[14] = block.chainid;
          string memory l_tld = AbstractGwf(gwfc).tld();
          return (tokenRep, structure_, new address[](0), new uint[](0), bytes(l_tld));
        }

        tokenRep[14] = getMemberReverseRecords(ITmResolver(AbstractGwf(gwfc).resolverContract()).addr(hash),gwfc);
      }
      
      {        
        balArr       = AbstractTm(address(this)).getMemberBalances(hash,gwfc_); // all transactins, allBalances, ETH and shares
        
        address gwpc = ITmResolver(AbstractGwf(gwfc).resolverContract()).addr(hash);
        if (address(gwpc)==address(0)) return (tokenRep, structure_, new address[](0), new uint[](0), bytes("gwpc"));

        GWPowners = IntGwp(gwpc).getOwners();                                   // owners() - taken from GWPC
        
        tokenRep[0] = uint256(uint160(address(IntGwp(gwpc).getGWF())));         // 10 records tokenReport
        tokenRep[1] = uint256(uint160(gwpc));
        tokenRep[2] = 2;
        tokenRep[3] = uint256(AbstractTm(ptc_).sellPrice());
        tokenRep[4] = uint256(AbstractTm(ptc_).buyPrice());
        tokenRep[5] = uint256(AbstractTm(ptc_).balanceOf(address(this)));
        tokenRep[6] = uint256(AbstractTm(ptc_).balanceOf(gwpc));
        tokenRep[7] = uint256(mb32(bytes( AbstractTm(ptc_).name() )));
        tokenRep[8] = uint256(gwpc.balance);
        tokenRep[9] = uint256(address(this).balance);
      }
      
      (uint256 ignore2, bytes memory abi128) = AbstractGwf(gwfc).resolverContract().ABI(hash,128);
      if (ignore2!=128) ignore2++;
      
      return (tokenRep, structure_, GWPowners, balArr, abi128);                 // token reports, abi32 structure, owners, balanceArr, abi128, tRecords
    }

    // --------------------- strings -------------------------------------------
    
    function strlen(string memory s) internal pure returns (uint) {
        uint len;
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
    function mb32(bytes memory _data) private pure returns(bytes32 a) {
      // solium-disable-next-line security/no-inline-assembly
      assembly {
          a := mload(add(_data, 32))
      }
    }
    function bytes32ToStr(bytes32 _b) internal pure returns (string memory) {
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
    function substring(bytes memory self, uint offset, uint len) public pure returns(bytes memory ret) {
        my_require(offset + len <= self.length,"s");

        ret = new bytes(len);
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
    function delArr(string memory s) internal pure returns (uint8[] memory) {
        uint8[] memory delimiter = new uint8[](2);
        
        uint len;
        uint nb = 0;
        uint i = 0;
        uint bytelength = bytes(s).length;
        for(len = 0; i < bytelength; len++) {
            bytes1 b = bytes(s)[i];
            
            if (b==0x2e) {
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
    
    // --------------------- ProxyToken ----------------------------------------

    function approve_v2d(address spender, uint tokens) external nonReentrant hasShares(spender) {
      uint balSender = balances[msg.sender];
      my_require(balSender>>1 >= tokens,"f");
      allowed[msg.sender][spender] += tokens;
      emit Approval(msg.sender, spender, tokens);
    }
    
    function transfer_G8l(address toReceiver, uint amount) external nonReentrant hasShares(toReceiver) { // 0x0000c771
        uint bal       = balances[toReceiver]>>1;
        uint balSender = balances[msg.sender];

        my_require(balSender>>1 >= amount && bal + amount >= bal, "t");
        
        balances[msg.sender] -= amount<<1;
        balances[toReceiver] += amount<<1;
        emit Transfer(msg.sender, toReceiver, amount);
    }

    function auctionTransactionRecord(bytes32 _dhash) internal view returns (address,uint) {
      uint256 k_typeMask = 0xf000000000000000000000000000000000000000000000000000000000000000;

      IntGwp gwp = _getGwProxyDmHash(_dhash);

      uint256 t;
      uint    i = gwp.getTransactionsCount();
      do {
        i--;
        t = gwp.getTransactionRecord(i);
      } while(i>0 && t>0 && (t & k_typeMask != k_typeMask));
      return (address(uint160(t & KAMASK)),i);
    }
    
    function transferAdjustPrices(address toReceiver, uint amount, uint payment, bytes32 dhash, address deedContract) external nonReentrant onlyAuction(dhash) { 
      // transferAdjustPrices() gets called by transferGroupSharesAdjustPrices, finalize Auction contract, AuctionMaster contract via ext or int proxy

      uint balSender   = balances[msg.sender];
      uint bal         = balances[toReceiver]>>1;

      my_require(  
                dhash!=0x0                           &&                         // valid hash of group domain name
                (balSender>>1) >= amount             &&                         // sender owns enough group shares
                bal + amount >= bal                  &&                         // check overflow
                payment>0,                                                      // payment required
             "j");
      
      balances[msg.sender] -= amount<<1;
      balances[toReceiver] += amount<<1;
      emit Transfer(msg.sender, toReceiver, amount);
      
      (,uint tNb) = auctionTransactionRecord(dhash);                            // adjusting new sell price of group token shares
      _getGwProxyDmHash(dhash).reserveAuctionENSname(tNb,payment,deedContract); // mark auction transaction done and completed
      
      uint256 newbPrice = uint(payment*1000) / amount / 1000;                   // set prices and adjust the buyPrice and sellPrice

      ownerPrices = uint256(newbPrice<<160) + 
                    uint256( ( newbPrice - (newbPrice/10) ) <<208) + 
                    uint256(ownerPrices & KAMASK);                              // setPrices_7d4
    }
    
    function _getGwProxyDmHash(bytes32 _dhash) internal view returns (IntGwp) {
      my_require(_dhash!=0x0,"Z");
      address gwp = _gwf().getGWProxy(_dhash);                                  // GWF - GroupWalletFactory contract
      my_require(gwp!=address(0),"X");
      return IntGwp(gwp);                                                       // GWP derived from domain name hash
    }

    function nameBidBucket(bytes32 dhash,bytes32 labelhash,address deedContract) external nonReentrant onlyAuction(dhash) { // gets called by Auction contract, createBidBucketProxy = external bidding proxy
      IntGwp gwp = _getGwProxyDmHash(dhash);
      my_require(deedContract!=address(0)&&labelhash!=0x0&&address(gwp)!=address(0),"n");
      gwp.nameAuctionBidBucketLabel(labelhash,deedContract);                                // name of BidBucket
    }

    function bytesToStr(bytes32 _b, uint len) internal pure returns (string memory) {
      bytes memory bArr = new bytes(len);
      uint256 i;
      
      do
       { 
        bArr[i] = _b[i];
        i++;
      } while(i<len&&i<32);
      
      return string(bArr); 
    }

    function labelStrFromBytes32(bytes32 _label) private pure returns (string memory) {
      return bytesToStr(_label,uint(_label)&0xff);
    }
    
    function registerPrePaidBucket(bytes32 dhash,bytes32 labelhashOrStr,address ppAcc,string memory ppa_name) external nonReentrant onlyPPADeployer(dhash) { 
      // registerPrePaidBucket() gets called by a deployer of GroupWalletMaster, aka Ungravel deployer

      my_require(dhash!=0x0&&labelhashOrStr!=0x0&&ppAcc!=address(0),"v");
      address ppaCtr = address((new PrePaidContract){value:0}(ppAcc,ppa_name,AbstractTm(masterCopy).reverse()));    // TokenMaster contract stores reverse, NOT tokenProxy!
      _getGwProxyDmHash(dhash).nameAuctionBidBucketLabel(labelhashOrStr,ppaCtr);                                    // PrePayBucket ENS name s.a. "bucket.mycompany.eth"
      emit PrePaidBucketInstalled(ppaCtr,ppAcc);
    }

    function _drain_shares(bytes32 dHash, address from, address toReceiver) private {
      AbstractGwf _GWF = AbstractGwf(IntGwp(msg.sender).getGWF());

      uint amount  = balances[from];
      uint bal     = balances[toReceiver];

      my_require(  
                  amount>0                     &&
                  bal + amount >= bal          &&
                  _GWF.getIsOwner(dHash,from),
             "B");

      balances[from] -= amount;
      balances[toReceiver] += amount;
      emit Transfer(from, toReceiver, amount>>1);
    }

    function drainShares(bytes32 dHash, address from, address toReceiver) external nonReentrant onlyGWP(dHash) {
      my_require(from!=address(0)&&toReceiver!=address(0),"G");
      _drain_shares(dHash,from,toReceiver);
    }
    
    function drainLegacyShares(bytes32 dHash, address from, address toReceiver) external nonReentrant onlyGWP(dHash) {
       my_require(from!=address(0)&&toReceiver!=address(0),"y");
      _drain_shares(dHash,from,toReceiver);
    }

    function transferFrom_78S(address from, address toReceiver, uint amount) external nonReentrant onlyByGWF {
        my_require(from!=address(0)&&toReceiver!=address(0),"T");

        uint bal = balances[toReceiver]>>1;

        my_require(
                    allowed[from][msg.sender] >= amount && // enough group shares allowed
                    balances[from]>>1 >= amount         && // balance check
                    bal + amount >= bal,                   // overflow check
               "T");

        allowed[from][msg.sender] -= amount;
        balances[from]            -= amount<<1;
        balances[toReceiver]      += amount<<1;
        emit Transfer(from, toReceiver, amount);
    }
    
    function transferOwnership_m0(address newOwner) external nonReentrant onlyByGWF {
      my_require(newOwner!=address(0),"Y");
      ownerPrices = uint256(ownerPrices & KPMASK) + uint256(uint160(newOwner));
    }
    
    function setPrices_7d4(uint256 newSellPrice, uint256 newBuyPrice) external nonReentrant onlyByGWF {
      ownerPrices = uint256(newBuyPrice<<160) + uint256(newSellPrice<<208) + uint256(uint160( address(_gwf()) ));
    }
      
    function buy_uae() payable external nonReentrant onlyGroupMember {
        uint bal       = balances[msg.sender];
        uint256 bPrice = uint256( (uint256( ownerPrices & KBMASK )>>160) & KMASK );

        my_require(msg.value>0 && bPrice>0,"y");
        uint amount = uint256(uint(msg.value*1000) / bPrice / 1000);
        
        my_require(balances[address(this)]>>1 >= amount && ((bal>>1) + (amount<<1) >= (bal>>1)),"q");

        balances[address(this)] -= amount<<1;
        balances[msg.sender]    += amount<<1;
        emit Transfer(address(this), msg.sender, amount);
    }
    function sell_LA2(uint256 amount) external nonReentrant onlyGroupMember {
        uint bal = balances[msg.sender];
        uint256 sPrice = uint256( (uint256( ownerPrices & KSMASK )>>208) & KMASK );

        my_require(amount>0 && sPrice>0&&(bal>>1) >= amount,"e");
                
        bal = balances[address(this)]>>1;
        my_require(bal+amount >= bal,"Q");

        balances[msg.sender] -= amount<<1;
        balances[address(this)] += amount<<1;

        payable(msg.sender).transfer(amount * sPrice);
        emit Transfer(msg.sender, address(this), amount);
    }
    
    function newToken(uint256[] calldata _data) external nonReentrant onlyGWF payable {        
        ownerPrices = K_SELLBUY + uint256(uint160(msg.sender) & KAMASK);        // store GWF inside ownerPrices
        name32      = bytes32(_data[_data.length-2]);

        address gwpc = address(uint160(uint256(_data[_data.length-1])));
        address[] memory owners = IntGwp(gwpc).getOwners();                     // owners() - taken from GWPC

        address    iOwner;
        uint256    iShare;
        uint256    iSum = 0;
        
        uint i=0;
        do {
          iOwner = owners[i];
          iShare = uint256(uint256(_data[i] & KPMASK)>>159) & KSHAREMASK;

          my_require( (iShare != 0)                                   && 
                      (balances[iOwner]==0)                           && 
                      (address(uint160(_data[i] & KAMASK))==iOwner),
                 "L");
          
          iSum += iShare;
          balances[iOwner] = iShare;
          emit Transfer(address(0), iOwner, iShare>>1);
          
          i++;
        } while(i<owners.length);

        iSum = iSum - uint256(2e8);                                            // tokenContract might get less than 100.000 shares reserve
        balances[address(this)] = CONTRATSHARE-iSum;                           // +10.00% token for proxyToken contract
        emit Transfer(address(0), address(this), CONTRATSHARE2-(iSum>>1));
        
        balances[gwpc] = CONTRATSHARE;                                         // +10.00% token for GroupWallet contract
        emit Transfer(address(0), gwpc, CONTRATSHARE2);
    } 

    function _gwfc_gwpc_ptc(bytes32 dHash,address master) private view returns (address,address) {
      AbstractGwf gwfc = _gwf();                                                // GWF - GroupWalletFactory contract
      address     gwpc = gwfc.getGWProxy(dHash);                                // GWP - GroupWalletProxy   contract
      address     ptc  = gwfc.getProxyToken(dHash);                             // PTC - ProxyToken         contract

      my_require( master!=address(0) && ptc==address(this),"N");
      return (gwpc,ptc);
    }
    function upgradeTokenMaster(bytes32 dHash, address master) external nonReentrant sameDeployer(master) onlyGWP(dHash) payable {
      my_require(master!=address(0),"u");
      (,address ptc) = _gwfc_gwpc_ptc(dHash,master);

      my_require(AbstractTpc(ptc).masterCopy()!=master,"U");
     
      AbstractTpc(ptc).upgrade(master);
      emit UpgradeTokenMaster(ptc, master);
    }
    function upgradeGWM(bytes32 dHash, address master) external nonReentrant sameDeployer(master) onlyGWP(dHash) payable {
      address gwpc = AbstractGwf(_gwf()).getGWProxy(dHash);
    
      AbstractGwpc(gwpc).upgrade(master);
      emit UpgradeGWallet(gwpc, master);
    }  

    function onERC1155Received(address,address,uint256,uint256,bytes calldata) public pure returns (bytes4) { // 0xf23a6e61
      return this.onERC1155Received.selector;
    }
    function version() public pure returns(uint256) {
      return 20010116;
    }
    receive() external payable {
      emit Deposit(msg.sender, msg.value);
    }

    constructor (bytes32 tokenName, AbstractTmReverseRegistrar _reverse, AbsMultiFour _multifour) payable
    { 
      my_require(address(_reverse)!=address(0),"S");
      name32      = tokenName;
      masterCopy  = msg.sender;                                                // deployer
      ownerPrices = K_SELLBUY + uint256(uint160(msg.sender) & KAMASK);         // save owner of contract === deployer

      // ENS reverse resolver entry of address(this) ---> e.g. "tokenmaster.ungravel.eth" on ethereum mainnet | "tokenmaster.ungravel.lisk" on LISK mainnet
      reverse = _reverse;
      reverse.setName(string(abi.encodePacked('tokenmaster.ungravel',_multifour.tld()))); // assigning reverse resolver record
      emit Deployment(msg.sender, address(this));
    }
}

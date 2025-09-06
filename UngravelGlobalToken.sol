// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.30;

// ungravel.eth, GroupWalletFactory, GroupWalletMaster, GroupWallet, ProxyWallet, TokenMaster, ProxyToken, PrePaidContract, AuctionMaster, BiddingProxy, 
// intDeedMaster, extDeedMaster, IntDeedProxy, Intentions, UngravelGlobalShares by pepihasenfuss.eth 2017-2025, Copyright (c) 2025

// UngravelGlobalShares and Ungravel is entirely based on Ethereum Name Service, "ENS", the domain name registry, ported to several chains.
// Although, Ungravel extends ENS to 16 different EVM chains: Ungravel EVM Names across chains create an Ungravel Unified Name Space, called UUNS.

//   ENS, ENSRegistryWithFallback, PublicResolver, Resolver, FIFS-Registrar, Registrar, AuctionRegistrar, BaseRegistrar, ReverseRegistrar, DefaultReverseResolver, ETHRegistrarController,
//   PriceOracle, SimplePriceOracle, StablePriceOracle, ENSMigrationSubdomainRegistrar, CustomRegistrar, Root, RegistrarMigration are contracts of "ENS", by Nick Johnson and team.
//
//   Copyright (c) 2018, True Names Limited / ENS Labs Limited
//
//   Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//   The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


//******************************************************
//**                     TLTR;                        **
//******************************************************

// For Investors:
// Ungravel Global Shares transform VC investments into the nurturing of self-organizing, cell-like, on-chain economies.
// Ungravel Groups form economic cells, mushrooming an intertwined mesh of pop-up groups and spin-offs, autonomously.
// Investing becomes incentivizing "populations", instead of funding individual talent or certain qualified companies.

// Investors are betting on the entire on-chain economy, investing directly into user adoption, not talent, not company - nor product.
// Ungravel Society can populate different target chains, competing chains will want to co-invest, already highly under pressure.
// 
// Infrastructure investors are buying user attention anyway, therefore, betting on a radically new idea seems quite reasonable.
// Ungravel re-invents ICOs - fundamentally modernized and aligned, applying innovative incentive design.

// For Users, Talents, Members:
// Co-workers get on-board with a 1-click-URL, no installation, no wallet, no expertise, no faucet, no hazzle, via desktop or mobile app.
//
// Group members receive group shares, a personal stake, a safe self-custody account, initial funding, stable coins, a unique EVM domain name, 
// such as: "vitalik.mygroup.base", a built-in group share market, member voting, funding through auctions. No bank, no exchange, no DEX, no CEX,
// no issuer, no business lawyer, no notary, virtually no cost deploying an on-chain co-op, instantly running, worldwide accessible, always-on, 
// no borders, no customs, virtually unstoppable and extremely decentralized, running on 16 EVM blockchains. No platform involved! Autonomous.

// For anyone else: "Ungravel Groups monetize group stability and member commitment."

// For Influencers: 
// Ungravel Groups capitalize on followers & communities, transforming any business on blockchain rails, in self-custody,
// free & independently, ommitting platforms.

// For beginners: Ungravel Groups enable group building. Build any future organization, co-op or company, virtually for free.
// Ungravel Groups may become valuable, if needed, they may organize funding rounds by themselves.


//*******************************************
//** Ungravel Global Shares                **
//*******************************************

// Ungravel Groups may split and any group member may start her or his or its own group. Any member may also participate in more than one group.
// As Ungravel Society is growing, activities among groups become key.
// Groups that have completed an internal funding auction control their own common assets and their own liquidity.
//
// Any group may intend to invest in any other group. By simply "sending" a Letter-of-Intent, a LOI.
// Then, a group may vote again and decide to invest in any other group. Groups value other groups by investing and rising market cap.
// Investing in a group is merely a sale of group shares. Symbolic group shares have turned into convertible assets with an internal auction.
//
// Global Shares are required to structure incentives design:
//
// They offer liquidity to Ungravel Groups, paying out grants and converting acquired group shares into native liquidity, e.g. Ether.
// But where does liquidity actually come from? Ungravel Group Shares can be considered the main entry-point for VC investment on blockchain.
// As digital transformation progresses, it is transforming the very nature of seed-funding and incubating start-ups.
//
// Global Shares are for sale, resulting liquidity feeds 2 separate funds: One that keeps selling and buying of Global Shares liquid.
// The other one provides liquidity to Ungravel Groups, to a developing Ungravel Society as a whole.

// Ungravel does not introduce restrictions on who is who in this economy. Any VC investment may also go directly to any Ungravel Group.
// Betting on Ungravel Global Shares is betting on Ungravel Society, as a whole, on all groups at the same time.

// It may sound strange to traditional investors, but it comes with some interesting advantages:

// Thus, by investing into Ungravel Society, investors do not have to bet on certain teams or single entrepreneurs. They still may - if they want.
// Instead they may profit from the development of all Ungravel Groups at once. Investments in Global Shares nurture all groups at the same time.
//
// Groups organize themselves. Some are early-adopters, investment influencers, consultants or evangelists attracting more capital than others.
// They help to nurture and structure growth. With each transaction, each Funding Auction completed, market caps get adjusted.
// Therefore, each Ungravel Group has its own market cap that determines the price of Group Shares.

// But Ungravel Global keeps track of all transactions and combines the sum of all group activity into a global market cap.
// Ungravel Global Shares represent the current market cap of Ungravel Society. It is the sum of all individual market caps.

// Share price of Ungravel Global Shares is solely determined by market cap and the number of Global Shares issued.


//******************************************************
//** Is Ungravel Global Share yet another token sale? **
//******************************************************

// No. It re-invents token sale applying radically modernized incentive design.
//
// In the past, token sales, such as ICOs, often created highly priviliged investment opportunities.
// The general public or "retail investors" did pay a lot more than preferred investors, family and friends.
// That is one of the reasons why trust into ICOs eroded and user attention vanished. Despite scams and fraud.

// Ungravel Global Share does not organize an ICO. It is simply a fair market place for a structured investment opportunity.
// VC investors, investors, investing individuals or any small "retail" investor, they all have the same rights.
// No Global Shares "reserved", "locked-in" or "preferred". Ungravel Global Share is a single smart contract 
// for selling and buying global shares, according to liquidity and market cap. Transparently and open.
//
// In contrast to an ICO, share price solely derives from market cap. Market cap is the sum of group activities.
// Therefore, Global Shares are always "pegged" against real economic group activity. Comparable to GDP.
// The value of each group can be measured quite easily. It is the individual market cap that may only rise if a group 
// attracts internal or external funding.
//
// The overall value of Global Shares is easily measured as well: It is the total sum of all market caps. In this sense, 
// groups and society are based on real value, on actual economic activity. Consider Ungravel Society a cell-type economy on chain.
// A prototype of a blockchained economy where the distinction between user, group member and investor evaporates, it dissolves.


//******************************************************
//** What is comparable to Ungravel Global Shares?    **
//******************************************************

// Any stock holding company represents a certain value, its' market cap.
// It is the sum of all issued stock multiplied with the current stock price.
//
// Company shares are sold on stock markets, mainly through issuing banks,
// traders or fonds. Or the company itself by granting free stock to employees or management.
//
// At all time, current stock price gets adjusted while selling and buying stock on the market.
// At all time, stock price represents company valuation.
//
// A single number - combined with the total number of issued stock, determines the total value
// of the company. If selling stock to investors or banks, the company gets funding.
//
// Funding becomes working capital to create new products and revenue. Among other factors, 
// revenue determines share price and market cap. And so on...

// Ungravel Global Shares apply the same principles to a blockchained economy. It creates an autonomous 
// market place for selling and buying Global Shares. The issuing of Global Shares is 
// autonomous as well. It starts with 1b Global Shares and may rise to max. 10b automatically, unstoppable.
//
// It provides liquidity to Ungravel Groups, according to its own liquidity and group performance.
// It keeps Global Share market liquid, therefore, investors may sell Global Shares any time.

// Where are the differences?

// Economy on-chain is transforming stock-holding companies into self-issuing groups, it renders
// the issuing bank and the stock market obsolete, by "minting" and trading shares. Groups come with a built-in market place.
//
// Global Share economy even does not rely on CEXs or DEXs: Ungravel Global Shares are NOT dependent on centralized or 
// decentralized Exchanges! Ungravel comes with a built-in Global Share market as well. It does not need an issuer.
//
// It may require trade agents - but they will be Ungravel Groups. Or PR & promotion, they all will be Ungravel Groups.
//
// The main difference is that it is all new! Not done before.


interface IGAbsGwp {                                                                              // interface to GWP, Group Wallet Proxy contract, the Voting and Multi-Sig-contract of each group, a proxy, belonging to the GroupWallet Master
  function getIsOwner(address _owner)      external view returns (bool);
  function getOwners()                     external view returns (address[] memory);
  function getTransactionsCount()          external view returns (uint);
  function getTransactionRecord(uint _tNb) external view returns (uint256);
  function getGWF()                        external view returns (address);
  function getAllTransactions()            external view returns (uint256[] memory transArr);
  function getTNumberPublic()              external view returns (uint count);
  function getMasterCopy()                                                    external view returns (address);
  function nameAuctionBidBucketLabel(bytes32 labelhash, address deedContract) external;
  function getIntention()                  external view returns (gAbsInt);
}
contract gAbsBaseR {                                                                             // BaseRegistrar belongs to the ENS - Ethereum Naming Service
  event NameMigrated(uint256 indexed id, address indexed owner, uint expires);
  event NameRegistered(uint256 indexed id, address indexed owner, uint expires);
  event NameRenewed(uint256 indexed id, uint expires);
  bytes32 public baseNode;                                                                       // The namehash of the TLD this registrar owns (eg, .eth)
}
interface IGAbsEns {                                                                             // ENS Registry grants access to domain names and domain name properties
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
interface IGResolver {                                                                           // ENS Resolver provides the address and properties of domain names, s.a. "your-company.base", it resolves domain names to EVM addresses
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
abstract contract gAbsRr {                                                                       // Reverse Resolver and Reverse Default Resolver give access to the domain name, if only an address is given
  IGResolver public defaultResolver;
  function node(address addr) external virtual pure returns (bytes32);
  function setName(string memory name) external virtual returns (bytes32);
}
abstract contract gAbsGwf {                                                                      // Group Wallet Factory, GWF, main Ungravel entry point coordinating Ungravel Groups and all activities, deploying ProxyGroupWallet, GWP, and ProxyToken, aka TokenProxy
  IGResolver                      public  resolverContract;
  IGAbsEns                        public  ens;
  gAbsBaseR                       public  base;
  gAbsRr                          public  reverseContract;
  function getOwner(bytes32 _domainHash) external view virtual returns (address);
  function getProxyToken(bytes32 _domainHash) external view virtual returns (address p);
  function getGWProxy(bytes32 _dHash) external view virtual returns (address);
  function getIsOwner(bytes32 _dHash,address _owner) external view virtual returns (bool);
  function domainReport(string calldata _dom,uint command) external payable virtual returns (uint256 report, address gwpc, address ptc, address gwfc, bytes memory structure);
  function getGWF() external view virtual returns (address);
  function tld() public view virtual returns (string memory);
}
abstract contract gAbsTpc {                                                                      // TokenProxy gives access to the Group Shares contract, aka TokenProxy contract, that comes with each group, a proxy contract that belongs to TokenMaster
  address  public masterCopy;
  function upgrade(address master) external virtual payable;
  function version() public pure virtual returns(uint256 v);
  function name() external view virtual returns (string memory);
  function owner() external virtual view returns (address ow);
  function balanceOf(address tokenOwner) external virtual view returns (uint thebalance);
  function transfer_G8l(address toReceiver, uint amount) external virtual;
}
abstract contract gAbsAuction {                                                                  // Auction Registrar is Vickrey Auction, controlled by Ungravel GroupWallets, in order to sell group shares to investors and to tame competition
  enum Mode { Open, Auction, Owned, Forbidden, Reveal, empty, Over }
  function startAuction_ge0(bytes32 _hash, uint revealP) public virtual payable;
  function state_pln(bytes32 _hash) public virtual view returns (Mode);
  function entries(bytes32 _hash) public virtual view returns (Mode, address, uint, uint, uint, uint, uint, uint);
  function calculateMinAuctionPrice() public virtual view returns (uint64);
}
abstract contract gAbsExtDeed {                                                                  // External Investor Deed aka BidBucket proxy contract, used to store the deposit of a bidding investor during Funding Auctions
  gAbsAuction public  registrar;
  address     public  beneficiary;
  bytes32     public  lhash;
}
abstract contract gAbsInt {                                                                      // Intentions store and provide information about LOIs. LOIs are also important in order to participate in and to profit from Ungravel Global Token, aka Ungravel Global Shares, in the future.
  function saveLetterOfIntent(address target, uint nbOfShares) public virtual payable;
  function storeInvestment(uint _nbOfShares, address _gwp, uint _pricePaidEth, bytes32 _salt) public virtual payable;
  function getUNGmarketCap() public view virtual returns (uint);
  function getIntendedLOIShares(address tg, address inv) public view virtual returns (uint);
  function didGetFundingFrom(address _gwp,address _inv) public view virtual returns (bool);
  function getFundingReport(address _gwp, address _inv) public view virtual returns (uint256 mCapGWP, bytes32 dhash, uint256 loiShares, uint256 shares, uint256 price, uint256 mcap);
  function getGroupLOIinvestors(address target) public view virtual returns (address[] memory);
  function getLOIInvestorName(address tg, address _iv) public view virtual returns (string memory);
  function tld() public view virtual returns (string memory);
}

//---------------------------------------------------------------------------------------------

// How VC investing transforms into the age of blockchains?

// Ungravel transforms VC investing into nurturing an autonomous, self-organizing, cell-like economy, on-chain.

// Ungravel Groups are economic cells, mushrooming intertwined meshes of pop-up groups and spin-offs, uncontrolled.
// Investing becomes incentivizing & feeding "populations" instead of funding talent or selected companies.

// Investors are betting on the entire "space", investing directly into user adoption, not individual talent, not company, nor product.
// "Ungravel Society" populates different EVM target chains. Competing chains will co-invest, fighting for users and for attention.

// In past years, investors subsidized nodes and chains quite heavily, neglecting application stack & developer tools.
// Most chains will vanish and shut down, idling nodes will disappear, in fierce competition, dApps will determine a chains' fate.

// Today, infrastructure investors are buying user attention anyway, therefore, betting on a radically new concept is reasonable.
// Ungravel re-invented ICOs - fundamentally modernized and aligned, by applying inventive incentive design.

// Today, the dApp runs in beta on 16 different EVM-compatible chains, it is mobile-first and user-friendly.
// Live tutorials "speak" to users directly, voice recognition is still experimental, but very engaging.
// The Ungravel team will organize an intensive technical workshop, demonstrating a complete tech stack, live,
// on 16 chains, for the first time after 9 years of stealth development, in Singapore, if you want.


contract UngravelGlobalShares {
    address internal immutable ungravel_owner;                                  // contract deployer address

    gAbsGwf public GWF;                                                         // current GWF contract of chain, aka GroupWallet Factory
    gAbsInt internal intent;                                                    // Intention Contract - administers LOIs and investment information, computes marketCap of Ungravel Society on this chain

    uint256 private ownerPrices;                                                // buyPrice, sellPrice, owner address = GWF contract
    uint256 internal supply;                                                    // nb of global shares, held by (this) UngravelGlobalShares contract, available to sell to investors, "available global shares"
    uint256 public numberOfShares = K_INITIALSUPPLY;                            // total number of global shares, number of "global shares minted"

    uint256 constant public K_INITIALSUPPLY     = 100000000000;                 // initial supply of global shares, assigned to this contract, "available global shares" after contract deployment
    uint256 constant public K_MAXNUMBEROFSHARES = K_INITIALSUPPLY*10;           // max. number of global shares allowed, "maximal number of gobal shares mintable"

    mapping(address ownerAddr => uint256 balance)                                   private balances; // stores nb of global shares per owner address
    mapping(address ownerAddr => mapping(address benefittingCtr => uint256 amount)) private allowed;  // stores nb of global shares approved to contract, approved by owner address

    mapping(address deedAddr => address gwp)        private grants;             // stores BidBucket address of winning deed in a Funding Auction: investing GWP did receive a grant
    mapping(address deedAddr => uint256 shares)     private grantShares;        // stores nb of group shares in exchange for the received grant in ETH

    uint256 public totalGlobalInvestments;                                      // in ETH, sum of all ETH amounts of BUY  global shares transactions, "total value invested and converted into Ungravel Global Shares"
    uint256 public totalGlobalSold;                                             // in ETH, sum of all ETH amounts of SELL global shares transactions, "total value of Ungravel Global Shares - sold"

    uint256 public InvestorLiquidityOfPeriod;                                   // in ETH, liquidity that investors may use to sell back global shares during current investment period
    uint256 public SocietyLiquidityOfPeriod;                                    // in ETH, liquidity that Ungravel Society aka Ungravel Groups may claim to convert group shares to ETH and to claim grants

    uint256 constant K_SPREAD      = 100;                                       // divisor / spread to calculate the sellPrice
    uint256 constant K_PERCENT     = 1;                                         // percent of group market cap that will be paid as a grant

    uint256 constant K_BUYPR       = 1000000000;                                // initial price per share (arbitrary) 1000000000 wei
    uint256 constant K_SELLPR      = K_BUYPR - (K_BUYPR/K_SPREAD);              // sell price is 1% less of the buy price to keep global shares liquid; this contract collects small sell token fees to enhance ETH liquidity

    uint256 constant K_SELLBUY     = uint256( (uint256(uint256(K_BUYPR)<<160) + uint256(uint256(K_SELLPR)<<208)) & K_PMASK ); // combine sellPrice, buyPrice and GWF in a single word (compatible with TokenMaster and TokenProxy)
    
    uint256 private _guardCounter  = 1;                                         // used to protect against re-entrancy attacks
    uint256 private _guardCounter2 = 1;                                         // used to protect against re-entrancy attacks
            
    uint256 constant K_AMASK       = 0x000000000000000000000000ffffffffffffffffffffffffffffffffffffffff;
    uint256 constant K_SMASK       = 0xffffffffffff0000000000000000000000000000000000000000000000000000;
    uint256 constant K_BMASK       = 0x000000000000ffffffffffff0000000000000000000000000000000000000000;
    uint256 constant K_MASK        = 0x0000000000000000000000000000000000000000000000000000ffffffffffff;
    uint256 constant K_PMASK       = 0xffffffffffffffffffffffff0000000000000000000000000000000000000000;
    uint256 constant K_TMASK       = 0xf000000000000000000000000000000000000000000000000000000000000000;
    uint256 constant K_EXECUTEFLAG = 0x0000000000800000000000000000000000000000000000000000000000000000; // 1 bit

    address constant K_ADD00       = address(0);

    event TestReturn(uint256 v1, uint256 v2, uint256 v3, uint256 v4);
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Deposit(address from, uint256 value);
    event PayOutGrant(address from, uint256 value);
    event Deployment(address owner, address theContract);
    event Approval(address indexed owner,address indexed spender,uint256 value);
    event NewSharesMinted(address indexed owner, uint256 value);
    event IncreasedGlobalSharesSupply(uint256 supply, uint256 newShares);
    event AdjustGlobalSharePrice(uint256 buyPrice, uint256 sellPrice);
    event PayForGroupShares(address gwp_funded,address gwp_investor,uint value, uint nbOfShares);

    modifier nonReentrant() {
      _guardCounter += 1;
      uint256 localCounter = _guardCounter;
      _;
      require(localCounter == _guardCounter,"r-et");
    }
    modifier nonReentrant2() {
      _guardCounter2 += 1;
      uint256 localCounter = _guardCounter2;
      _;
      require(localCounter == _guardCounter2,"ret");
    }

    modifier onlyOwner() {
       my_require(ungravel_owner==msg.sender,"only Owner!");
      _;
    }
    modifier onlyGWP() {
      my_require(__isGW(msg.sender),"only GWP!");
      _;
    }
    modifier onlyWithGWP(address _gw) {
      my_require(__isGW(_gw),"wGWP!");
      _;
    }

    function my_require(bool b, string memory str) private pure {
      require(b,str);
    }
    function _validContract(address ct) private view returns (bool) {
      return ( ct!=address(0) && isContract(ct) );
    }

    function _domHash(IGAbsGwp gw) internal view returns (bytes32) {                                 // provide domain name hash of domain name of the GWP - Group Wallet Proxy contract, s.a. hash("my-company.one")
      address gwfc = gw.getGWF();
      my_require(address(gwfc)!=K_ADD00,"gwfc");
      return bytes32(gw.getTransactionRecord(uint256(uint160(gwfc))));                               // domain hash, s.a. hash of "mygroupwallet.eth"
    }
    function _reverse(IGAbsGwp gw) internal view returns (gAbsRr) {                                  // returns reverse registry contract using GWF
      address lGWF = gw.getGWF();
      my_require(address(lGWF)!=address(0),"revCon");
      return gAbsGwf(lGWF).reverseContract();
    }
    function getReverseDNameFromAddress(address _gwp) internal view returns (string memory) {        // returns domain name string from address
      return string(_reverse(IGAbsGwp(_gwp)).defaultResolver().name( _reverse(IGAbsGwp(_gwp)).node(_gwp) ));
    }
    function resolvedAddressFromDName(bytes32 dhash) internal view returns (address) {               // returns resolved address from domain name hash
      return GWF.resolverContract().addr(dhash);
    }
    function __isGW(address _gw) private view returns(bool) {
      bytes32 hsh = _domHash(IGAbsGwp(_gw));

      return (
               _validContract(_gw)                               &&  // check is contract && check not 0x00
               address(IGAbsGwp(_gw).getGWF())==address(GWF)     &&  // check relies on same GWF
               hsh!=0x0                                          &&  // does refer to domain name hash
               GWF.getOwner(hsh)==_gw                            &&  // _gw is owner of hash
               GWF.getGWProxy(hsh)==_gw                              // hash owned by _gw ---> _gw is Ungravel Group! (qed)
             );
    }
    function __calledByUngravelGWP(address sender) private view returns (bool) {                     // caller MUST BE valid contract, a GroupWalletProxy, GWP belonging to Ungravel
      my_require(_validContract(sender),"nU");                                                       // called by a contract

      bytes32 hsh = _domHash(IGAbsGwp(sender));                                                      // *** hsh of seed.eth ***  hsh = GroupWallet domain hash, from GWP contract
      my_require(hsh!=0x0,"nU2");                                                                    // valid hsh

      address gwfc = IGAbsGwp(sender).getGWF();                                                      // GWF contract, derived from GWP, in this case (hopefully) the caller
      my_require(_validContract(gwfc)&&address(GWF)==gwfc,"nU3");                                    // GWF contract is contract and we are all part of the same family (society), lead by GWF

      my_require(GWF.getOwner(hsh)==sender,"nU4");                                                   // requested GWP owns its own dName, s.a. "silvias-bakery.eth", proving that it belongs to Ungravel Society!

      return true;
    }
    function __ungravelGW(bytes32 _hash) private view returns (bool) {                               // checks if _hash is UUNS
      IGAbsGwp gwp  = IGAbsGwp(GWF.getGWProxy(_hash));                                               // *** hash leads to GWP
      my_require(_validContract(address(gwp)),"U1");                                                    // check if GWP is valid contract address
      bytes32 hsh  = _domHash(gwp);                                                                  // hsh = GroupWallet domain hash
      address gwfc = gwp.getGWF();                                                                   // GWF contract, derived from GWP
      my_require( 
               _hash!=0x0                               &&  // check if hash is valid
               hsh!=0x0                                 &&  // check if hsh  is valid
               _validContract(gwfc)                     &&  // basic check if derived GWF is valid
               gAbsGwf(gwfc).getOwner(hsh)==address(gwp)    // GWF and hsh assert that gwp belongs to Ungravel
        ,"U2");
      
      return true;
    }
    function __selfbalance() private view returns (uint self) {                                      // returns the balance of this contract
        assembly {
          self :=selfbalance()
        }
    }

    // ----------------------- ERC20 -------------------------------------------

    function getOwner() public view returns (address) {                                              // contract owner === deployer of the Ungravel Global Token contract
      return ungravel_owner;
    }
    
    function owner() external view returns (address ow) {                                            // GWF - GroupWallet Factory contract
      return address(uint160(ownerPrices & K_AMASK));
    }
    
    function name() external pure returns (string memory) {                                          // Ungravel Global Shares
      return 'Ungravel Global Shares';
    }
    
    function standard() external pure returns (string memory std) {                                  // erc20
      return 'ERC-20';
    }
    
    function symbol() external pure returns (string memory sym) {                                    // symbol = UNGRAVELS
      return 'UNGRAVELS';
    }
    
    function decimals() external pure returns (uint8 dec) {                                          // 2 decimals, mainly due to compatibility with Ungravel Group shares
      return  2;
    }
    
    function totalSupply() public view returns (uint256) {                                           // currently available nb of global shares to buy, hopefully supply >= K_INITIALSUPPLY, otherwise this contract may mint new shares
      return supply;
    }
    
    function sellPrice() external view returns (uint256 sp) {                                        // return current sellPrice for 1 global share, typically 1% less of buyPrice
      return uint256( (uint256( ownerPrices & K_SMASK )>>208) & K_MASK );
    }
    
    function buyPrice() external view returns (uint256 bp) {                                         // return current buyPrice for 1 global share
      return uint256( (uint256( ownerPrices & K_BMASK )>>160) & K_MASK );
    }
    
    function balanceOf(address tokenOwner) external view returns (uint thebalance) {                 // returns balance of global shares of owner
      return balances[tokenOwner]>>1;
    }
    
    function tokenAllow(address tokenOwner,address spender) public view returns (uint256 tokens) {   // allow another contract "spender" to control a nb of tokens owned by "tokenOwner", returning nb of tokens
      return allowed[tokenOwner][spender];
    }

    function allowance(address own, address spender) public view returns (uint256) {                 // allow another contract "spender" to control a nb of tokens owned by "tokenOwner", returning nb of tokens
       return allowed[own][spender];
    }
    
    function saveOwner(uint256 buyP,uint256 sellP,address own) private pure returns (uint256 o) {    // may store buyPrice and sellPrice and the owner of this contract in a single bytes32 word
      return uint256( uint256(uint256(buyP)<<160) + uint256(uint256(sellP)<<208) + uint256(uint160(own)) );
    }
    
    function getIntention() public view returns (gAbsInt) {                                          // provide Intentions contract: Intentions collect relevant data about Funding Auctions and Ungravel Group valuations
      return gAbsInt(intent);
    }

    function mCapOfUngravelSociety() public view returns (uint) {                                    // return the current market cap of Ungravel on this chain - aka total value of Ungravel Society on xyz-chain
      // Hint: The UNGmarketCap is the sum of all succeeded Funding Auctions,
      // that finalized successfully and sold group shares to group investors.
      // MarketCap gets computed by adding up the deposits of BidBuckets of Funding Auctions
      // that completed, although the actual price paid may have been lower than the deposit.
      // Therefore, UNGmarketCap is considered the upper-bound of Ungravel Society valuation.

      return getIntention().getUNGmarketCap();
    }

    function getInvestmentSurplus() public view returns (uint) {                                     // difference of investor cash-flow
      return uint(totalGlobalInvestments-totalGlobalSold);
    }

    function getMintFactor() public view returns (uint) {                                            // relation of max shares to remaining mintable shares x 1000
      if (numberOfShares >= K_MAXNUMBEROFSHARES) return 1e6;                                         // max. mintFactor = 1000000 in case nb of shares reached the max. nb of mintable shares
      uint r = uint( (K_MAXNUMBEROFSHARES*1000) / (K_MAXNUMBEROFSHARES - numberOfShares) );          // "1000 x max. nb global shares" in relation to "remaining mintable global shares", e.g. 1111 in the beginning, growing to unlimited in the future
      if (r>1e6) r= 1e6;                                                                             // avoiding overflow
      return r; 
    }

    function getBalancedUngravelSocietyMCap() public view returns (uint) {                           // balanced marketCap of Ungravel Society, derived from MintFactor
      // Background: marketCap will be significantly lower in the beginning.
      // Therefore, mCapOfUngravelSociety gets weighed according to the number of minted shares.
      // It starts with:  mCapOfUngravelSociety/900 and rises to mCapOfUngravelSociety/1.
      // Conclusion: Balanced mCap grows as the Ungravel Society grows and attracts investors.
      // The more global shares are minted, the more investors did invest and valued global shares.
      // Rising investment into global shares is reflected in a rising balanced mCap of Ungravel Society.

      uint factor  = getMintFactor();                                                                // factor is 1111 and growing to 1000000 over time, as more and more global shares gets minted until K_MAXNUMBEROFSHARES
      uint weight  = uint(1e6/factor);                                                               // weigh current marketCap according to the development of Ungravel Society: The more shares get minted, the more "weight" declines from 900 to 1
      uint mCap    = mCapOfUngravelSociety();                                                        // total value of Ungravel Society on xyz-chain, UNBALANCED
      return uint(mCap / weight);                                                                    // in the beginning, balanced mCap is mCap/900, rising to mCap = mCap/1, if all shares are minted
    }

    // Explanation: For investors that invest into Ungravel Global Shares, there is liquidity of its own.
    // In case an investor wants to sell back Global Shares, he or she or it receives from InvestorsLiquidity.

    function InvestorsLiquidity() public view returns (uint) {                                       // returns the share of current ETH liquidity of this token contract, exclusively reserved for investors

      // Background: This token share contract remains liquid to offer the selling of global shares at any time, if possible.
      // Therefore, a fraction / stake / a part of the ETH balance of this contract remains reserved to keep global markets liquid.
      // This enables investors to buy and sell global shares almost instantly, whils current prices for BUY and SELL shares apply.

      // e.g. 13474021611234289496 investorLiqui remains very liquid,   typically at the beginning
      // e.g.  1792044874294160504  societyLiqui is only 10-15% of liq, typically at the beginning

      uint liq  = payable(this).balance;                                                             // ETH balance of this contract
      if (numberOfShares >= K_MAXNUMBEROFSHARES) return uint(liq/10);                                // in case that all shares are minted, keep 10% liquidity reserved for investors

      uint mCap = mCapOfUngravelSociety();                                                           // total value in ETH of the Ungravel Society, derived from Funding Auction valuations
      uint invd = getInvestmentSurplus();                                                            // total value in ETH of investor activites, i.e. of investments into Ungravel Global Shares, derived from all BUY global shares transactions minus SELL activities

      if (mCap==0)                   return uint(liq/2);                                             // half of liquidity if no market cap yet
      if (invd==0)                   return uint(liq/2);                                             // half of liquidity if no investments yet
      if (totalGlobalInvestments==0) return uint(liq/2);                                             // half of liquidity if no investments yet

      uint rel = (mCap*1000) / invd;                                                                 // relation of mCap to investments, speculation bubble detection, care for edge cases, x 1000
      if (rel>=10000)                return uint(liq/2);                                             // #1: in case of an Ungravel Society bubble (valuation is 10x of investments), assign 50% liquidity to investors 
      if (rel<1000)                  return uint(liq/5);                                             // #2: in case Ungravel Society is undervalued, assign only 20% of the liquidity to investors 

      uint mintFactor = getMintFactor();
      if (mintFactor>=10000)         return uint((liq*20)/100);                                      // assign not 20% of liquidity to Investors - in case the mintFactor is 10x or more

      return uint((liq*1000)/mintFactor);                                                            // returns the ETH amount reserved for investors
    }

    // Explanation: For Ungravel Groups, building Ungravel Society, there is liquidity of its own.
    // In case any Ungravel Group wants to get liquidity from Ungravel Global, it receives from SocietyLiquidity.

    function SocietyLiquidity() public view returns (uint) {                                         // returns the share of current ETH liquidity of this token contract, reserved to be claimed by Ungravel Groups aka by the Ungravel Society

      // Background: This token share contract offers global shares to investors.
      // Investors may buy global shares and this token share contract gets ETH liquidity that accumulates.
      // There is no possibility to drain any ETH liquidity from this contract, except through global token buy and sell transactions.
      // This token share contract does NOT allow to drain or take out any ETH.
      // Instead, this token contract collects ETH to support Ungravel Society - aka the total number of qualified Ungravel Groups - to get access to funding, if a group is eligible.

      // In general, this token share contract sells "UNGRAVELS" to provide substantial funding to eligible Ungravel Groups.
      // Who is eligible? Why?
      // Ungravel groups are informal groups of members that may organize internal funding auctions to enhance group liquidity internally, by themselves.
      // Once or twice successful, and among the top 5% of groups of Ungravel Society, a group may become eligible to get funding from this global share contract.
      // In general, the amount of funding accessible to qualified Ungravel Groups, gets limited by the appropriate share of liquidity, assigned to Ungravel Society.

      uint liq  = payable(this).balance;                                                             // balance in ETH of this contract
      if (numberOfShares >= K_MAXNUMBEROFSHARES) return uint((liq*80)/100);                          // in case all shares are minted, assign not more than 80% of liquidity to Ungravel Society and to eligible groups

      uint mintFactor = getMintFactor();                                                             // nb of mintable new global shares - in relation to the max nb of global shares * 1000 = mintFactor for investors
      if (mintFactor>=10000)                     return uint((liq*80)/100);                          // assign not more than 80% of liquidity to Ungravel Society - in case the mintFactor is 10x or more

      uint mCap = mCapOfUngravelSociety();                                                           // total value in ETH of the Ungravel Society, derived from Funding Auction valuations
      uint invd = getInvestmentSurplus();                                                            // total value in ETH of investor activites, i.e. of investments into Ungravel Global Shares, derived from all BUY global shares transactions minus SELL activities

      if (mCap==0)                   return uint(liq/2);                                             // half of liquidity if no market cap yet
      if (invd==0)                   return uint(liq/2);                                             // half of liquidity if no investments yet
      if (totalGlobalInvestments==0) return uint(liq/2);                                             // half of liquidity if no investments yet

      uint rel = (mCap*1000) / invd;                                                                 // relation of mCap to investments, speculation bubble detection, care for edge cases, x 1000 
      if (rel>=10000)                return uint(liq/2);                                             // #1: in case of an Ungravel Society bubble (valuation is 10x of investments), assign 50% liquidity to investors, 50% to Society
      if (rel<1000)                  return uint((liq*80)/100);                                      // #2: in case Ungravel Society is undervalued, assign only 20% of the liquidity to investors, 80% to Society

      return uint(liq - uint((liq*1000)/mintFactor));                                                // compute liquidity assigned to Ungravel Society, based on mintFactor
    }


    // --------------------- strings -------------------------------------------
    
    function char(bytes1 b) private pure returns (bytes1 a) {
        if (uint8(b) < uint8(10)) return bytes1(uint8(b) + 0x30);
        else return bytes1(uint8(b) + 0x57);
    }

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

    function concatBase32(bytes32 _b, bytes32 _c) internal pure returns (string memory) {
      bytes memory bArr = new bytes(65);
      uint8 i    = 0;
      uint8 off  = 0;
      uint8 off2 = 0;
      
      do
       { 
        if (_b[i]!=0) { 
          bArr[i] = _b[i];
        }
        else
        {
          off = i;
        }
        i++;
      } while(off==0&&i<32);

      bArr[off] = bytes1('.');

      i = 0;

      do
       { 
        if (_c[i]!=0) { 
          bArr[off+i+1] = _c[i];
        }
        else
        {
          off2 = i;
        }
        i++;
      } while(off2==0&&i<32&&(off+i+1)<32);
      
      return string(bArr); 
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

    function bytes32ToAsciiString(bytes32 _bytes32, uint len) private pure returns (string memory) {
        bytes memory s = new bytes((len*2)+2);
        s[0] = 0x30;
        s[1] = 0x78;
      
        for (uint i = 0; i < len; i++) {
            bytes1 b = bytes1(uint8(uint(_bytes32) / (2 ** (8 * ((len-1) - i)))));
            bytes1 hi = bytes1(uint8(b) / 16);
            bytes1 lo = bytes1(uint8(b) - 16 * uint8(hi));
            s[2+(2 * i)] = char(hi);
            s[2+(2 * i) + 1] = char(lo);
        }
        return string(s);
    }
    
    function toLowerCaseBytes32(bytes32 _in) internal pure returns (bytes32 _out){
      if ( uint256(uint256(uint256(_in) & K_TMASK) >> 252) <= 5 ) return bytes32(uint256(uint256(_in) | 0x2000000000000000000000000000000000000000000000000000000000000000 ));
      return _in;
    }

    // ---------------------------- utils ----------------------------------------

    function _getGWFromDHash(bytes32 _dhash) internal view returns (IGAbsGwp) {
      gAbsGwf gwfc = gAbsGwf(address(uint160(ownerPrices & K_AMASK)));                                      // GWF - GroupWalletFactory contract
      my_require(address(gwfc)!=K_ADD00&&isContract(address(gwfc))&&uint256(_dhash)>0,"_gGW");

      address gwp = gAbsGwf(gwfc).getGWProxy(_dhash);
      my_require(gwp!=K_ADD00&&isContract(gwp),"gGW");
      return IGAbsGwp(gwp);
    }

    function _tokenContract(IGAbsGwp gw) internal view returns (gAbsTpc) {
      gAbsGwf lGWF = gAbsGwf(gw.getGWF());
      my_require(address(lGWF)!=K_ADD00,"_tCt");
      return gAbsTpc(lGWF.getProxyToken(_domHash(gw)));
    }

    function isContract(address addr) internal view returns (bool) {
      uint size;
      assembly { size := extcodesize(addr) }
      return size > 0;
    }

    function auctionTransactionRecord(IGAbsGwp gwp) internal view returns (address,uint) {                      // returns the first auction address and transId from GWP transactions
      uint256 t;

      uint    i = gwp.getTransactionsCount();
      do {
        i--;
        t = gwp.getTransactionRecord(i);
        if ((t>0) && (t & K_TMASK == K_TMASK)) {     // iterate through auction transactions only
          return (address(uint160(t & K_AMASK)),i);
        }
      } while((i>0) && (t>0) && (t & K_TMASK != K_TMASK));
      
      return (K_ADD00,0);
    }

    function auctionTransactionExternal(IGAbsGwp gwp, address investGWP) internal view returns (address,uint) { // returns the first external auct address and transId, owned by investGWP
      uint256 t;
      address deed;

      __calledByUngravelGWP(address(gwp));

      uint i = gwp.getTransactionsCount();
      do {
        i--;
        t = gwp.getTransactionRecord(i);
        if ((t>0) && (t & K_TMASK==K_TMASK) && (t & K_EXECUTEFLAG==K_EXECUTEFLAG)) {               // iterate through auction transactions only (executed auction trans records)
          deed = resolvedAddressFromDName(_labelDomainHash(gwp,i));                                // BidBucket of external Deed / Bid / investment *** If not ext. auction, or timedOut, this may be gwp ***
          if ((deed!=K_ADD00)&&(deed!=address(gwp))&&(gAbsExtDeed(deed).beneficiary()==investGWP)) // return only a auction with a winning deed owned by the investor
            return (address(uint160(t & K_AMASK)),i);
        }
      } while((i>0) && (t>0));
      
      return (K_ADD00,0);
    }

    function getResolvedAddress(IGAbsGwp _gwp, uint _tNb) public view returns (address) {                       // for external or internal auctions: get address of bidBucket of auction
      if (_tNb==0) return K_ADD00;
      __calledByUngravelGWP(address(_gwp));
      return resolvedAddressFromDName(_labelDomainHash(_gwp,_tNb));
    }

    function getExtAuctTransNb(IGAbsGwp _gwp, address _investGWP) public view returns (uint) {                  // get transaction nb of last external auction
      __calledByUngravelGWP(address(_gwp));
      __calledByUngravelGWP(_investGWP);
      (address auct2, uint tNb2) = auctionTransactionExternal(_gwp,_investGWP);
      my_require(auct2!=address(0),"auct");
      return tNb2;
    }


    // --------------------- Global Token ----------------------------------------
    // Global Token design in simple words:

    // Ungravel Global Token (aka UNGRAVELS) is designed to be a plain and simple ERC-20 token.
    // It cannot be frozen. If you own UNGRAVELS, you are free to do what you want.
    // You are free to store them whereever you prefer. You are in control.

    // This token contracts does not impose any restrictions. Token cannot be frozen or blocked and cannot be taken away for any reason.
    // You may buy global shares from this contract, if the contract has enough shares in its supply and if you can pay 
    // the current price for the number of shares you want.

    // You may sell global shares to this contract, if the contract is liquid (e.g.ETH) and can pay out the current price, 
    // although, a fee of 1% applies.
    // Sample: You buy x global shares for 1 ETH, e.g. - if you sell x shares you will get back 0.99 ETH, the 0.01 ETH 
    // remains in the liquidity of this contract. (spread)

    // Initially, 1,000,000,000 global shares are assigned to this token contract. It is called: the supply.
    // Only if the supply of this contract falls below 1,000,000,000 global shares, new global shares may be minted. 

    // The maximal number of global shares is 10,000,000,000 global shares. Minting new global shares is only 
    // possible, if the contract supply is below the initial threshold of 1,000,000,000 global shares.

    // Minting new global shares can be executed in steps of 1% of the remaining mintable number of global shares.
    // It means: This contract - and nobody else - in general - cannot mint more than the maximal number of global shares.
    // Minting new global shares is performed automatically. Only if fresh global shares are needed, this contract is minting.

    // approve

    function approve_v2d(address spender, uint tokens) external nonReentrant {              // Ungravel Global Shares "UNGRAVELS" can allow another contract, "spender" to control "tokens", at any time, for free, without any restrictions (important for DEXs/CEXs/protocols)
      // approve_v2d is compatible with Ungravel Group Shares and a bit less expensive

      my_require(spender!=address(0)&&balances[msg.sender]>>1 >= tokens,"f!");

      allowed[msg.sender][spender] += tokens;
      emit Approval(msg.sender,spender,tokens);
    }

    function approve(address spender, uint256 value) external nonReentrant returns (bool) { // Ungravel Global Shares "UNGRAVELS" can allow another contract, "spender" to control "tokens", at any time, for free, without any restrictions (important for DEXs/CEXs/protocols)
      // ERC-20 compatible, wrapper for approve_v2d()

      my_require(spender!=address(0)&&balances[msg.sender]>>1 >= value,"f!");

      allowed[msg.sender][spender] += value;
      emit Approval(msg.sender,spender,value);
      return true;
    }
    

    // transfer

    function transfer_G8l(address toReceiver, uint amount) public nonReentrant2 {                   // Ungravel Global Shares "UNGRAVELS" can be transferred at any time for free, no restrictions
        uint balSender = balances[msg.sender];
        
        my_require(toReceiver!=address(0)&&balSender>>1 >= amount,"ft!");
        
        uint bal = balances[toReceiver]>>1;
        my_require(bal + amount >= bal,"o!");
        balances[msg.sender] -= amount<<1;
        balances[toReceiver] += amount<<1;
        
        emit Transfer(msg.sender, toReceiver, amount);
    }

    function transfer(address _toReceiver, uint256 _amount) external nonReentrant returns (bool) {  // Ungravel Global Shares "UNGRAVELS" can be transferred at any time for free, no restrictions
      my_require(_toReceiver!=address(0),"tt!");
      transfer_G8l(_toReceiver,_amount);
      return true;
    }


    // transferFrom

    function transferFrom_78S(address from, address toReceiver, uint amount) public nonReentrant2 {           // Ungravel Global Shares "UNGRAVELS" can be held by contracts and transferred by contracts at any time without any restrictions
        my_require(from!=address(0)&&toReceiver!=address(0)&&allowed[from][msg.sender] >= amount,"gT");
        allowed[from][msg.sender] -= amount;
        
        my_require(balances[from]>>1 >= amount,"gT2");
        uint bal = balances[toReceiver]>>1;
        my_require(bal + amount >= bal,"gT3");
        balances[from] -= amount<<1;
        balances[toReceiver] += amount<<1;

        emit Transfer(from, toReceiver, amount);
    }

    function transferFrom(address _from, address _to, uint256 _value) external nonReentrant returns (bool) {  // Ungravel Global Shares "UNGRAVELS" can be held by contracts and transferred by contracts at any time without any restrictions
      my_require(_from!=address(0)&&_to!=address(0),"tf");
      transferFrom_78S(_from,_to,_value);
      return true;
    }
    

    // buy global shares

    function buy_uae() payable external nonReentrant {
        uint bal = balances[msg.sender];
        my_require(msg.value>0,"gf!");
        
        uint256 bPrice = uint256( (uint256( ownerPrices & K_BMASK )>>160) & K_MASK );
        my_require(msg.value>0&&bPrice>0,"gv0");
        uint amount = uint256(msg.value / bPrice);
        
        totalGlobalInvestments  += msg.value;

        my_require(balances[address(this)]>>1 >= amount,"gnt");
        my_require((bal>>1) + (amount<<1) >= (bal>>1),"go!");
        balances[address(this)] -= amount<<1;
        balances[msg.sender]    += amount<<1;

        supply                  -= amount;

        emit Transfer(address(this), msg.sender, amount);

        increase_globalSharesSupply();                                                    // this is the ONLY way to increase global shares supply and to mint new shares

                                                                                          // check if global shares minted and dilution effects might get compensation for the investor

        uint256 newPrice = uint256( (uint256( ownerPrices & K_BMASK )>>160) & K_MASK );   // get new buyPrice, check if buyPrice did change
       

        if ((uint(amount*bPrice)>uint(amount*newPrice)) && (bPrice!=K_BUYPR)) {           // detecting dilution having minted new shares
          uint comp = uint( uint( uint( uint(amount*bPrice) - uint(amount*newPrice) ) / newPrice) / 100 )*100; // compensate dilution/inflation effect right after gobal shares might have been minted

          if ((comp>=1) && (balances[address(this)]>>1 >= comp)) {                        // compensation shares ? supply of this contract enough to pay out compensation ?
            balances[address(this)] -= comp<<1;                                           // reduce this balance
            balances[msg.sender]    += comp<<1;                                           // investor (sender) gets compensation shares
            supply                  -= comp;                                              // adjust supply
            emit Transfer(address(this), msg.sender, comp);                               // emit an event to indicate a token transfer
          }
        }
    }

    // sell global shares

    function sell_LA2(uint256 amount) external nonReentrant {
        uint bal       = balances[msg.sender];
        uint256 sPrice = uint256( (uint256( ownerPrices & K_SMASK )>>208) & K_MASK );

        my_require(amount>0&&sPrice>0&&bal>>1 >= amount,"gnt");
        
        bal = balances[address(this)]>>1;
        my_require(bal+amount >= bal,"go!");
        balances[msg.sender] -= amount<<1;
        balances[address(this)]   += amount<<1;

        supply                    += amount;

        uint pay                   = amount * sPrice;
        my_require(InvestorLiquidityOfPeriod>pay,"liqLim");
        my_require(payable(msg.sender).balance>pay,"liqLim2");

        payable(msg.sender).transfer(pay);

        totalGlobalSold           += pay;
        InvestorLiquidityOfPeriod -= pay;

        emit Transfer(msg.sender, address(this), amount);
    }
    

    // adjustPrices of global shares

    function adjustPrices() internal {                                       // apply the Ungravel Society marketCap to Ungravel Global Shares, compute buyPrice - derived from the marketCap
      uint256 newBuyPrice;
      uint256 newSellPrice;

      uint mCap = mCapOfUngravelSociety();

      if (mCap>0) {
        newBuyPrice  = uint256(mCap / numberOfShares);
      } else
      {
        newBuyPrice  = K_BUYPR;
      }
      
      newSellPrice = newBuyPrice - (newBuyPrice/K_SPREAD);

      ownerPrices = saveOwner(newBuyPrice,newSellPrice,address(uint160(ownerPrices & K_AMASK)));

      emit AdjustGlobalSharePrice(newBuyPrice,newSellPrice);
    }

    // mint global shares

    function mint_globalShares(uint shares) internal {                       // mint new global shares if not more than K_MAXNUMBEROFSHARES
      if (shares<=0)                      return;                            // not possible, return
      if (totalSupply()>=K_INITIALSUPPLY) return;                            // require available supply to be less than threshold to mint global shares, otherwise return
      if (numberOfShares+shares>K_MAXNUMBEROFSHARES) return;                 // cannot mint more global shares than the max. number of mintable global shares, otherwise return

      balances[address(this)] += shares<<1;
      supply                  += shares;
      numberOfShares          += shares;

      emit Transfer(K_ADD00, address(this), shares);
      emit NewSharesMinted(address(this), shares);
    }

    // increaseSupply

    function increase_globalSharesSupply() internal {                        // increase nb of global shares if not more than K_MAXNUMBEROFSHARES
      // Background: This is the only method that may mint fresh global shares.

      // Only if a threshold is reached, new shares might be minted.
      // This contract may mint new shares, no-one else. External minting is disabled.

      // This method gets triggered with each BUY shares transaction.
      // It is an internal method that cannot be called from outside.

      // If max. nb of mintable shares gets reached, this method returns  - doing nothing.

      // UNGRAVELS begins with K_INITIALSUPPLY global shares.
      // It may develop and mint global shares until K_MAXNUMBEROFSHARES reached, 
      // e.g. 1000000000 x 10 = 10,000,000,000 global shares

      if (totalSupply()>=K_INITIALSUPPLY)      return;                         // check threshold, do not act if there are enough shares in supply
      if (numberOfShares>=K_MAXNUMBEROFSHARES) return;                         // cannot mint anymore - reached max. nb of mintable global shares


      uint mintable = (K_MAXNUMBEROFSHARES - numberOfShares);                  // diff = max. number of mintable gobal shares in the future
      
      if (mintable>100) {                                                      // may mint not more than 1% of the remaining mintable reserve at once, mint only in smaller steps, these steps define investment periods
        if (mintable/100==0) return;
        mint_globalShares(mintable/100);
        emit IncreasedGlobalSharesSupply(totalSupply(), mintable/100);
      } else
      {                                                                        // may mint remaining global shares 1..100 or return
        if (mintable==0) return;
        mint_globalShares(mintable);
        emit IncreasedGlobalSharesSupply(totalSupply(), mintable);
      }

      adjustPrices();                                                          // adjust buyPrice & sellPrice according to marketCap & numberOfShares, apply inflation / dilution if new shares minted
      if (totalSupply()<K_INITIALSUPPLY) return increase_globalSharesSupply(); // recursively run this method again, if totalSupply < threshold

      InvestorLiquidityOfPeriod = InvestorsLiquidity();                        // ETH reserved to investors during current investment period
      SocietyLiquidityOfPeriod  = SocietyLiquidity();                          // ETH reserved to be claimed by Ungravel Groups during current investment period
    }


    // Domain name hashes 

    function getNodeHash(address tp) internal view returns (bytes32) {       // get domain hash of "ethereum-foundation", from tokenProxy
      return keccak256( abi.encodePacked( gAbsBaseR(GWF.base()).baseNode(), keccak256( abi.encodePacked( bytes32ToStr(toLowerCaseBytes32(mb32(bytes(gAbsTpc(tp).name())))) ) ) ) ); // domain e.g. 'ethereum-foundation'
    }

    function _labelBytes32(IGAbsGwp gw,uint _tNb) internal view returns (bytes32) {                             // returns label from GWP, transNb
      return bytes32(uint256(gw.getTransactionRecord(_tNb) & K_BMASK)<<48);                                     // e.g. label name "summer"
    }

    function _labelHash(IGAbsGwp _target,uint _tNb) internal view returns (bytes32) {
      return keccak256( bytes( bytes32ToStr( _labelBytes32(IGAbsGwp(_target),_tNb) ) ) );
    }

    function _labelDomainHash(IGAbsGwp _target,uint _tNb) internal view returns (bytes32) {
      return keccak256( abi.encodePacked( _domHash(_target), _labelHash(_target,_tNb) ) );
    }

    function _labelDomainName(IGAbsGwp _gw,uint _tNb) internal view returns (string memory) {
      bytes32 labelBytes32  = _labelBytes32(IGAbsGwp(_gw),_tNb);                                                // get "label" from auction transaction of _gw
      bytes32 domainBytes32 = toLowerCaseBytes32(mb32(bytes(getReverseDNameFromAddress(address(_gw)))));        // domain name of _gw "my-group.base" | "groupname.eth"
      return concatBase32(labelBytes32, domainBytes32);                                                         // labelDName e.g. "label.my-group.base" | "mesh.rose-ill.arb"
    }

    function _validIntentionsContract(address a) private view {
      my_require(_validContract(a) && _validContract(address(IGAbsGwp(a).getIntention())) && address(getIntention())==address(IGAbsGwp(a).getIntention()),"sB");
    }

    function _auctionExecuted(IGAbsGwp _gwp, uint _id) internal view returns (bool) {
      return ( (_id>=0) && ((uint256( _gwp.getTransactionRecord(_id) ) & K_EXECUTEFLAG)!=0) );
    }

    function _isInvestorLOIinvestor(address _fund, address _investor) internal view returns (bool) {
      if (_fund==address(0))        return false;
      if (_investor==address(0))    return false;

      address[] memory loiInvestorArr = getIntention().getGroupLOIinvestors(_fund);

      if (loiInvestorArr.length==0) return false;
      if (_investor==K_ADD00)       return false;

      for (uint i=0; i<loiInvestorArr.length; i++) {
        if ((loiInvestorArr[i]!=K_ADD00) && (loiInvestorArr[i]==_investor)) return true;
      }

      return false;
    }

    function _intentionReportConsistent(address _fund, address _gwp, uint _gShares) internal view returns (bool) {
      (uint256 mCapGWP, bytes32 dhash, uint256 loiShares, uint256 shares, uint256 price, uint256 mcap) = getIntention().getFundingReport(_fund,address(_gwp));
      my_require(mCapGWP>0,"ina");
      my_require(dhash!=0x0,"inb");
      my_require(loiShares>0,"inc");
      my_require(shares==_gShares,"ind");
      my_require(price>0,"ine");
      my_require(mcap>0,"inf");
      my_require(address(GWF.getGWProxy(dhash))==_gwp,"inHsh");
      return (mCapGWP>0&&dhash!=0x0&&loiShares>0&&shares==_gShares&&price>0&&mcap>0);
    }

    function _getMarketCapOfUngravelGroup(address _fundedGWP, address _investor) internal view returns (uint) {
      (uint256 mCapGWP, bytes32 dhash, uint256 i2, uint256 i3, uint256 i4, uint256 mcap) = getIntention().getFundingReport(_fundedGWP,_investor);
      if (dhash==bytes32(mcap)) return uint(mCapGWP);
      if (i2==0) return uint(mCapGWP);
      if (i3==0) return uint(mCapGWP);
      if (i4==0) return uint(mCapGWP);
      return uint(mCapGWP);
    }


    // claimGrant

    function claimGlobalGrant(address _gwp, address _groupTokenContract, address _fund, uint gShares) public nonReentrant2 returns (uint) { // identify winning auction, and claim perhaps a grant for an eligible investor _gwp
      // Background: Ungravel Groups may invest in Funding Auctions of other groups.
      // Funding Auctions sell group shares to groups and to investors, as well as to internal members of the group.

      // Once a Funding Auction completed successfully, all relevant data is stored in the INTENTIONS contract.

      // Investing Group address, address of the group selling group shares, number of shares sold, name of Funding Auction, s.a. "summer", paid price in ETH.
      // Intentions contract also administers LOIs, Letters of Intent. Letters of Intent are required to
      // start a Funding Auction and to invite external investors, such as other Ungravel Groups.

      // If a group starts a Funding Auction without having received a LOI, only internal group members may participate and bid, 
      // thus, the group will only organize internal Funding Rounds to enhance liquidity and to grow marketCap.

      // To incentivize all Funding activities, investing groups, aka "Group Investors", may claim a grant from this Global Shares contract.
      // "Group Investors" are eligible to claim a grant if the following conditions are all met:

      //  #1 _gwp is a valid Ungravel Group, belonging to Ungravel Society on this current chain                                                      p
      //  #2 _groupTokenContract is a valid TokenProxy contract, belonging to an Ungravel Group, the "Funded Group", belonging to Ungravel Society    p
      //  #3 _gwp did send a valid LOI to the other group aka "Funded Group"                                                                          p
      //  #4 _gwp did participate in an auction to acquire group shares from the "Funded Group"                                                       p
      //  #5 _gwp did deposit ETH, did place a bid in the auction, did reveal the bid and did win the auction                                         p
      //  #6 _gwp owns "gShares" group shares of "Funded Group" that routes back to the Funding Auction                                               p
      //  #7 "gShares" is less or equal to the current group share balance that _gwp owns                                                             p
      //  #8 the Funding Auction report, provided by INTENTIONS contract, is consistent with Ungravel Society expectations                            p
      //  #9 _gwp did organize at least one auction by themselves that was completed successfully, it may be an internal Funding Round                p
      // #10 _gwp did vote on several proposals, indicating that _gwp is a group with member activities                                               p
      // #11 "Funded Group" does show member activity, such as 1 internal Funding Round completed, 1 external Funding Auction completed and voting    p
      // #12 _gwp does have certain balance in ETH, controlled by the group (avoid easy group farming)                                                p
      // #13 "Funded Group" does have a certain ETH balance, controlled by group members, avoiding group farming                                      p
      // #14 _gwp is active as a group for a period of time, members might have watched at least 1 tutorial                                           p
      // #15 "Funded Group" is active as a group for some time as well, members might have watched at least 1 tutorial                                p
      // #16 _gwp aka "Group Investor" surpasses a certain marketCap in ETH to be eligible for a grant (avoid group founding robots and farming)      p
      // #17 _gwp has a valid domain name, s.a. "we-group-investors.base" or "our-company.eth" to be eligible for a grant                             p
      // #18 "Funded Group" has a valid domain name, s.a. "we-are-funded.eth" or "my-company.one" to be eligible for a grant                          p
      // #19 _gwp does rely on the same INTENTIONS contract than this contract                                                                        p
      // #20 "Funded Group" does rely on the same INTENTIONS contract than this contract                                                              p

      my_require(__isGW(_gwp),"glL!");

      {
      my_require(_validContract(_groupTokenContract),"claim0");                             // passing: GTP is valid contract

      string memory nameTP = gAbsTpc(_groupTokenContract).name();                           // name of TokenProxy found, s.a. "Rose-ill"
      my_require(strlen(nameTP)>0,"claimTP");
      }

      bytes32 fundHash = _domHash(IGAbsGwp(_fund));                                         // dname hash of TP s.a. hash("rose-ill.eth") - of "Funded Group"
      my_require(fundHash!=0x0, "claim1a");                                                 // fundHash required to be valid

      my_require(address(_fund)!=K_ADD00,"claim1");
      my_require(_fund==address(GWF.getGWProxy(fundHash)),"claim31");                       // _fund == GWP of "Funded Group"

      __ungravelGW(fundHash);                                                               // GWP of hash is Ungravel Group
      __calledByUngravelGWP(address(_fund));                                                // passing #2
      my_require(address(_tokenContract(IGAbsGwp(_fund)))==_groupTokenContract,"claim2");   // tokenProxy, GWP and hash are consistent, all belonging to Ungravel

      my_require(gShares>0&&gAbsTpc(_groupTokenContract).balanceOf(_gwp)>=gShares,"claim3");// passing #7 passing #6

      my_require(getIntention().getIntendedLOIShares(address(_fund),_gwp)>0,"claim4");      // passing #3
      
      (address auct1, uint tNb1) = auctionTransactionRecord(IGAbsGwp(_gwp));                // auction contract and transId of Funding Auction, for investing group
      (address auct2, uint tNb2) = auctionTransactionExternal(IGAbsGwp(_fund),_gwp);        // auction contract and transId of Funding Auction, for funded    group

      my_require(_validContract(auct1),"claim32");                                          // investing group did run at least one funding auction
      my_require(_validContract(auct2),"claim33");                                          // funded group did run at least one funding auction
      my_require(auct1==auct2,"claim5");                                                    // groups refer to the same auction master contract

      my_require(tNb1>=0&&_auctionExecuted(IGAbsGwp(_gwp),tNb1),"claim6");                  // passing #9   transaction ids are valid numbers
      my_require(tNb2>=0&&_auctionExecuted(IGAbsGwp(_fund),tNb2),"claim7");                 // passing #11  transactions executed before (majority of multi-sig voted for an auction)

      my_require(getIntention().didGetFundingFrom(address(_fund),address(_gwp)),"claim8");  // passing #4   
      my_require(_isInvestorLOIinvestor(address(_fund),address(_gwp)),"claim9");            // passing #4

      my_require(_intentionReportConsistent(address(_fund),_gwp,gShares*100),"claim10");    // passing #8

      my_require(payable(address(_gwp)).balance>gAbsAuction(auct1).calculateMinAuctionPrice(),"claim12");  // passing #12
      my_require(payable(address(_fund)).balance>gAbsAuction(auct2).calculateMinAuctionPrice(),"claim13"); // passing #13

      my_require(IGAbsGwp(_gwp).getTransactionsCount()>5,"claim14");                        // passing #14  passing #10
      my_require(IGAbsGwp(_fund).getTransactionsCount()>5,"claim15");                       // passing #15

      my_require(_getMarketCapOfUngravelGroup(address(_fund),_gwp)>gAbsAuction(auct1).calculateMinAuctionPrice(),"claim16");

      {
      require(strlen(getIntention().getLOIInvestorName(address(_fund),_gwp))!=0,"claim30"); // passing #18    "some-group" *** without tld ***

      my_require(strlen( getReverseDNameFromAddress(_gwp) )!=0,"claim17");                  // passing #17  **** this might fail on ethereum mainnet ****
      my_require(strlen( getReverseDNameFromAddress(address(_fund)) )!=0,"claim18");        // passing #18  **** this might fail on ethereum mainnet ****
      }

      _validIntentionsContract(address(_gwp));                                              // passing #19
      _validIntentionsContract(address(_fund));                                             // passing #20

      my_require(_labelBytes32(IGAbsGwp(_fund),tNb2)!=0x0,"claim21");                       // auction label hash of Funding Auction s.a. hash("label") existing, derived from auction transaction
      my_require(_labelDomainHash(IGAbsGwp(_fund),tNb2)!=0x0,"claim22");                    // label domain name hash s.a. hash("label.some-group.eth") existing | hash("mesh.rose-ill.arb") = auction label domain name, resolved to BidBucket

      my_require(strlen( _labelDomainName(IGAbsGwp(_fund),tNb2) )>0,"claim23");             // string "mesh.rose-ill.arb" | "label.some-group.eth" = auction label domain name existing

      {
      (,uint tNb2b) = auctionTransactionExternal(IGAbsGwp(_fund),_gwp);                     // auction contract and transId of Funding Auction, for funded    group

      address deed = resolvedAddressFromDName( _labelDomainHash(IGAbsGwp(_fund),tNb2b) );   // BidBucket === deed, derived from winning auction and label dName
      my_require(deed!=K_ADD00,"claim24");                                                  // label dName of finalized auction gets resolved to BidBucket proxy address of the winning deed

      my_require(gAbsExtDeed(deed).beneficiary()==_gwp,"claim25");                          // passing #5   owner() of winning deed aka BidBucket proxy is the winning investor, in this case _gwp
      my_require(gAbsExtDeed(deed).registrar()==gAbsAuction(auct1),"claim26");              // registrar() === auction master contract address

      my_require(gAbsExtDeed(deed).lhash()==_labelHash(IGAbsGwp(_fund),tNb2),"claim27");    // passing #8  lhash() === fundHash, hash of target GWP, the "Funded Group", s.a. "some-group.eth" | "rose-ill.arb"
      }

      my_require(address(_getGWFromDHash(fundHash))==_fund,"claim28");                      // double-check valid funded   group using another GWF
      my_require(address(_getGWFromDHash(_domHash(IGAbsGwp(_gwp))))==_gwp,"claim29");       // double-check valid investor group using another GWF
      
      {
      my_require(address(_gwp)!=address(_fund),"claim34");                                  // cannot invest in itself!

      my_require(getIntention().getUNGmarketCap()>=10 ether,"claim35");                     // Ungavel Society more matured --> at least 10 ETH mCap Society
      }

      {
      uint mCap = _getMarketCapOfUngravelGroup(address(_fund),_gwp);                        // mCap of investing group
      my_require(mCap>=2 ether,"claim36");                                                  // Ungavel Society more matured --> at least 2 ETH mCap of group

      my_require(mCap!=0&&uint(mCap*K_PERCENT/100) <= SocietyLiquidity(),"claim37");        // liquidity check

      if ((mCap*K_PERCENT/100) <= payable(this).balance) return uint(mCap*K_PERCENT/100);   // may pay out x percent from mCap of group
      }

      return uint(0);
    }

    function payOutGlobalGrant(address _gwp, address _groupTokenContract, address _fund, uint gShares) public payable nonReentrant onlyWithGWP(_gwp) returns (uint) { // identify winning auction and deed, if eligible, pay out grant to investing _gwp
      // get auction contract address and transactionId of relevant last auction that gwp "_fund" did organize and got funding from
      // get deed of winner, where the investing group did deposit deed / bid

      (address auct2, uint tNb2) = auctionTransactionExternal(IGAbsGwp(_fund),_gwp);        // auction contract and transId of Funding Auction, for funded    group
      if ((tNb2==0) || (auct2==K_ADD00)) return 0;

      address deed = resolvedAddressFromDName( _labelDomainHash(IGAbsGwp(_fund),tNb2) );    // BidBucket of external Deed / Bid / investment
      my_require(deed!=K_ADD00&&auct2!=K_ADD00,"c40"); 

      if (grants[deed]==_gwp) return 0;                                                     // a grant can only be paid once for 1 winning BidBucket, otherwise return

      uint pay = claimGlobalGrant(_gwp,_groupTokenContract,_fund,gShares);                  // check if _gwp is eligible for a grant (really expensive method: 900.000 gas)
      if (pay==0) return 0;                                                                 // if not, return

      grants[deed]      = _gwp;                                                             // store investing _gwp - this group did receive a grant for BidBucket "deed"
      grantShares[deed] = gShares;                                                          // store nb of group shares involved *****  compute mCap/value of group shares in relation to the grant *****

      (bool succ,bytes memory returnData) = _gwp.call{ value: pay }("");                    // pay-out grant to investing group
      my_require(succ,string(abi.encode( returnData, returnData.length )));

      emit PayOutGrant(_gwp, pay);                                                          // issue a pay-out event
      return pay;
    }

    function didPayOutGrantYet(address _gwp, address _funded) public view returns (uint shares) {             // if investing _gwp did invest in _funded group and if _gwp did claim a Grant yet, return nb of shares of auction won, otherwise returns 0
      // * returns the nb of shares acquired in a successfully completed Funding Auction
      // * in case didPayOutGrantYet() returns 0, the investing group _gwp "investor" may claim a Grant,
      // * otherwise, returning the nb of shares acquired in Funding Auction.
      // * A grant can only be claimed once for each Funding Auction.
      
      (address auct2, uint tNb2) = auctionTransactionExternal(IGAbsGwp(_funded),_gwp);                        // auction contract and transId of Funding Auction, for funded    group
      if ((tNb2==0) || (auct2==K_ADD00)) return 0;

      address deed = resolvedAddressFromDName( _labelDomainHash(IGAbsGwp(_funded),tNb2) );                    // BidBucket of external Deed / Bid / investment
      if (deed!=K_ADD00&&auct2!=K_ADD00&&grants[deed]==_gwp&&grantShares[deed]>0) return grantShares[deed];   // a grant can only be paid once for 1 winning BidBucket, having completed a Funding Auction successfully
      else return 0;
    }

    function isGlobalTokenLiquid(address _gwp, address _fundedGWP) public view returns (uint) {  // return liquidity in ETH
      my_require(__isGW(_gwp),"gL!");

      uint mCap = _getMarketCapOfUngravelGroup(address(_fundedGWP),_gwp);                   // mCap of investing group

      if (mCap<2 ether)                              return 0;                              // Ungavel Society not yet matured, not liquid, yet
      if (getIntention().getUNGmarketCap()<10 ether) return 0;                              // Ungravel Global Shares requires a Society mCap of > 10 ETH

      uint grant = uint(mCap*K_PERCENT/100);                                                // 1% of Ungravel Group market cap

      if ((mCap!=0&&grant<=SocietyLiquidity()) && (grant<=payable(this).balance)) {         // liquidity check
        return grant;
      }
      return 0;
    }

    function getGWPfromTokenProxy(address _gTC) public view returns (address) {
      my_require(_validContract(_gTC),"c50");
      bytes32 _hash = getNodeHash(_gTC);
      my_require(_hash!=0x0, "claim51");
      return address(GWF.getGWProxy(_hash));
    }

    function convertGroupSharesToEther(address _groupTokenContract, uint gShares) public nonReentrant onlyGWP payable {  // 0x03425baf *** can only be called by a GroupWallet Proxy, the investing GWP, typically ***
      address fundedGWP = getGWPfromTokenProxy(_groupTokenContract);
      __calledByUngravelGWP(fundedGWP);

      my_require(gShares>0&&gAbsTpc(_groupTokenContract).balanceOf(address(this))>=gShares,"c61"); // gShares = shares * 100

      uint liquid = isGlobalTokenLiquid(msg.sender,fundedGWP);                                 // value of a typical Grant

      (uint256 mCapGWP, bytes32 dhash, uint256 loiShares, uint256 shares, uint256 pricePaid, uint256 mcap) = getIntention().getFundingReport(fundedGWP,msg.sender);
      my_require(dhash!=0x0&&loiShares>0&&shares>=gShares&&pricePaid>0,"c62");                 // silencing compiler warnings

      uint vSharesPaym = uint(mCapGWP*(gShares/100)) / 1.2e6;                                  // compute current value of gShares related to mCap of funded group
      
      my_require(vSharesPaym<payable(this).balance,"c63");                                     // check global shares contract balance
      my_require(vSharesPaym<SocietyLiquidity(),"c64");                                        // check SocietyLiquidity() 
      my_require(uint(SocietyLiquidity()/50)>liquid,"c65");                                    // check if SocietyLiquidity() may pay-out at least 50 or more Grants
      my_require(vSharesPaym>0,"c66");                                                         // buy-back price for group shares cannot be 0
      my_require(((gShares/100)*(pricePaid/(shares/100)))<=vSharesPaym,"c67");                 // buy-back price for group shares cannot be less than Funding Auction bidding price
      my_require(uint(mCapGWP*35)>mcap||mcap>100 ether,"c68");                                 // check if mCap(group) * 35 > mCap(Ungravel Society)

      (bool success,) = payable(msg.sender).call{value: vSharesPaym}("");
      my_require(success,"paym");                                                              // pay-out payment for shares **** investing GWP cannot be used here, probably cyclic function call and reverts ***

      gAbsTpc(_groupTokenContract).transfer_G8l(address(1),gShares);                           // "burn" group shares immediately by sending them to 0x0000000000000000000000000000000000000001

      emit PayForGroupShares(fundedGWP,msg.sender,vSharesPaym,gShares);                        // report buy-back conversion
    }


    // optimized aggregation of investment reports

    // collecting 11 properties of given investment = recent investment of investor _gwp acquiring _groupTokenContract group shares

    function __collectInvestmentsReport(address _gwp,address _groupTokenContract) internal view returns (uint256[] memory r) { // 0x3c396866
      uint256[] memory resultArr = new uint256[](11);

      address fundedGWP  = getGWPfromTokenProxy(_groupTokenContract);                      // can be checked via block explorer: OK

      resultArr[ 0]      = uint256(uint160(fundedGWP));                                    //_fundedGWP       - GWP that ran Funding Auction and received funding
      resultArr[ 1]      = uint256(didPayOutGrantYet(_gwp,fundedGWP));                     // grantShares     - grant based on nb of shares
      resultArr[ 2]      = uint256(isGlobalTokenLiquid(_gwp,fundedGWP));                   // grantETH        - payable grant for this Funding Auction
      resultArr[ 3]      = uint256(IGAbsGwp(fundedGWP).getTNumberPublic());                // nbTrans of fundedGWP - nb of transactions yet
      resultArr[ 4]      = uint256(SocietyLiquidity());                                    // socLiquid       - Society Liquidity

      (uint256 mCapGWP, bytes32 dhash, uint256 loiShares, uint256 shares, uint256 price, uint256 mcap) = getIntention().getFundingReport(fundedGWP,_gwp);

      resultArr[ 5]      = uint256(mCapGWP);                                               // mCapGWP         - marketCap of GWP = fundedGWP
      resultArr[ 6]      = uint256(dhash);                                                 // dhash           - domain name hash of investing group GWP
      resultArr[ 7]      = uint256(loiShares);                                             // loiShares       - nb of shares intented to acquire, LOI
      resultArr[ 8]      = uint256(shares);                                                // shares          - nb of shares offered and sold in auction
      resultArr[ 9]      = uint256(price);                                                 // price           - price offered and deposited during bidding, actually deposited amount in BidBucket
      resultArr[10]      = uint256(mcap);                                                  // mcap            - marketCap of entire Ungravel Society, i.e. the total sum of all mCaps of all Groups

      return resultArr;
    }

    // returns one investment report
    function collectAInvestmentReport(address _gwp,address _tokenC) public view returns (uint256[] memory r) {
     return __collectInvestmentsReport(_gwp,_tokenC);
    }

    // returns n investment reports
    function collectAllInvestmentReports(address[] calldata _gwpArr, address[] calldata _tokenContractArr) public view returns (uint256[] memory r) { // 0x3c396866
      uint nb = _gwpArr.length;
      my_require(nb>0&&nb==_tokenContractArr.length,"len!");

      uint256[] memory resultArr = new uint256[](11*nb);
      uint256[] memory reportArr = new uint256[](11);

      uint i;
      uint j;

      for (j=0;j<nb;j++) {
        my_require(_validContract(_gwpArr[j]),          "gwp!");
        my_require(_validContract(_tokenContractArr[j]),"tkC!");

        reportArr = __collectInvestmentsReport(_gwpArr[j],_tokenContractArr[j]);

        for (i=0;i<11;i++) {
          resultArr[(j*11)+i] = reportArr[i];
          reportArr[i]        = 0;
        }
      }

      my_require(resultArr.length>=11&&(resultArr.length % 11)==0,"rlt!");
      return resultArr;
    }

    // --------------------- Ungravel Global Token aka Ungravel Global Shares ------------------------------------

    function setIntentionGWFContract(gAbsInt intCtr, gAbsGwf gwfCtr) external payable onlyOwner {      // 0xaca2dfbb 
      // Only the deployer of this contract may update the GroupWalletFactory and Intentions contracts.

      my_require(isContract(address(intCtr))&&isContract(address(gwfCtr)),"Int");
      intent = intCtr;
      GWF    = gwfCtr;
    }

    function withdraw() external nonReentrant onlyOwner payable  {
      // Withdrawal of funding is only possible in the beginning of the Ungravel Society.
      // It cannot be done after contract did increase the MintFactor twice.
      // This is a security feature only accessable to the contract owner in case of
      // a serious problem during testing and debugging. Later, this feature will be removed.

      if (__selfbalance()==0) return;
      my_require(getMintFactor()<1199,"oOgT!");

      (bool success,) = payable(msg.sender).call{value: __selfbalance()-1}("");
      my_require(success,"WgT");
    }

    function version() public pure returns(uint256) {
      return 20010117;
    }

    receive() external payable {
      emit Deposit(msg.sender, msg.value);
    }

    constructor (address _gwf, address _intentions) payable
    { 
      my_require(_gwf!=K_ADD00,"g1");
      my_require(ownerPrices==0x0,"g2");

      supply                    = K_INITIALSUPPLY;                              // nb of global shares, held by (this) contract, available to sell, "available global shares"
      ungravel_owner            = msg.sender;
      GWF                       = gAbsGwf(_gwf);
      intent                    = gAbsInt(_intentions);
      ownerPrices               = K_SELLBUY + uint256(uint160(_gwf) & K_AMASK); // store sellPrice, buyPrice and GWF in a single byte32 slot (compatible with Ungravel TokenMaster and TokenProxy)
      balances[address(this)]   = supply<<1;

      numberOfShares            = supply;                                       // total number of global shares, number of "global shares minted"

      InvestorLiquidityOfPeriod = 0;                                            // ETH reserved to investors during current investment period
      SocietyLiquidityOfPeriod  = 0;                                            // ETH reserved to be claimed by Ungravel Groups during current investment period

      gAbsRr(GWF.reverseContract()).setName(string(abi.encodePacked('global.ungravel',intent.tld()))); // assigning reverse resolver record

      emit Deployment(msg.sender, address(this));
      emit Transfer(K_ADD00, address(this), supply);
    }
}

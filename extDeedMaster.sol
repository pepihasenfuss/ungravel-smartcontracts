// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.30;

// AuctionMaster, intDeedMaster, extDeedMaster, IntDeedProxy, BiddingProxy ( by pepihasenfuss.eth, copyright (c) 2025, 
// based on ENS 1.0 Temporary Hash Registrar, a Vickrey Auction introduced by Nick Johnson and the ENS team )
// A Vickrey auction or sealed-bid second-price auction (SBSPA) is a type of sealed-bid auction.

// ungravel.eth, GroupWalletFactory, GroupWalletMaster, GroupWallet, ProxyWallet, TokenMaster, ProxyToken, PrePaidContract, 
// AuctionMaster, BiddingProxy, intDeedMaster, extDeedMaster, IntDeedProxy, Intentions by pepihasenfuss.eth 2017-2025, Copyright (c) 2025

// AuctionMaster and Ungravel is entirely based on Ethereum Name Service, "ENS", the domain name registry.
// Although, Ungravel extends ENS to 16 different chains: EVM Names across chains create an Ungravel Unified Name Space, UUNS.

//   ENS, ENSRegistryWithFallback, PublicResolver, Resolver, FIFS-Registrar, Registrar, AuctionRegistrar, BaseRegistrar, ReverseRegistrar, DefaultReverseResolver, 
//   ETHRegistrarController, PriceOracle, SimplePriceOracle, StablePriceOracle, ENSMigrationSubdomainRegistrar, CustomRegistrar, Root, RegistrarMigration 
//   are contracts of "ENS", by Nick Johnson and team.
//
//   Copyright (c) 2018, True Names Limited / ENS Labs Limited
//
//   Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), 
//   to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, 
//   and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//   The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
//   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER 
//   LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS 
//   IN THE SOFTWARE.


// TLTR;
// AuctionMaster is a beast: It enables groups or group members to invest
// in other groups, acquiring group shares the safe way. This contract consists
// of 5 different contracts that provide safe and yet affordable funding.
//
// Funding Auctions are so-called Vickrey auctions: Winners pay the second-highest price.
//
// Ungravel auctions are safe because all participating parties act inside of UUNS:
// Ungravel Unified Name Space. Example: "ethereum.eth" invests into "ens.eth".
//
// But also "vitalik.ethereum.eth" may invest into "ethereum.eth".
//
// Everything is happing inside of UUNS, thus making outside attacks virtually impossible.
// Even smart contracts, such as "GroupWalletMaster", GWM, "AuctionMaster", AM, and other masters,
// have proper UUNS names assigned, therefore, they all are acting agents indide of UUNS. This is safe.

interface IAbsAucEns {
  function owner(bytes32 node) external view  returns(address);
  function resolver(bytes32 node) external view  returns(address);
  function ttl(bytes32 node) external view  returns(uint64);
  function setOwner(bytes32 node, address ensowner)  external;
  function setSubnodeOwner(bytes32 node, bytes32 label, address ensowner)  external;
  function setResolver(bytes32 node, address ensresolver)  external;
  function setTTL(bytes32 node, uint64 ensttl)  external;
  function recordExists(bytes32 nodeENS) external view returns (bool);

  event NewOwner(bytes32 indexed node, bytes32 indexed label, address ensowner);
  event Transfer(bytes32 indexed node, address ensowner);
  event NewResolver(bytes32 indexed node, address ensresolver);
  event NewTTL(bytes32 indexed node, uint64 ensttl);
}
abstract contract AbsTokenProxy {
  function owner() external virtual view returns (address ow);
  function balanceOf(address tokenOwner) external virtual view returns (uint thebalance);
  function name() external virtual view returns (string memory);
  function transferFrom_78S(address from, address toReceiver, uint amount) external virtual;
  function tokenAllow(address tokenOwner,address spender) external virtual view returns (uint256 tokens);
  function transfer_G8l(address toReceiver, uint amount) external virtual;
  function transferAdjustPrices(address toReceiver, uint amount, uint payment, bytes32 dhash, address deedContract) external virtual;
  function nameBidBucket(bytes32 dhash,bytes32 labelhash,address deedContract) external virtual;
}
abstract contract AbsResolver {
  event AddrChanged(bytes32 indexed node, address a);
  event AddressChanged(bytes32 indexed node, uint coinType, bytes newAddress);
  event NameChanged(bytes32 indexed node, string name);
  event ABIChanged(bytes32 indexed node, uint256 indexed contentType);
  event PubkeyChanged(bytes32 indexed node, bytes32 x, bytes32 y);
  event TextChanged(bytes32 indexed node, string indexed indexedKey, string key);
  event ContenthashChanged(bytes32 indexed node, bytes hash);
  function name(bytes32 node) external virtual view returns (string memory);
  function addr(bytes32 node) external virtual view returns (address payable);
  function setABI(bytes32 node, uint256 contentType, bytes calldata data) external virtual;
  function setAddr(bytes32 node, address r_addr) external virtual;
  function setAddr(bytes32 node, uint coinType, bytes calldata a) external virtual;
  function setName(bytes32 node, string calldata _name) external virtual;
  function setText(bytes32 node, string calldata key, string calldata value) external virtual;
  function setAuthorisation(bytes32 node, address target, bool isAuthorised) external virtual;
  function supportsInterface(bytes4 interfaceId) external virtual view returns (bool);
}
abstract contract AbsReverseRegistrar {
  IAbsAucEns   public immutable ens;
  AbsResolver public defaultResolver;
  function setName(string memory name) external virtual returns (bytes32);
  function node(address addr) external virtual pure returns (bytes32);
}
abstract contract AbsIntentions {
  function getGWF() public virtual view returns (AbsGwf);
  function saveLetterOfIntent(address target, uint nbOfShares) public virtual payable;
  function getIntendedLOIShares(address target, address investor) public virtual view returns (uint);
  function mCap(address _gwp) public virtual view returns (uint);
  function getGlobalTokenAddr() public virtual view returns (address);
}
abstract contract AbsGwp {
  function getIsOwner(address _owner)      external view virtual returns (bool);
  function getOwners()                     external view virtual returns (address[] memory);
  function getGWF()                        external view virtual returns (address);
  function getTransactionsCount()          external view virtual returns (uint);
  function getTransactionRecord(uint _tNb) external view virtual returns (uint256);
  function getIntention()                  public   view virtual returns (AbsIntentions);
}
abstract contract NmWrapper {
  function setSubnodeRecord(bytes32 parentNode,string memory label,address owner,address resolver,uint64 ttl,uint32 fuses,uint64 expiry) external virtual returns (bytes32 node);
  function setSubnodeOwner(bytes32 node,string calldata label,address newOwner,uint32 fuses,uint64 expiry) external virtual returns (bytes32);
  function ownerOf(uint256 id) external virtual view returns (address);
  function setApprovalForAll(address operator,bool approved) external virtual;
}
abstract contract AbsGwf {
  NmWrapper public  ensNameWrapper;
  IAbsAucEns public  ens;
  function getProxyToken(bytes32 _domainHash) public virtual view returns (address p);
  function getGWProxy(bytes32 _dHash) external view virtual returns (address);
  function getOwner(bytes32 _domainHash) external view virtual returns (address);
  function getGWF() external view virtual returns (address);
}
abstract contract AbsReg {
  AbsReverseRegistrar public reverseR;
  function __calledByUngravelGWP(address sender) public virtual view;
  function __calledByGWMember(bytes32 _hash) public virtual view returns (bool);
  function state_pln(bytes32 _hash) public view virtual returns (uint);
  function saveExtDeedCntr_gm9(address _sender,bytes32 _hash,uint _value) public payable virtual;
  function unsealExternalBid_qfG(bytes32 _hash) public payable virtual;
  function finalizeExternalAuction_WmS(bytes32 _hash) public payable virtual;
  function cancelExternalBid_9ig(bytes32 seal, bytes32 hash) public payable virtual;
}
abstract contract AbsIntDeedMaster {
  AbsReg public theRegistrar;
}
abstract contract AbsExtDeed {
  AbsReg  public  registrar;
  address public  beneficiary;
}
abstract contract AbsGenericDeed {
  address public  owner;
  address public  beneficiary;
  uint64  public  creationDate;
  function closeDeed_igk(address receiver) public virtual payable;
  function adjustBal_1k3(uint newValue) external virtual payable;
}
abstract contract AbsMultiFour {
  address   public masterCopy; // deployer, owner of this contract
  AbsGwf    public GWF;        // GroupWalletFactory Ungravel.com
  event Deployment(address owner, address theContract);
  event DeploymentMulticall4(address theContract, bytes32 dhash);
  event Deposit(address from, uint256 value);
  function tld() public virtual view returns (string memory);
  function chainName() public virtual view returns (string memory);
}
bytes32 constant KSALT = 0x4db45745d63e3d3fca02d388bb6d96a256b72fa6a5ca7e7b2c10c90c84130f3b;

// ******************************* EXT DEED MASTER CONTRACT ********************
// An external bidder is also an Ungravel Group. A proxy bidding contract is deployed
// for each external bidder in order to participate in a Funding Auction.
//
// Any group will issue a Letter of Intent, LOI, before it can invest in any other group.
//
// The Letter of Intent indicates interest in investing into the other group,
// potentially participating in future Funding Auctions.
//
// Example: The Group "ethereum.eth" shows interest in "ens.eth" and sends an LOI,
// the Letter of Intent, indicating its interest to invest into ens.eth.
//
// The group "ens.eth" will have to complete one internal auction, first of all.
//
// Let‘s assume that "ens.eth" needs a bit of funding and one of the members invests
// during an internal funding auction, then he or she or it gets more group shares,
// consequently, the group gets common funding and increased liquidity.
//
// The internal funding auction is for group members only. It can be considered an 
// ultra-sound method to deposit common assets. Only group majority may decide on how
// to use the funding and what to do with it.
//
// Once completed, the group is entitled to organize an External Funding Auction.
// It has "qualified" to proceed and to target external investors.
//
// Since "ethereum.eth" did show interest, "ens.eth" starts yet another auction,
// this time around, they also create / deploy a BidBucket, aka BiddingProxy.
// This is a simple contract that enables external groups to bid in a Funding Auction, the safe way.

// Why so complicated?
//
// Because only an auction provides a safe and fair method to 
// distribute group shares: To members of the group, who can always bid in any auction.
//
// To other groups, aka external investors, who want to acquire a stake of the group.
//
// The auction we are using was first introduced by ENS, Nick Johnson and his team, back then.
// It is a so-called Vickrey Auction, a blind auction, where the winner will only pay
// the second-highest bid price, if he wins the auction. The Vickrey auction is a complicated
// beast itself. But it offers some advantages: Economists and researches argue that the
// Vickrey auction ultimately leads to better results, since each bidder is incentivized
// to bet a "fair" price for group shares. Knowing that he will only pay the second-best price!
// This is inventives design at its best!
// Anyway, since this type of auction was done before, in a smart contract on Ethereum,
// we decided to adapt the concept to Ungravel Funding requirements. Thanks to ENS and Nick Johnson, btw.

// This master contract, AuctionMaster, is yet another beast: It is a master that 
// deploys two other master contracts: The "intDeedMaster" and the "extDeedMaster".
//
// Both deed master contracts are needed to offer slightly different functionality  
// during an auction, depending on internal or external bidders.
//
// Why so many masters?
//
// Both masters are needed to safe gas and funding! Otherwise, deployment of bidding contracts
// would have been too costly. Therefore, we decided that we need two more contracts:
// The "IntDeedProxy" aka internal deed and bidding proxy contract, and the 
// "BiddingProxy" aka the external deed and bidding proxy contract.
//
// Yes, this leads to 5 contracts in a single solidity file. Sorry, but needed.
//
// Consequently, implementation and APIs to access 5 contracts introduced more complexity.
//
// But this is not true from the perspective of a group or a group member, seen from
// the user. From her or his or its point-of-view, this leads to ultra-safe bidding
// procedures, each bid gets its own bidding proxy installed. Since we are using
// proxies, this is still relatively cheap. It can even be used on Ethereum mainnet :)

// Consider each bidding proxy, a safe deposit contract, where each bidder may deposit
// its bid, sometimes also known as a "deed". The bid remains safe under all circum-
// stances. It can only be delegated, forwarded to the organizers of the auction,
// if bidder did actually win the auction. Otherwise, it can only be sent back to bidder,
// if he/she/it does not reveal his bid or will have to cancel the bid at the end, in
// the case that someone else won the auction. In the end, bidding proxies, combined
// with Ungravel Unified Name Space, UUNS, offer superior safety for investing on all EVM chains.
//
// Due to UUNS, only groups or group members may participate, all other senders will be rejected.
// Yes, this is closed society of participants, each of them ligitimate, authenticated by
// the unified name space, UUNS. This is a party for invited guest only.
//
// Ungravel contracts involved, such as this "AuctionMaster", the "intDeedMaster" or the 
// "extDeedMaster", they all have proper UUNS domain names themselves, leading to a
// ultra-safe, closed and unified name space of participating agents: Whether it is a 
// group, a group member, or any of the Master contracts, they all belong to Ungravel UUNS.
//
// In this respect, UUNS is a closed, gated, safe domain, enabling ultra-sound group investments. 
// UUNS is available on 16 different EVM compatible chains, s.a.: Ethereum, BNBmainnet, Base,
// Arbitrum, Optimism, Polygon, Unichain and others.

pragma solidity 0.8.30;
contract extDeedMaster {
  address internal           masterCopy;
  uint64  public             creationDate;
  AbsReg  public             registrar;   // registrar = Auction Registrar = AuctionMaster
  bytes32 public             lhash;
  address public             beneficiary;

  event DeedMasterCreated(address indexed);
  event NewBid(address indexed);
  event RevealBid(address indexed);
  event CancelBid(address indexed);
  event FinalizeBid(address indexed);
  event AdjustBalance(uint indexed, uint indexed);
  event CloseDeed(address indexed, address indexed);
  uint256 private _guardCounter   = 1;
  uint256 private _guardCounter2  = 1;

  modifier nonReentrant() {
      _guardCounter += 1;
      uint256 localCounter = _guardCounter;
      _;
      my_require(localCounter == _guardCounter,"r");
  }
  modifier nonReentrant2() {
      _guardCounter2 += 1;
      uint256 localCounter2 = _guardCounter2;
      _;
      my_require(localCounter2 == _guardCounter2,"t");
  }
  modifier onlyReg() {
      my_require(msg.sender==address(registrar),"o");
      _;
  }
  modifier onlyGWP() {
    registrar.__calledByUngravelGWP(msg.sender);
    _;
  }

  constructor(string memory _extDName) payable
  {
    masterCopy   = msg.sender;                                                     // auction master contract
    registrar    = AbsReg(msg.sender);                                             // registrar = AuctionMaster
    creationDate = uint64(block.timestamp);
    emit DeedMasterCreated(address(this));
    AbsReverseRegistrar(registrar.reverseR()).setName(_extDName);
  }

  function my_require(bool b, string memory str) internal pure {
    require(b,str);
  }

  function getMasterCopy() external view returns (address) { return masterCopy; }

  function adjustBal_1k3(uint newValue) external nonReentrant onlyReg payable {    // 0x0000f6a6 (short cmd ids are cheaper)
    uint thisBal = address(this).balance;
    my_require(thisBal!=0,"a");
    if (thisBal<=newValue) return;
    payable(beneficiary).transfer(thisBal-newValue);
    my_require(address(this).balance==newValue,"A");
    emit AdjustBalance(thisBal,newValue);
  }

  function closeDeed_igk(address receiver) external nonReentrant onlyReg payable { // 0x00004955 (short cmd ids are cheaper)
    payable(address( (receiver!=address(0)) ? receiver : beneficiary )).transfer(address(this).balance);
    my_require(address(this).balance==0,"B");
    emit CloseDeed(address(this),receiver);
  }
  
  receive() external nonReentrant2 onlyGWP payable {                               // receiving fallback function, catches all extDeedProxy calls
    uint lstate      = registrar.state_pln(lhash);
    uint lvalue      = msg.value;
    address lsender  = msg.sender;
    uint lthisBal    = address(this).balance;

    if (lstate==1) {                                                               // OPEN for bidding
      my_require(lhash!=0x0&&lvalue!=0&&lthisBal==lvalue,"C");
      beneficiary = lsender;
      registrar.saveExtDeedCntr_gm9(lsender,lhash,lvalue);
      emit NewBid(lsender);
    } else
    {
      my_require(lhash!=0x0&&lvalue==0&&beneficiary==lsender,"D");                 // only deed owner calls without ETH, cancel & finalize DO NOT need funding!

      if (lstate==4) {                                                      
        registrar.unsealExternalBid_qfG(lhash);                                    // REVEAL phase
        emit RevealBid(lsender);
      } else
      {
        if (lstate==2) {                                                           // FINALIZE phase
          registrar.finalizeExternalAuction_WmS(lhash);
          emit FinalizeBid(lsender);
        } else
        {
          if (lstate==6) {                                                         // CANCEL - auction done, no time-out
            registrar.cancelExternalBid_9ig(keccak256(abi.encode(lhash,beneficiary,lthisBal,KSALT)),lhash);
            emit CancelBid(lsender);
          } else
          {
            if (lstate==0) {                                                       // TIMEOUT - auction done, no bidding revealed and not finalized
              payable(beneficiary).transfer(lthisBal);
              my_require(address(this).balance==0,"E");
              emit CancelBid(lsender);
            }
          }
        }
      }
    }
  }
}

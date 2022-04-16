# Decentralized Equity Funding (DEF)

## About
This DApp sets itself the goal to facilitate Equity Funding decentrally by allowing companies to issue their individual non-fungiable Equity Token (EQT) on Tezos  - or in other words: to go public. Once a company undergoes an IPO through this DApp, anyone believing in said company can mint its EQT. As of now, holding EQT implicates trustworhty ownership 

The benefit of this DApp
- disintermediation of investment banks for IPOs and FPOs
    - no dependence of companies on investment banks to go public
    - companies can decide when to go public 
    - less cost for companies to go public
- open primary market 
    - more buyers = more competition = more efficient primary market
    - inclusion of all and no favouring of selected big players of the traditional financial industry
- Dividend payments in Crypto with possibility to get automated in trustworthy manner
- future benefits
    - company becomes a DAO like institution (e. g. voting system for all EQT holders)

Downside of this DApp
- creates platform for equity funding but does not support companies in how to get public (e. g. setting mintPrice, total amount of shares and amount that can be minted) --> complete disintermation of investment banks is doubtful

- lacks scaling: not ready for mass usage


## text below needsd to be changed

## Technology Stack & Tools

- Solidity (Writing Smart Contract)
- Javascript (React & Testing)
- [Ethers](https://docs.ethers.io/v5/) (Blockchain Interaction)
- [Hardhat](https://hardhat.org/) (Development Framework)
- [Ipfs](https://ipfs.io/) (Metadata storage)
- [React routers](https://v5.reactrouter.com/) (Navigational components)

## Requirements For Initial Setup
- Install [NodeJS](https://nodejs.org/en/), should work with any node version below 16.5.0
- Install truffle@tezos (e. g. npm install -g truffle@tezos)

## Setting Up
### 1. Clone/Download the Repository

### 2. Install Dependencies:
```
$ cd nft_marketplace
$ npm install
```
### 3. Boot up local development blockchain
```
$ cd nft_marketplace
$ npx hardhat node
```

### 4. Connect development blockchain accounts to Metamask
- Copy private key of the addresses and import to Metamask
- Connect your metamask to hardhat blockchain, network 127.0.0.1:8545.
- If you have not added hardhat to the list of networks on your metamask, open up a browser, click the fox icon, then click the top center dropdown button that lists all the available networks then click add networks. A form should pop up. For the "Network Name" field enter "Hardhat". For the "New RPC URL" field enter "http://127.0.0.1:8545". For the chain ID enter "31337". Then click save.  


### 5. Migrate Smart Contracts
`npx hardhat run src/backend/scripts/deploy.js --network localhost`

### 6. Run Tests
`$ npx hardhat test`

### 7. Launch Frontend
`$ npm run start`

License
----
MIT


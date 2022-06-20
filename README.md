# Decentralized Equity Funding (DEF)

## About
This repository contains the smart contract "EQT" which was intended to be one of two smart contracts, functioning as the basis for a DApp, called DEF. This DApp's goal is to facilitate Equity Funding decentrally by allowing companies to issue their individual non-fungiable Equity Token (EQT) on Tezos  - or in other words: to go public. Once a company undergoes an IPO through this DApp, anyone believing in said company can mint its EQT. Holding EQT implicates trustworhty ownership of the underlying company adn comes with benefits like dividend payments and voting power. In the following, I will briefly outline the up- and downside of the proposed DEF DApp. 

Upside of DEF DApp:
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

Downside of DEF DApp:
- creates platform for equity funding but does not support companies in how to get public (e. g. setting mintPrice, total amount of shares and amount that can be minted) --> complete disintermation of investment banks is doubtful

- lacks scaling: not ready for mass usage

## Requirements For Initial Setup
- Install [NodeJS](https://nodejs.org/en/)
- Install truffle@tezos (e. g. npm install -g truffle@tezos)
- Define storage like: 
    company := [issuer = ("tz1KqTpEZ7Yob7QbPE4Hy4Wo8fHG8LhKxZSx" : address);
    total_eqt = 0n;
    released_eqt = 0n;
    price = 0n;
    sold_eqt = 0n;
    holders : holders = Big_map.empty;
    balanceOfHolder : balanceOfHolder = Big_map.empty];
(how to define the storage for ligolang web IDE: https://github.com/giraffekey/tezos-harberger-nft [examplary storage: https://tacode.dev/courses/dev-starter/chapters/9de56ed8-b2bb-48fa-a013-59eb5100308d])

## Technology Stack & Tools
- PacalLIGO (Writing Smart Contract)
- Javascript (Testing)
- [Truffle](https://trufflesuite.com/docs/tezos/truffle/quickstart/) (Development Framework)

License
----
MIT


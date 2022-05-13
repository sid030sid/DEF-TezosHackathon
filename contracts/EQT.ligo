type holders is big_map (nat, address) 
type balanceOfHolder is big_map (address, nat)

type company is record [
    issuer : address;
    total_eqt : nat;
    released_eqt : nat;
    price : nat;
    sold_eqt : nat; //counter = id of upcoming EQT token
    holders : holders; //eqt token id -> address of its holder
    balanceOfHolder : balanceOfHolder //address of holder -> amount of eyt token holder is holding
]

//records for function arguments
type ipo_args is record [
    total_eqt_ : nat;
    released_eqt_ : nat;
    price_ : nat
]

type fpo_args is record [
    total_eqt_ : nat;
    released_eqt_ : nat;
    price_ : nat
]

type mint_args is record [
    amount_ : nat
]

//return arguments for all functions
type return is (list (operation) * company)

//functions as a constructor
//note: this function can only be called once and most notably sets the issuer of the newly public company 
function ipo (var company : company; const total_eqt_ : nat; const released_eqt_ : nat; const price_ : nat) : return is
  block {
    assert(company.total_eqt = 0n and company.released_eqt = 0n) (* "Company already initialised! Use fpo function!" *);
    company := company with record [ 
        issuer = Tezos.sender;
        total_eqt = total_eqt_;
        released_eqt = released_eqt_;
        price = price_;
        sold_eqt = 0n;
    ];
} with ((nil : list (operation)), company);

function fpo (var company : company; const total_eqt_ : nat; const released_eqt_ : nat; const price_ : nat) : return is
  block {
    assert(Tezos.sender = company.issuer) (* "Sender not allowed to perform FPO!" *);
    assert(company.sold_eqt = company.released_eqt) (* "Not all EQT token of previous financing round sold, thus FPO not allowed." *);
    company := company with record [ 
        total_eqt = total_eqt_;
        released_eqt = released_eqt_;
        price = price_;
    ];
} with ((nil : list (operation)), company);

function mint (var company : company; const amount_ : nat) : return is
  block {

    //make sure minting is possible
    assert((company.sold_eqt + amount_) <= company.released_eqt) (* "Not enough EQT tokens left!" *);
    assert((company.price * amount_) >= (Tezos.amount / 1mutez)) (* "Not enough money to pay for mint!" *);
    
    //get receiver of mint payment (= company.issuer)
    const receiver : contract (unit) = case (Tezos.get_contract_opt (company.issuer) : 
        option (contract (unit))) of [
            Some (contract) -> contract
            | None -> (failwith ("No contract.") : contract (unit))
        ]
    ;

    //transfer money to issuer of EQT token
    const pay_issuer : operation = Tezos.transaction(unit, Tezos.amount, receiver); //receiver before: (Tezos.get_contract(company.issuer) : contract(unit)) //Tezos.get_contract_opt(company.issuer)
    
    //perform minting
    var _eqtId := 0n;
    var _i := 0n;
    var holders := company.holders;
    var balanceOfHolder := company.balanceOfHolder;
    while (_i < amount_) {
        //get id of current eqt token = sold_eqt
        _eqtId := company.sold_eqt;

        //update company's count of eqt (=> sold_eqt++) first to avoid re-entrancy attack
        patch company with record [sold_eqt = company.sold_eqt + 1n];
        
        //update compny's holders and write new owner of eqt on blockchain
        holders[_eqtId] := Tezos.sender;

        //update balance of holder
        const currentBalance : nat = case balanceOfHolder[Tezos.sender] of [
            Some (x) -> x
            | None -> 0n
        ];
        balanceOfHolder[Tezos.sender] := currentBalance + 1n;

        //write updates on to blockchain
        patch company with record [holders = holders; balanceOfHolder = balanceOfHolder];

        _i := _i + 1n;
    };

} with ((list [pay_issuer] : list(operation)), company);

//router for main
type router_enum is
    | Ipo of ipo_args
    | Fpo of fpo_args
    | Mint of mint_args
;

function main (const action : router_enum; const company : company) : return is case action of [
    | Ipo(match_action) -> ipo(company, match_action.total_eqt_, match_action.released_eqt_, match_action.price_)
    | Fpo(match_action) -> fpo(company, match_action.total_eqt_, match_action.released_eqt_, match_action.price_)
    | Mint(match_action) -> mint(company, match_action.amount_)
  ]
;
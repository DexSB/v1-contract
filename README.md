# CryptoSports SmartContract

## Oracle Contract

### Contract Address
[0x5EEa4DB64c237EC468979cf5D900F5Cb05d5838E](https://aminox.blockscout.alphacarbon.network/address/0x5EEa4DB64c237EC468979cf5D900F5Cb05d5838E)

### Variables

* eventResult \
storage of the game result, e.g. Laker vs. Bulls

* outrightResult \
storage of the outright game result, e.g. NBA 21-22 Final Winner 

### Functions

#### uploadEventResult
* Parameters
	* uint256 version: version or the event result
	* bytes resultBytes: result in bytes

* Description \
this function is only accessible for result uploader account. \
if result exist, replace it with the new result


#### uploadOutringtResult
* Parameters
	* uint256 version: version or the outright result
	* bytes resultBytes: result in bytes

* Description \
this function is only accessible for result uploader account. \
if result exist, replace it with the new result

\
\
\
\
\

## SingleBet Engine Contract

### Contract Address
[0xb1BF4538AfC3EAbCAe9aBCD4E0300E4A0B2907D8](https://aminox.blockscout.alphacarbon.network/address/0xb1BF4538AfC3EAbCAe9aBCD4E0300E4A0B2907D8)

### Variables
* priceFactor \
the ratio of the price is increased, e.g. the price is 0.89 and we'll turn it to 89 and the price factor should be 100. \
this value should depend on the ticket version.

* hdpFactor \
the ratio of the handicap is increased, e.g. the handicap is 3.5 and we'll turn it to 350 and the handicap factor should be 100. \
this value should depend on the ticket version.

### Functions

#### settleBet
* Parameters
	* uint256 eventId: the id of the game that want to be settled
	* address oralce: the address of the result storage
  * bytes data: ticket data in bytes

* Description \
ticket will decode and get the final result of the ticket, return the settlement and payments.

#### processTicket
* Parameters
  * address signer: to verify the ticket is signed with our services.
  * uint nonce: the nonce of user in SingleBet contract.
  * bytes data: ticket data with signature

* Description \
ticket will be decode and verify, after the verify, the max payout and receipt will be created base on the ticket information.

#### rejectBet
* Parameters
	* bytes bytesTicket: ticket data in bytes

* Description \
get return value from the ticket bytes.

\
\
\
\
\

## SingleBet Contract

### Contract Address
[0x3A4282A26A2c2f60612117E115b14fb1fcc1f1CF](https://aminox.blockscout.alphacarbon.network/address/0x3A4282A26A2c2f60612117E115b14fb1fcc1f1CF)

### Variables
* signer \
confirm the ticket is signed by our services

* settler \
this is the address to settle the ticket and transfer money to the winner

* rejecter \
if player didn't send the place bet transaction in time or we found the ticket is the ***DANGER*** ticket, \
we'll reject the ticket and return the stake amount to the player, and the reject function is only accessible with this account

* oracle \
contract address of game result

* versionEngineMap \
to prevent the version upgrade take too much time for migration the ticket, \
user send the transaction with version and data in bytes, each version will be decode and handle with the specific ticket engine contract, \
the version and the address mapping will be defined here.

* ticketsV1 \
storage of the tickets

### Functions

#### settleBet
* Parameters
	* uint256 eventId: the id of the game that want to be settled
	* uint256[] transIds: unique ticket ids

* Description \
this function is only accessible for settler account. \
get ticket from the storage ticketsV1, if ticket exist, send the eventId, oracle address and ticket data with low-level call to ticket engine. \
send token and event base on the settlement return from ticket engine.

#### placeBet
* Parameters
  * uint256 version: ticket version 
  * bytes signedTicketBytes: ticket data with signature

* Description \
function for player to place bet, ticket will be decode with ticket engine and return a receipt of bet, \
we will transfer money from player and the licensee, and save the ticket information after the transactions success.

#### rejectBet
* Parameters
	* uint256[] transIds: unique ticket ids

* Description \
this function is only accessible for rejecter account. \
delete the bet listed in transIds, return token to player and delete the ticket in storage

\
\
\
\
\

## OutrightBet Engine Contract

### Contract Address
[0xfE12aE1bb4D17ed5aFD44973a30916fE39540025](https://aminox.blockscout.alphacarbon.network/address/0xfE12aE1bb4D17ed5aFD44973a30916fE39540025)

### Variables
* priceFactor \
the ratio of the price is increased, e.g. the price is 0.89 and we'll turn it to 89 and the price factor should be 100. \
this value should depend on the ticket version.

### Functions

#### settleBet
* Parameters
	* uint256 leagueId: the id of the league that want to be settled
	* address oralce: the address of the result storage
  * bytes data: ticket data in bytes

* Description \
ticket will decode and get the final result of the ticket, return the settlement and payments.

#### processTicket
* Parameters
  * address signer: to verify the ticket is signed with our services.
  * uint nonce: the nonce of user in SingleBet contract.
  * bytes data: ticket data with signature

* Description \
ticket will be decode and verify, after the verify, the max payout and receipt will be created base on the ticket information.

#### rejectBet
* Parameters
	* bytes bytesTicket: ticket data in bytes

* Description \
get return value from the ticket bytes.

\
\
\
\
\

## OutrightBet Contract

### Contract Address
[0x6E203093C942542365642e1389dd92FeAf6FEcD7](https://aminox.blockscout.alphacarbon.network/address/0x6E203093C942542365642e1389dd92FeAf6FEcD7)

### Variables
* signer \
confirm the ticket is signed by our services

* settler \
this is the address to settle the ticket and transfer money to the winner

* rejecter \
if player didn't send the place bet transaction in time or we found the ticket is the ***DANGER*** ticket, \
we'll reject the ticket and return the stake amount to the player, and the reject function is only accessible with this account

* oracle \
contract address of game result

* versionEngineMap \
to prevent the version upgrade take too much time for migration the ticket, \
user send the transaction with version and data in bytes, each version will be decode and handle with the specific ticket engine contract, \
the version and the address mapping will be defined here.

* ticketsV1 \
storage of the tickets

### Functions

#### settleBet
* Parameters
	* uint256 leagueId: the id of the league that want to be settled
	* uint256[] transIds: unique ticket ids

* Description \
this function is only accessible for settler account. \
get ticket from the storage ticketsV1, if ticket exist, send the leagueId, oracle address and ticket data with low-level call to ticket engine. \
send token and event base on the settlement return from ticket engine.


#### placeBet
* Parameters
  * uint256 version: ticket version 
  * bytes signedTicketBytes: ticket data with signature

* Description \
function for player to place bet, ticket will be decode with ticket engine and return a receipt of bet, \
we will transfer money from player and the licensee, and save the ticket information after the transactions success.

#### rejectBet
* Parameters
	* uint256[] transIds: unique ticket ids

* Description \
this function is only accessible for rejecter account. \
delete the bet listed in transIds, return token to player and delete the ticket in storage

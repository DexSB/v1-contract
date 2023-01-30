abi-out:
	mkdir -p output
	jq '.abi' ./out/TestNextfortuneToken.sol/TestNextfortuneToken.json >> ./output/TestNextfortuneTokenAbi.json
	jq '.abi' ./out/OracleV1.sol/OracleV1.json >> ./output/OracleV1.json
	jq '.abi' ./out/SingleBetV1.sol/SingleBetV1.json >> ./output/SingleBetV1.json
	jq '.abi' ./out/OutrightBetV1.sol/OutrightBetV1.json >> ./output/OutrightBetV1.json

build:
	forge build --extra-output metadata

clean:
	forge clean

debug:
	forge test -vvvvv --match $(fx)

deploy-test:
	forge test -vvv

deps-oz:
	forge install openzeppelin/openzeppelin-contracts@v4.7.2
	forge install openzeppelin/openzeppelin-contracts-upgradeable@v4.7.2

flatten:
	mkdir -p output
	forge flatten ./src/lib/TestNextfortuneToken.sol >> ./output/TestNextfortuneToken.sol
	forge flatten ./src/OracleV1.sol >> ./output/OracleV1.sol
	forge flatten ./src/SingleBetV1.sol >> ./output/SingleBetV1.sol
	forge flatten ./src/OutrightBetV1.sol >> ./output/OutrightBetV1.sol

run-devnode:
	docker run --rm -p 9944:9944 -p 9933:9933 --name amino-dev gcr.io/alpha-carbon/amino:v0.9.0 --dev --execution=native --ws-external --rpc-external --sealing 3000 -linfo,pallet_ethereum=trace,evm=trace,pallet_vrf_oracle=error

try-signature:
	forge test -vvvvv --match GetSignature

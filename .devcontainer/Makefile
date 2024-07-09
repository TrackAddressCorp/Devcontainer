include .env

################################################
# 
# w3 DID commands for web3.storage from filecoin
# 
################################################

# create did
w3did:
	w3 space create > ../w3DIDprivate.key

# create space
w3space:
	w3 space create $(name); \
	@DID=$$(cat ../w3DIDprivate.key); \
	w3 delegation create -c 'store/*' -c 'upload/*' $$DID -o proof.ucan

################################################
#
# stylus commands
#
################################################

# create new stylus project
stnew:
	cargo stylus new $(name)

# check if project valid
stcheck:
	cargo stylus check

# estimate gas fee
stgas:
	cargo stylus deploy \
	--private-key-path=../w3DIDprivate.key \
	--estimate-gas-only

# deploy contract
stdeploy:
	cargo stylus deploy \
	--private-key-path=../w3DIDprivate.key

# export contract abi
stabi:
	cargo stylus export-abi

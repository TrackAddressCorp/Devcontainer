include .env

# w3 DID commands for web3.storage from filecoin

w3did:
	w3 space create > w3DIDprivate.key

w3space:
	w3 space create name; \
	@DID=$$(cat w3DIDprivate.key); \
	w3 delegation create -c 'store/*' -c 'upload/*' $$DID -o proof.ucan


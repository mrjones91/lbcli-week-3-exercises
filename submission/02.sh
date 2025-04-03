# Create a native segwit address and get the public key from the address.
addy=$(bitcoin-cli -regtest getnewaddress -addresstype bech32)
PUB_KEY=$(bitcoin-cli -regtest getaddressinfo $addy | jq -r '.pubkey')
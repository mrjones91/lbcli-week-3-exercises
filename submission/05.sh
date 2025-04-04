# # Create a partially signed transaction from the details below

# # Amount of 20,000,000 satoshis to this address: 2MvLcssW49n9atmksjwg2ZCMsEMsoj3pzUP 
# # Use the UTXOs from the transaction below
# # transaction="01000000000101c8b0928edebbec5e698d5f86d0474595d9f6a5b2e4e3772cd9d1005f23bdef772500000000ffffffff0276b4fa0000000000160014f848fe5267491a8a5d32423de4b0a24d1065c6030e9c6e000000000016001434d14a23d2ba08d3e3edee9172f0c97f046266fb0247304402205fee57960883f6d69acf283192785f1147a3e11b97cf01a210cf7e9916500c040220483de1c51af5027440565caead6c1064bac92cb477b536e060f004c733c45128012102d12b6b907c5a1ef025d0924a29e354f6d7b1b11b5a7ddff94710d6f0042f3da800000000"


tx=$(bitcoin-cli -regtest decoderawtransaction 01000000000101c8b0928edebbec5e698d5f86d0474595d9f6a5b2e4e3772cd9d1005f23bdef772500000000ffffffff0276b4fa0000000000160014f848fe5267491a8a5d32423de4b0a24d1065c6030e9c6e000000000016001434d14a23d2ba08d3e3edee9172f0c97f046266fb0247304402205fee57960883f6d69acf283192785f1147a3e11b97cf01a210cf7e9916500c040220483de1c51af5027440565caead6c1064bac92cb477b536e060f004c733c45128012102d12b6b907c5a1ef025d0924a29e354f6d7b1b11b5a7ddff94710d6f0042f3da800000000)

utxo_txid_1=$(echo $tx | jq -r '.txid')
utxo_vout_1=$(echo $tx | jq -r '.vout.[0].n')
utxo_txid_2=$(echo $tx | jq -r '.txid')
utxo_vout_2=$(echo $tx | jq -r '.vout.[1].n')

recipient=2MvLcssW49n9atmksjwg2ZCMsEMsoj3pzUP

rawtxhex=$(bitcoin-cli -regtest -named createrawtransaction inputs='''[ { "txid": "'$utxo_txid_1'", "vout": '$utxo_vout_1' }, { "txid": "'$utxo_txid_2'", "vout": '$utxo_vout_2' } ]''' outputs='''{ "'$recipient'": 0.2 }''')

psbt=$(bitcoin-cli -regtest -named converttopsbt hexstring=$rawtxhex)
echo $psbt

# utxo_txid_1=c6de60427b28d8ec8102e49771e5d0348fc3ef6a5bf02eb864ec745105a6951b 
# utxo_vout_1=1 
# utxo_txid_2=8748eff5f12ca886e3603d9e30227dcb3f0332e0706c4322fec96001f7c7f41c 
# utxo_vout_2=0
# recipient=2MvLcssW49n9atmksjwg2ZCMsEMsoj3pzUP
# rawtxhex=$(bitcoin-cli -named createrawtransaction inputs='''[ { "txid": "'$utxo_txid_1'", "vout": '$utxo_vout_1' }, { "txid": "'$utxo_txid_2'", "vout": '$utxo_vout_2' } ]''' outputs='''{ "'$recipient'": 0.0000065 }''')
# echo $rawtxhex
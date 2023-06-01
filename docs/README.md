# Introduction

* [Dhali](https://dhali.io) is a Web 3.0 open marketplace for creators and users of AI. 
* To use Dhali, stream blockchain enabled micropayments for what you need, when you need it. 
No subscriptions are required.
* Creators receive an NFT representing their AI. When their AI is used, Dhali streams micropayments to the NFT holder.
* Dhali currently uses the [XRP Ledger](https://xrpl.org/) testnet to manage payments.


 <p align="center" style="width:560px;">
          <iframe width="560" height="315" src="https://www.youtube-nocookie.com/embed/QaC_-lBG9hc" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>
</p>

## Prepare micropayments

Whether using or producing AI for Dhali, all requests are accompanied 
with an [XRPL](https://xrpl.org/)-based [payment claim](https://xrpl.org/use-payment-channels.html).
The payment claim is:
* A json object that lives in the header of your request and is used to fund it.
* An efficient mechanism for streaming micropayments.

### Automatic

If using or deploying assets through the marketplace, payment claims will be automatically generated and submitted with Dhali requests.

### Manual

If you are using Dhali programmatically, you will need to manually generate payment claims. To create a new payment claim:
1. Install dhali-py:\
`pip install dhali-py`
2. Generate a test wallet:\
`dhali create-xrpl-wallet`
3. Generate a payment claim to Dhali's public wallet (run `dhali create-xrpl-payment-claim --help` for information on the flags):\
`dhali create-xrpl-payment-claim -s <secret from 2.> -d rstbSTpPcyxMsiXwkBxS9tFTrg2JsDNxWk -a 10000000 -i <sequence number from 2.> -t 100000000`


## AI users

After selecting an AI tool (aka, AI asset) from the [Dhali marketplace](https://dhali-app.web.app/#/), users will see an available endpoint and a description of how to structure the asset's input. Requests to Dhali assets always take a form similar to this:
```
curl -v -X PUT -H 'Payment-Claim: <insert_prepared_payment_claim>' -F 'input=@<path_to_input_file>' https://<URL>/<ASSET_ID>/run
```

## AI creators

To create an asset:
1. Clone the dhali asset template:\
`git clone git@github.com:Dhali-org/Dhali-asset-template.git`
2. Add your AI to the `run` entrypoint in `main.py`.
3. Update the `README.md`.
4. Test your asset locally
```
docker build -t my_asset .
docker run  -p 8080:8080 my_asset
curl -X PUT -F "input=@<path_to_input>" http://127.0.0.1:8080/run/
```
5. Build your asset:
```
docker save --output /tmp/my_asset.tar my_asset
```
6. To deploy your asset:
    * Enter the Dhali marketplace.
    * Select "Add new asset" from the "My assets" page.
    * Follow the dialog to upload `/tmp/my_asset.tar` from 5. and your `README.md`.
    * Your asset should now be visible in the marketplace.

7. Once deployed, you will receive an NFT. View it by navigating to your wallet address [here](https://testnet.xrpl.org/).
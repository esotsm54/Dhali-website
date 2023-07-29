# Dhali documentation

## Introduction

Dhali is a Web 3.0 open marketplace for API creators and users. With Dhali, you can stream blockchain-enabled micropayments for API services without needing any subscription. Dhali allows creators to upload their API, which then gets represented as an [NFT](https://xrpl.org/non-fungible-tokens.html) on the [XRPL](https://xrpl.org/). Whenever their API is used, micropayments are streamed to the NFT holder. The platform currently utilizes the XRP Ledger testnet for handling payments.

 <p align="center" style="width:560px;">
          <iframe width="560" height="315" src="https://www.youtube-nocookie.com/embed/QaC_-lBG9hc" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>
</p>

## Getting started

* To explore currently available assets, check out the marketplace:
<div class="button-container">
    <a href="https://dhali-app.web.app/#/" target="_blank" rel="noopener noreferrer">
        <button class="material-button" type="button">Marketplace</button>
    </a>
</div>

* To turn your software project into a revenue generating asset, check out the tutorial:
<div class="button-container">
    <a href="#/?id=step-by-step-guide">
        <button class="material-button" type="button">Creating Dhali Assets</button>
    </a>
</div>

* To access on-demand assets, check out the tutorial:
<div class="button-container">
    <a href="#/?id=using-dhali-assets">
        <button class="material-button" type="button">Using Dhali Assets</button>
    </a>
</div>

## How Dhali works

Whether you want to create Dhali assets or use Dhali assets, you must:
1. **Have a digital wallet**: \
Currently, we support [XRPL](https://xrpl.org/) wallets. Wallets can be created through our marketplace.
2. **Open a payment channel to Dhali**: \
A [payment channel](https://xrpl.org/payment-channels.html) is a type of blockchain technology that allows for secure, fast, and low-cost transactions without needing to commit all those transactions individually to the blockchain.
    > A payment channel is like a locked box of money shared between two friends. Each time one friend wants to pay the other, instead of handing money directly, they exchange a key that permits a certain amount of money to be taken from the box in the future. The locked box only needs to be opened at the end when they're done transacting.
<p align="center" style="width:560px;"><iframe width="560" height="315" src="https://www.youtube-nocookie.com/embed/e2Iwsk37LMk?start=141" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe></p>
A payment claim is a cryptographic key that is sent to Dhali's API. In the payment channel analogy above, it is a key to the box. It may represent fractions of a cent in value. Dhali checks the key's validity in real-time to ensure it can fund the latest request. Dhali uses the claim at a later date to take money from the payment channel. The amout of money that can be taken is determined by the payment claim creator.
<br><br>
Payment claims are cummulative, meaning that if a user makes an API call costing X, followed by another API call costing Y, the first payment claim must have a value of at least X while the second payment claim must have a value of at least X+Y. Also, the second payment makes the first payment claim obsolete.
Dhali exposes an API for using and producing Dhali assets.
All API requests should include the payment-claim header:

    ```bash
    Payment-Claim: $PAYMENT_CLAIM_JSON
    ```
To understand more about payment claims, see our section on creating them:
<div class="button-container">
    <a href="#/?id=preparing-payments">
        <button class="material-button" type="button">Create a payment claim</button>
    </a>
</div>
4. **Manage your Dhali balance**: \
As you use Dhali's API, your usage costs are incremented. Your Dhali balance is the amount of money in the payment channel minus your current usage costs. If your Dhali balance reaches zero, you will need to add more money to your payment channel.

## Examples

To use an asset from the marketplace, you just need a payment claim. Here's one you can use for free! In your terminal:
```bash
PAYMENT_CLAIM='{"account": "rBqZz7QjHLizCHGrfAAh5cZtvG7NS3DvBV", "destination_account": "rstbSTpPcyxMsiXwkBxS9tFTrg2JsDNxWk", "authorized_to_claim": "10000000", "signature": "47D6A8BFCB754BC859EF897F3DE0123F35B58F941E664B74E923766FE0E1AD2E3F655F1AB16954096442E74878EFF1C875D34EFB132D513D611F9615DDCBD70B", "channel_id": "742A4A95984FB1325FC882DFB88254102A333A6156FFFAB514174A5F8FB06B25"}'

```
> :warning: The following examples may respond slowly the first time they are run.
* To access [speech-to-text](https://dhali-app.web.app/#/assets/d82952124-c156-4b16-963c-9bc8b2509b2c):
```bash
ENDPOINT='https://dhali-prod-run-dauenf0n.uc.gateway.dev/d82952124-c156-4b16-963c-9bc8b2509b2c/run'
WAV_FILE='/tmp/tmp.wav'
wget https://www.signalogic.com/melp/EngSamples/eng_m9.wav -O $WAV_FILE
curl -X PUT \
     -H "Payment-Claim: $PAYMENT_CLAIM" \
     -F "input=@$WAV_FILE" \
     $ENDPOINT
```

* To access [yolos-tiny](https://dhali-app.web.app/#/assets/de76539ac-40b3-406d-9fe6-0b7e70577a50):
```bash
ENDPOINT='https://dhali-prod-run-dauenf0n.uc.gateway.dev/de76539ac-40b3-406d-9fe6-0b7e70577a50/run'
IMAGE_FILE='/tmp/tmp.wav'
wget https://a-z-animals.com/media/2022/11/shutterstock_1557735749-1024x614.jpg -O $IMAGE_FILE
curl -X PUT \
     -H "Payment-Claim: $PAYMENT_CLAIM" \
     -F "input=@$IMAGE_FILE" \
     $ENDPOINT
```

## Creating Dhali assets

Creating a Dhali asset is simple. The [Dhali-examples](https://github.com/Dhali-org/Dhali-examples) repository provides a collection of functioning asset examples that can be used as a guide for asset creation.
In what follows, we provide a step by step guide for how these were created.

 <p align="center" style="width:560px;">
          <iframe width="560" height="315" src="https://www.youtube-nocookie.com/embed/Kckl5z14pm0" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>
</p>

#### Step by step guide

To deploy an API onto Dhali:
1. Clone the dhali asset template:
`git clone git@github.com:Dhali-org/Dhali-asset-template.git`
2. Modify the template as needed:
* Implement your AI in the `run` function within `main.py`.
* Update the `README.md` to provide information about your API.
* Include all Python dependencies in your `requirements.txt`.
* Make sure all necessary files (e.g., models) are copied in the `Dockerfile`.

3. Test your API locally:
```bash
docker build -t my_api .
docker run  -p 8080:8080 my_api
curl -X PUT -F 'input=@<path_to_input>' http://127.0.0.1:8080/run/
```
4. Build your API:
```
docker save --output ./my_asset.tar my_api
```
5. To deploy your asset:
    * Enter the Dhali marketplace.
    * Select "Add new asset" from the "My assets" page.
    * Follow the dialog to upload `./my_asset.tar` from 5. and your `README.md`.
    * Your api should now be visible in the marketplace.

6. Once deployed, you will receive an NFT. View it by navigating to your wallet address [here](https://testnet.xrpl.org/).


## Using Dhali assets

Once you've selected an AI asset from the Dhali marketplace, you'll find an available endpoint and a description of the input structure required by the asset. Below, we show different ways to use the asset: 


<!-- tabs:start -->

<!-- tab:REST -->
#### PUT /{uuid}/run - **Run an asset**

<!-- tabs:start -->

<!-- tab:Request -->



```bash
https://dhali-prod-run-dauenf0n.uc.gateway.dev/{uuid}/run
```

**Path parameters**

| Name      | Type      | Description           |
|-----------|-----------|-----------------------|
| uuid      | String    | The UUID of the asset |

**Headers**

| Name          | Type      | Description           |
|---------------|-----------|-----------------------|
| Payment-Claim | String    | A receipt against your payment channel |

**Request body**

| Name      | Type            | Content type | Description                         |
|-----------|-----------------|---------------|----------------------|
| input     | string($binary) | multipart/form-data | Provide an input to the Dhali asset |



<!-- tab:Response -->

**200**: OK

The execution was successful. You will receive a response with the following headers:

| Name          | Type      | Description           |
|---------------|-----------|-----------------------|
| dhali-latest-request-charge | String    | The cost of this request. |
| dhali-total-requests-charge | String    | The cummulative cost of all request on this payment channel. |

The body of the response will be:
```
{
    <A json object, structured according to the asset creator>
}
```

**402**: Bad payment claim.
```
{
    detail: "<An explanation of why your payment claim was not valid>"
}
```

<!-- tabs:end -->


<!-- tab:Marketplace -->

* Visit [Dhali Marketplace](https://dhali-app.web.app/).
* Click "Wallet" in the pop-out menu to activate your wallet.
* Select "Marketplace" in the pop-out menu and choose an asset.
* Prepare an input file using the asset's README description.
* On the asset page, click "Run" and upload your input file.

<!-- tab:Bash -->

* Create a payment claim using [the instructions on preparing micropayments](prepare_payments/README.md).
* Visit [Dhali Marketplace](https://dhali-app.web.app/).
* Select "Marketplace" in the pop-out menu, choose an asset and copy its endpoint url: 
```bash
ENDPOINT=https://<URL>/<ASSET_ID>/run
```
* Prepare an input file using the asset's README description.
* Then you can pass files to curl:
```bash
curl -v -X PUT -H "Payment-Claim: <insert_prepared_payment_claim>" -F "input=@<path_to_input_file>" $ENDPOINT
```
or pass raw data (e.g., strings, jsons, etc)
```bash
curl -v -X PUT -H "Payment-Claim: <insert_prepared_payment_claim>" -F "input=<raw_data>" $ENDPOINT
```
> :warning: Note the use of "@" in the first `curl` request above. This ensures the content of the file is sent with the request, not the string corresponding to the file's name.


<!-- tab:Python -->
First:
```bash
pip install dhali-py
```
Then:
```python
from io import BytesIO                                                 
from dhali.module import Module                                                    
from dhali.payment_claim_generator import (                                        
    get_xrpl_wallet,                                                               
    get_xrpl_payment_claim,                                                        
)                                                                                  
                                                                              
asset_uuid = "<insert asset uuid here>"                                        
some_wallet = get_xrpl_wallet()                                                
                                                                               
DHALI_PUBLIC_ADDRESS="rstbSTpPcyxMsiXwkBxS9tFTrg2JsDNxWk"                      
some_payment_claim = get_xrpl_payment_claim(some_wallet.seed, DHALI_PUBLIC_ADDRESS, "10000", some_wallet.sequence, "100000")
                                                                                
test_module = Module(asset_uuid) 

# Note: we assume here that the asset takes a text file as input:
response = test_module.run(                                                    
    BytesIO("<insert some valid input text>".encode("utf-8")), some_payment_claim)

# We could also do this if there is a file instead:
with open("<insert input file path here>", "rb") as f:
    response = test_module.run(f, some_payment_claim)
```

<!-- tabs:end -->


## Preparing payments

In Dhali, all API requests are accompanied by an XRPL-based payment claim. This claim is a JSON object embedded in the request header to fund the service, acts as a means to stream micropayments, and takes the following form:
```bash
{
    "account": "<Your account classic address>", 
    "destination_account": "<Dhali's classic address>", 
    "authorized_to_claim": "<The max drops (millionths of an XRP) that this payment claim allows to be extracted from the channel>", 
    "signature": "<A cryptographic signature that only 'account' can create>", 
    "channel_id": "<The ID of the channel>"
}
```
To create valid payment claims:
<!-- tabs:start -->

<!-- tab:Marketplace -->

Payment claims are auto-generated and submitted with requests.

<!-- tab:Python -->
1. Install dhali-py:
```bash
pip install dhali-py
```

2. Generate a test wallet:
```bash
dhali create-xrpl-wallet
```

3. Generate a payment claim. Replace the <secret from step 2> with your wallet's secret and <sequence number from step 2> with your wallet's sequence number:
```bash
dhali create-xrpl-payment-claim -s <secret from 2.> -d rstbSTpPcyxMsiXwkBxS9tFTrg2JsDNxWk -a 10000000 -i <sequence number from 2.> -t 100000000
```


<!-- tabs:end -->

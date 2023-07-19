# Introduction

Dhali is a Web 3.0 open marketplace for API creators and users. With Dhali, you can stream blockchain-enabled micropayments for API services without needing any subscription. Dhali allows creators to upload their API, which then gets represented as an NFT. Whenever their API is used, micropayments are streamed to the NFT holder. The platform currently utilizes the XRP Ledger testnet for handling payments.

 <p align="center" style="width:560px;">
          <iframe width="560" height="315" src="https://www.youtube-nocookie.com/embed/QaC_-lBG9hc" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>
</p>

## Getting started

### Creating Dhali assets

The [Dhali-examples](https://github.com/Dhali-org/Dhali-examples) repository provides a collection of functioning asset examples that can be used as a guide for asset creation.
In what follows, we provide a step by step guide for how these were created.

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


### Using Dhali assets

Once you've selected an AI asset from the Dhali marketplace, you'll find an available endpoint and a description of the input structure required by the asset. To request the asset:

<!-- tabs:start -->

<!-- tab:Marketplace -->

* Visit [Dhali Marketplace](https://dhali-app.web.app/).
* Click "Wallet" in the pop-out menu to activate your wallet.
* Select "Marketplace" in the pop-out menu and choose an asset.
* Prepare an input file using the asset's README description.
* On the asset page, click "Run" and upload your input file.

<!-- tab:Bash -->

* Create a payment claim using [the instructions on preparing micropayments](#preparing-micropayments).
* Visit [Dhali Marketplace](https://dhali-app.web.app/).
* Select "Marketplace" in the pop-out menu, choose an asset and copy its endpoint url: 
```bash
ENDPOINT=https://<URL>/<ASSET_ID>/run
```
* Prepare an input file using the asset's README description.
* Then:
```bash
curl -v -X PUT -H 'Payment-Claim: <insert_prepared_payment_claim>' -F 'input=@<path_to_input_file>' $ENDPOINT
```

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

### Preparing micropayments

In Dhali, all API requests are accompanied by an XRPL-based payment claim. This claim is a JSON object embedded in the request header to fund the service and acts as a means to stream micropayments.

* If you use or deploy assets through the marketplace, payment claims are auto-generated and submitted with the requests.
* However, if you are interacting with Dhali programmatically, you need to generate these payment claims manually. Here's how:

#### Manual payment claim generation

If you are using Dhali programmatically, you will need to manually generate payment claims. To create a new payment claim:
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

# Introduction

Dhali is a Web 3.0 open marketplace for API creators and users. With Dhali, you can stream blockchain-enabled micropayments for API services without needing any subscription. Dhali allows creators to upload their API, which then gets represented as an NFT. Whenever their API is used, micropayments are streamed to the NFT holder. The platform currently utilizes the XRP Ledger testnet for handling payments.

 <p align="center" style="width:560px;">
          <iframe width="560" height="315" src="https://www.youtube-nocookie.com/embed/QaC_-lBG9hc" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>
</p>

## Getting started

### Creating Dhali assets

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
docker save --output /tmp/my_api.tar my_api
```
5. To deploy your asset:
    * Enter the Dhali marketplace.
    * Select "Add new asset" from the "My assets" page.
    * Follow the dialog to upload `/tmp/my_api.tar` from 5. and your `README.md`.
    * Your api should now be visible in the marketplace.

6. Once deployed, you will receive an NFT. View it by navigating to your wallet address [here](https://testnet.xrpl.org/).


## Using Dhali assets

Once you've selected an AI asset from the Dhali marketplace, you'll find an available endpoint and a description of the input structure required by the asset. To request the asset, use a command similar to the following:

```bash
curl -v -X PUT -H 'Payment-Claim: <insert_prepared_payment_claim>' -F 'input=@<path_to_input_file>' https://<URL>/<ASSET_ID>/run
```

Please see [the section on preparing micropayments](#preparing-micropayments) for instructions on how to create a payment claim.

Or use our Python library `dhali-py` as shown:

```python
from io import BytesIO                                                             
from xrpl import wallet                                                            
from dhali.module import Module                                                    
from dhali.payment_claim_generator import (                                        
    get_xrpl_wallet,                                                               
    get_xrpl_payment_claim,                                                        
)                                                                                  
                                                                                   
if __name__ == "__main__":                                                         
                                                                                   
    asset_uuid = "<insert asset uuid here>"                                        
    some_wallet = get_xrpl_wallet()                                                
                                                                                   
                                                                                   
    DHALI_PUBLIC_ADDRESS="rstbSTpPcyxMsiXwkBxS9tFTrg2JsDNxWk"                      
    some_payment_claim = get_xrpl_payment_claim(some_wallet.seed, DHALI_PUBLIC_ADDRESS, "10000", some_wallet.sequence, "100000")
                                                                                   
    test_module = Module(asset_uuid, some_wallet)                                  
    # Note: we assume here that the asset takes a text file as input:
    response = test_module.run(                                                    
        BytesIO("<insert some valid input text>".encode("utf-8")), some_payment_claim
    
    # ..

    # We could also do this if there is a file instead:
    with open("<insert input file path here>", "rb") as f:
        response = test_module.run(f, some_payment_claim)
    )  
```

## Preparing micropayments

In Dhali, all API requests are accompanied by an XRPL-based payment claim. This claim is a JSON object embedded in the request header to fund the service and acts as a means to stream micropayments.

* If you use or deploy assets through the marketplace, payment claims are auto-generated and submitted with the requests.
* However, if you are interacting with Dhali programmatically, you need to generate these payment claims manually. Here's how:

### Manual payment claim generation

If you are using Dhali programmatically, you will need to manually generate payment claims. To create a new payment claim:
1. Install dhali-py:
```bash
pip install dhali-py`
```

2. Generate a test wallet:
```bash
dhali create-xrpl-wallet
```

3. Generate a payment claim. Replace the <secret from step 2> with your wallet's secret and <sequence number from step 2> with your wallet's sequence number:
```bash
dhali create-xrpl-payment-claim -s <secret from 2.> -d rstbSTpPcyxMsiXwkBxS9tFTrg2JsDNxWk -a 10000000 -i <sequence number from 2.> -t 100000000
```
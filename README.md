# allora-worker

request some faucet from the [Allora Testnet Faucet](https://faucet.testnet-1.testnet.allora.network/) 

## Stop the old version
If you've previously run the old version and want to stop it before proceeding, follow these commands
```
docker stop custom-inference
docker stop custom-worker
docker container prune -f
```

## Run the custom model
1. Create an account and obtain an Upshot ApiKey [here](https://developer.upshot.xyz)

2. Clone the git repository
```
git clone https://github.com/gr3yscope/allora-meme.git
cd allora-meme
```

3. Run the bash script
```
bash run.sh
```
* **Index:** Set your worker index.(the index gives you the ability to run multiple workers on one server)
* **Mnemonic Phrase:** Import you menmonic phrase
* **Upshot ApiKey:** Import your upshot apikey


make sure both `custom-worker-0` & `custom-inference` containers are running with `docker ps`
<img width="1325" alt="Screenshot 2024-09-09 at 3 33 15 PM" src="https://github.com/user-attachments/assets/e54c50ff-8fb6-4983-8586-5ddef8768a49">


check the worker container with `docker logs -f custom-worker-0` command

<img width="816" alt="Screenshot 2024-08-17 at 3 30 29 PM" src="https://github.com/user-attachments/assets/a24a19b0-36a5-407d-8fb5-46c72c63c819">

make sure `custom-inference` returns correct response
```
curl http://localhost:8008/inference/ETH
curl http://localhost:8008/inference/MEME
```

## [DEPRECATED] Run with hugging model and pass your mnemonic phrase to it
```
curl -LOs https://raw.githubusercontent.com/gr3yscope/allora-meme/main/hugging-allora.sh && bash ./hugging-allora.sh
```

make sure both `hugging-worker` & `hugging-inference` containers are running with `docker ps`

<img width="1406" alt="Screenshot 2024-08-17 at 3 15 37 PM" src="https://github.com/user-attachments/assets/a26281af-ecc2-497d-8379-981eac14d4d6">

check the worker container with `docker logs -f hugging-worker` command

make sure `hugging-inference` is responsive
```
curl http://localhost:8008/inference/ETH
```


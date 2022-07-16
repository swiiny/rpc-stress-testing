# Node stress testing :chart_with_upwards_trend:
## Introduction
This project will help you stress testing your node by creating **n** users subscribed to receive new blocks then fetch block with transactions using [ethers](https://docs.ethers.io/v5/) library

```
function startWebsocket() {
	let wsProvider = new ethers.providers.WebSocketProvider(PROVIDER_URL);

	wsProvider.on('block', async (blockNumber) => {
		fetchEVMBlockFor(wsProvider, blockNumber);
	});
}
```
## Working configuration :white_check_mark:
- Docker engine v20.10.17
- Docker compose v2.6.1

## Setup :hammer:

### 1. Clone the repo
```
git clone https://github.com/JeremyTheintz/rpc-stress-testing
cd ./rpc-stress-testing
```

### 2. Start n instances on your RPC
`sh start.sh n your_rpc_url`

#### Example of running 100 instances simultaneously 
`sh start.sh 100 wss://your_rpc_url`

### 4. Stop all instances
`sh stop.sh`

## Warning :rotating_light:
Running too much instance will consume a lot of RAM and CPU, use at your own risk
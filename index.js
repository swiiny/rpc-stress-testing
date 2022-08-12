const { ethers } = require('ethers');

async function fetchEVMBlockFor(provider, blockNumber) {
	try {
		const block = await provider.getBlockWithTransactions(blockNumber);
		const transactions = block?.transactions || [];

		console.log('block n°', blockNumber, 'data => txCount:', transactions.length);

		console.log('< ' + blockNumber + ' > start check if addresses are contracts for block n°', blockNumber);
		transactions.map(async (tx) => provider.getCode(tx.from));

		console.log('< ' + blockNumber + ' > end check if addresses are contracts');
	} catch (err) {
		console.error('fetch blocks n°' + blockNumber, err);
	}
}

async function startWebsocket() {
	let wsProvider = new ethers.providers.WebSocketProvider(process.env.PROVIDER_URL);

	console.log('websocket connected');

	wsProvider.on('block', async (blockNumber) => {
		fetchEVMBlockFor(wsProvider, blockNumber);
	});
}

function init() {
	startWebsocket();
}

init();

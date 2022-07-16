const { ethers } = require('ethers');

async function fetchEVMBlockFor(provider, blockNumber) {
	try {
		const block = await provider.getBlockWithTransactions(blockNumber);
		const transactions = block?.transactions || [];

		console.log('block n°', blockNumber, 'data => txCount:', transactions.length);
	} catch (err) {
		console.error('fetch blocks n°' + blockNumber, err);
	}
}

function startWebsocket() {
	let wsProvider = new ethers.providers.WebSocketProvider(process.env.PROVIDER_URL);

	wsProvider.on('block', async (blockNumber) => {
		fetchEVMBlockFor(wsProvider, blockNumber);
	});
}

function init() {
	startWebsocket();
}

init();

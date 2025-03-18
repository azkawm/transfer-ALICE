import { http, createPublicClient, parseAbiItem } from "viem";
import { base } from "viem/chains";

const client = createPublicClient({
  chain: base,
  transport: http(
    "https://base-sepolia.infura.io/v3/499f4f21a89e426a8c9da41ecd7fea97"
  ),
});

const event = parseAbiItem(
  "event Transfer(address sender, address wallet, uint256 amount)"
);

const error = parseAbiItem("error AmountShouldNotBeZero()");

const address = "0xd8Bf86775A08145429519513b0cA53b963e4600A";

// Get initial event logs (last 20 blocks)
const blockNumber = await client.getBlockNumber();
const logs = await client.getLogs({
  event,
  error,
  fromBlock: blockNumber - 20n,
  toBlock: blockNumber,
});

// Watch for new event logs
client.watchEvent({
  address,
  event,
  onLogs: (logs) => {
    try {
      console.log(logs[0]);
    } catch (error) {
      console.error(
        "Transaction reverted:",
        error.shortMessage || error.message
      );
    }
  },
});

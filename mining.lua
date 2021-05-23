
Blocks = {}

function Validate()
	chain_len = string.len(Blocks)

	if (chain_len == 0 or chain_len == 1) then
		return true
	end

	for i in pairs(Blocks) do
		if not Blocks[i].previous_hash == Blocks[i - 1].hash then
			return false
		end
	end

	return true
end


function SolveProblems()
	last_block_header = '0e0fb2e3ae9bd2a0fa8b6999bfe6ab7df197a494d4a02885783a697ac74940d9' -- C/B Chain Header
    last_block_target = '000ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd' -- C/B Chain Target

    -- TODO: Create a self-function to solve problems, send data to the network and register to the chain, then add X amount of crypto to the miner's wallet
end

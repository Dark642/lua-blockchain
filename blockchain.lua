Blockchain = Blockchain or {}

ALLOWED_ADDRESSES = {}
BLACKLISTED_ADDRESSES = {}

LAST_GENERATED_AUTHENTICATION_KEY = nil
LAST_GENERATED_BLOCKCHAIN_IDX = nil
LAST_GENERATED_TRANSACTION_KEY = nil
LAST_GENERATED_API_KEY = nil

CURRENT_TRANSACTIONS = {}
PENDING_TRANSACTIONS = {}
BLOCKED_TRANSACTIONS = {}

PEERS = {}
BANNED_PEERS = {}
PRIORITY_PEERS = {}

CHAIN = nil


-- @route('/register_node', methods=['SET'])
function RegisterNode(ip)
	local function Validation()
		if (ip == nil or '0.0.0.0') then return false else return true end
		if (BLACKLISTED_ADDRESSES[ip] ~= nil) then return false else return true end
		if (ALLOWED_ADDRESSES[ip] ~= nil) then return false else return true end
	end

	if Validation() then
		ALLOWED_ADDRESSES[#ALLOWED_ADDRESSES + 1] = {ip, 'Successfully Validated.'}
	end
end

-- @route('/remove_node', methods=['SET|REMOVE'])
function RemoveNode(ip, blacklist)
	local function Validation()
		if (ip == nil) then return false else return true end
		if (ALLOWED_ADRESSES[ip] == nil) then return false else return true end
	end

	if Validation() then
		if blacklist then
			ALLOWED_ADDRESSES[ip] = nil
			BLACKLISTED_ADDRESSES[#BLACKLISTED_ADDRESSES + 1] = ip
		else
			ALLOWED_ADDRESSES[ip] = nil
		end
	end
end

-- @route('/new_block', methods=['CREATE'])
function CreateBlock(proof, previous_hash)

	local function GenerateUIXTimestamp()

		local timestamp = os.time()
		local d         = os.date('*t', timestamp).wday
		local h         = tonumber(os.date('%H', timestamp))
		local m         = tonumber(os.date('%M', timestamp))

		return {d = d, h = h, m = m}

	end

	local created_block = 
	{
		index = string.length(CHAIN) + 1,
		timestamp = GenerateUIXTimestamp(),
		transaction = CURRENT_TRANSACTIONS,
		proof = proof,
		previous_hash = previous_hash or (CHAIN[-1]),
		byte = Config.Bytes[4],
	}

	CURRENT_TRANSACTIONS = {}
	CHAIN = created_block

	return created_block
end

-- @route('/new_transaction', methods=['CREATE'])
function CreateTransaction(sender, recipient, amount)
	CURRENT_TRANSACTIONS = 
	{
		sender = sender,
		recipient = recipient,
		amount = amount,
	}

	return GetLastTransaction['index'] + 1
end

-- @route('/proof', methods=['CREATE|SET|GET'])
function GenerateWorkProof(last_block)
	last_proof = last_block['proof']
	last_hash = last_block
	proof = 0

	while not valid_proof(last_proof, proof, last_hash) do
		proof = proof + 1
	end

	return proof
end


-- @route('/get_last_transaction', methods=['GET'])
function GetLastTransaction()
	return CHAIN[-1]
end

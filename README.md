ERC20 Hash is an thought experiment of ERC20 token with PoW mint function that converts used computational resources into a token. 
ERC20 mint() function has no difficulty changes over the course of time and depends solely on compute power spent. 
Addition of address of msg.sender into calculation is deliberate design choice to prevent MEV bots from sniping users solution. 
Even if they know the answer for given "riddle" it's no use for them as function also includes address of the sender into the calculation.

var StarkNetGraffiti = artifacts.require("StarkNetGraffiti.sol");


module.exports = (deployer, network, accounts) => {
    deployer.then(async () => {
        await deployGraffer(deployer, network, accounts); 
    });
};

async function deployGraffer(deployer, network, accounts) {
	StarkNetGraffitiDeployed = await StarkNetGraffiti.new({from:accounts[0]})
	console.log("Graff contract " + StarkNetGraffitiDeployed.address)
	// console.log(StarkNetGraffitiDeployed)
}


	


var StarkNetGraffiti = artifacts.require("StarkNetGraffiti.sol");


module.exports = (deployer, network, accounts) => {
    deployer.then(async () => {
        // await deployTDToken(deployer, network, accounts); 
        // await deployEvaluator(deployer, network, accounts); 
        // await setPermissionsAndRandomValues(deployer, network, accounts); 
        // await deployRecap(deployer, network, accounts); 
        await deployGraffer(deployer, network, accounts); 
    });
};

async function deployGraffer(deployer, network, accounts) {
	StarkNetGraffitiDeployed = await StarkNetGraffiti.new()
	console.log("Graff contract " + StarkNetGraffitiDeployed.address)
}


	

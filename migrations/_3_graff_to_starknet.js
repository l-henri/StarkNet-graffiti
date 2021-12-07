
var StarkNetGraffiti = artifacts.require("StarkNetGraffiti.sol");

// var myGraff = "Petit L2 deviendra grand..."
var myGraff = "Looking good, StarkNet"
// var myGraff = "MAINNET BABY!!!!"

var ethereumGrafferAddress = "0xc010818276eb5dff6cc462217c66ee7648fb8d8b"

module.exports = (deployer, network, accounts) => {
    deployer.then(async () => {
            // StarkNetGraffitiDeployed = await StarkNetGraffiti.at(ethereumGrafferAddress)

        await sendGraff(deployer, network, accounts); 

    });
};

async function sendGraff(deployer, network, accounts) {
	
	// console.log("Graff contract " + StarkNetGraffitiDeployed.address)
	var paddedString = "0x" + web3.utils.fromAscii(myGraff).substring(2).padStart(64,'0')
    console.log(paddedString)
    
    // await StarkNetGraffitiDeployed.graffFromMainnetOnStarknet(paddedString);
}


	

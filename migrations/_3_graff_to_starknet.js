
var StarkNetGraffiti = artifacts.require("StarkNetGraffiti.sol");

var myGraff = "Hey you there"
var ethereumGrafferAddress = "0xBe8d8396833E07A9bA71e3Df01e17E7D37d5c56b"

module.exports = (deployer, network, accounts) => {
    deployer.then(async () => {
            StarkNetGraffitiDeployed = await StarkNetGraffiti.at(ethereumGrafferAddress)

        await sendGraff(deployer, network, accounts); 

    });
};

async function sendGraff(deployer, network, accounts) {
	
	console.log("Graff contract " + StarkNetGraffitiDeployed.address)
    await StarkNetGraffitiDeployed.graffFromMainnetOnStarknet(web3.utils.fromAscii(myGraff));
}


	

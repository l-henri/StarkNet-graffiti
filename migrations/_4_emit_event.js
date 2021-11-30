
var StarkNetGraffiti = artifacts.require("StarkNetGraffiti.sol");

var myGraff = "Hello testnet ;-)"
var ethereumGrafferAddress = "0xBe8d8396833E07A9bA71e3Df01e17E7D37d5c56b"

module.exports = (deployer, network, accounts) => {
    deployer.then(async () => {
            // StarkNetGraffitiDeployed = await StarkNetGraffiti.at(ethereumGrafferAddress)

        await writeGraff(deployer, network, accounts); 

    });
};

async function writeGraff(deployer, network, accounts) {
	
	// console.log("Graff contract " + StarkNetGraffitiDeployed.address)
    // await StarkNetGraffitiDeployed.graffFromStarknetOnMainnet("0x00000000000000000000000000000048656C6C6F20746573746E6574203B2D29");
    console.log(web3.utils.fromAscii(myGraff))
    console.log(web3.utils.padRight(myGraff))
}


	

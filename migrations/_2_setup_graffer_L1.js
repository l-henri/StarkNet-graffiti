
var StarkNetGraffiti = artifacts.require("StarkNetGraffiti.sol");

var ethereumGrafferAddress = "0x647dD2a964C10dF6588a4ac6F5Cf2C44B16E3e64"
var starknetGrafferAddressAsInt = "3319278968080370309910878968659006603895909569061385119632795853997864250857"
starknetCore_ = "0xde29d060d45901fb19ed6c6e959eb22d8626708e"

module.exports = (deployer, network, accounts) => {
    deployer.then(async () => {

        await setGraffer(deployer, network, accounts); 
    });
};

async function setGraffer(deployer, network, accounts) {
	StarkNetGraffitiDeployed = await StarkNetGraffiti.at(ethereumGrafferAddress)
	console.log("Graff contract " + StarkNetGraffitiDeployed.address)
    l2MessengerContractAddress_ = new web3.utils.BN(starknetGrafferAddressAsInt);
    GRAFF_SELECTOR_ = new web3.utils.BN("1556176496000738779866251419733342249912370993011992358749423751362128812898");
    await StarkNetGraffitiDeployed.setL2Graffer(starknetCore_, l2MessengerContractAddress_, GRAFF_SELECTOR_)
}


	

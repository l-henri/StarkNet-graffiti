
var StarkNetGraffiti = artifacts.require("StarkNetGraffiti.sol");

var ethereumGrafferAddress = "0xBe8d8396833E07A9bA71e3Df01e17E7D37d5c56b"
var starknetGrafferAddressAsInt = "3603122710348362136025089613373987800701254881949433260388166359342774503872"

module.exports = (deployer, network, accounts) => {
    deployer.then(async () => {
        if (network == "goerli") 
        {
            starknetCore_ = "0xde29d060d45901fb19ed6c6e959eb22d8626708e"
        }
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


	

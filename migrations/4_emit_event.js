
var StarkNetGraffiti = artifacts.require("StarkNetGraffiti.sol");


// var hexString 

module.exports = (deployer, network, accounts) => {
    deployer.then(async () => {

        await writeGraff(deployer, network, accounts); 

    });
};

async function writeGraff(deployer, network, accounts) {
	
    var decimals = [
new web3.utils.BN("1566918057116160165641476021756193"),
    ]
    for (i =0; i < decimals.length; i++)
    {
        var string = web3.utils.fromDecimal(decimals[i])
        console.log(web3.utils.toAscii(web3.utils.fromDecimal(decimals[i])))
        var paddedString = "0x" + string.substring(2).padStart(64,'0')
        console.log(paddedString)
    }
    
}


	

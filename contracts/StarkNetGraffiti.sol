pragma solidity ^0.6.12;
import './IStarknetCore.sol';

/**
  Demo contract for L1 <-> L2 interaction between an L2 StarkNet contract and this L1 solidity
  contract.
*/
contract StarkNetGraffiti {
    // The StarkNet core contract.
    IStarknetCore starknetCore;

    // The selector of the "graffOnStarkNetFromMainnet" l1_handler.
    uint256 GRAFF_SELECTOR; 
    // The address of the L2 graff contract
    uint256 l2MessengerContractAddress;

    // An owner who can modify the graff contract
    address public owner;


    event messageReceivedFromStarkNet(address sender, string stringMessage);
    event messageSentToStarkNet(address sender, string stringMessage);

    constructor(IStarknetCore starknetCore_) public 
    {   
      starknetCore = starknetCore_;
      owner = msg.sender;
    }

    function graffFromStarknetOnMainnet(address sender, bytes32 messageToGraff) 
    public 
    {
        // Construct the withdrawal message's payload.
        uint256[] memory payload = new uint256[](2);
        payload[0] = uint256(sender);
        payload[1] = uint256(messageToGraff);

        // Consume the message from the StarkNet core contract.
        // This will revert the (Ethereum) transaction if the message does not exist.
        starknetCore.consumeMessageFromL2(l2MessengerContractAddress, payload);
        emit messageReceivedFromStarkNet(sender, bytes32ToString(messageToGraff));
    }

    function graffOnStarkNetFromMainnet(bytes32 messageToGraff) 
    public 
    {
       
        // Construct the deposit message's payload.
        uint256[] memory payload = new uint256[](2);
        payload[0] = uint256(msg.sender);
        payload[1] = uint256(messageToGraff);

        // Send the message to the StarkNet core contract.
        starknetCore.sendMessageToL2(l2MessengerContractAddress, GRAFF_SELECTOR, payload);
        emit messageSentToStarkNet(msg.sender, bytes32ToString(messageToGraff));
    }

    function multiGraffs(address[] memory senders, bytes32[] memory messageToGraff)
    external
    {
        for (uint i = 0; i < senders.length; i++)
        {
            graffFromStarknetOnMainnet(senders[i], messageToGraff[i]);
        }
    }

    // Setup, permissions and utility

    function setL2Graffer(uint256 l2MessengerContractAddress_, uint256 GRAFF_SELECTOR_)
    public
    onlyOwner
    {
        l2MessengerContractAddress = l2MessengerContractAddress_;
        GRAFF_SELECTOR = GRAFF_SELECTOR_;
    }

    modifier onlyOwner() 
    {

        require(msg.sender == owner);
        _;
    }

    function bytes32ToString(bytes32 _bytes32) 
    public 
    pure 
    returns (string memory) 
    {
        uint8 i = 0;
        while(i < 32 && _bytes32[i] != 0) {
            i++;
        }
        bytes memory bytesArray = new bytes(i);
        for (i = 0; i < 32 && _bytes32[i] != 0; i++) {
            bytesArray[i] = _bytes32[i];
        }
        return string(bytesArray);
    }

}
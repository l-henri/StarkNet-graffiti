pragma solidity ^0.6.12;
pragma experimental ABIEncoderV2;
import './IStarknetCore.sol';
/**
  Demo contract for L1 <-> L2 interaction between an L2 StarkNet contract and this L1 solidity
  contract.
*/
contract StarkNetGraffiti {
    // The StarkNet core contract.
    IStarknetCore public starknetCore;

    // The selector of the "graffOnStarkNetFromMainnet" l1_handler.
    uint256 public GRAFF_SELECTOR; 
    // The address of the L2 graff contract
    uint256 public l2MessengerContractAddress;

    // An owner who can modify the graff contract
    address public owner;

    event messageReceivedFromStarkNet(string stringMessage);
    event messageSentToStarkNet(string stringMessage);
    event logSomething(uint256 length);
    constructor() public 
    {   
      owner = msg.sender;
    }

    function graffFromStarknetOnMainnet(string memory messageToGraff) 
    public 
    {


        // // Consume the message from the StarkNet core contract.
        // // This will revert the (Ethereum) transaction if the message does not exist.
        starknetCore.consumeMessageFromL2(l2MessengerContractAddress, buildMessagingPayloadFromString(messageToGraff));
        emit messageReceivedFromStarkNet(messageToGraff);
    }

    function graffFromMainnetOnStarknet(string memory messageToGraff) 
    public 
    {
        // Send the message to the StarkNet core contract.
        starknetCore.sendMessageToL2(l2MessengerContractAddress, GRAFF_SELECTOR, buildMessagingPayloadFromString(messageToGraff));
        emit messageSentToStarkNet(messageToGraff);
    }

    function multiGraffs(string[] memory messagesToGraff)
    external
    {
        for (uint i = 0; i < messagesToGraff.length; i++)
        {
            graffFromStarknetOnMainnet(messagesToGraff[i]);
        }
    }

    // Setup, permissions and utility

    function setL2Graffer(IStarknetCore starknetCore_, uint256 l2MessengerContractAddress_, uint256 GRAFF_SELECTOR_)
    public
    onlyOwner
    {
        starknetCore = starknetCore_;   
        l2MessengerContractAddress = l2MessengerContractAddress_;
        GRAFF_SELECTOR = GRAFF_SELECTOR_;
    }

    function buildMessagingPayloadFromString(string memory myString)
    public
    pure
    returns (uint256[] memory)
    {
        bytes memory messageAsBytes = bytes(myString);
        // Construct the deposit message's payload.
        uint256[] memory payload = new uint256[](messageAsBytes.length);
        payload[0] = uint256(messageAsBytes.length);
        for (uint8 i = 0; i < messageAsBytes.length; i++)
        {
            payload[i+1] = uint8(messageAsBytes[i]);
        }
        return payload;
    }

    modifier onlyOwner() 
    {

        require(msg.sender == owner);
        _;
    }

}
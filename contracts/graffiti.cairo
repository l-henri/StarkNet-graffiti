%lang starknet
%builtins pedersen range_check

from starkware.starknet.common.messages import send_message_to_l1
from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.alloc import alloc
from starkware.cairo.common.math import assert_nn

######### Storage variables

# Store an int value received from mainnet. Will take the value of the latest message sent by the sequencer
@storage_var
func msg_received_from_mainnet() -> (msg_received_from_mainnet : felt):
end

# The L1 contract with which we exchange messages
@storage_var
func to_address() -> (to_address : felt):
end

# A variable to limit the total number of messages sent to mainnet
@storage_var
func remaining_messages_credit() -> (remaining_messages_credit : felt):
end

######### Getters
# Functions to display the above variables

@view
func message_received{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}() -> (
        msg : felt):
    let (msg) = msg_received_from_mainnet.read()
    return (msg=msg)
end

@view
func remaining_messages_credit_view{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}() -> (
        current_remaining_messages_credit : felt):
    let (current_remaining_messages_credit) = remaining_messages_credit.read()
    return (current_remaining_messages_credit=current_remaining_messages_credit)
end

######### Constructor
# The L1 counterpart and the total number of credits for the contract are set at deployment to simplify access control

@constructor
func constructor{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
        l1_contract_address : felt, amount: felt):
    to_address.write(l1_contract_address)
    remaining_messages_credit.write(amount)
    return ()
end

######### External functions callable on StarkNet

# Send a message to Starknet
# msg is an int inferior to 2**251
@external
func paint_graffiti{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(msg : felt):
    # Check that the contract still has credit
    let (current_remaining_messages_credit) = remaining_messages_credit.read()

    tempvar next_remaining_messages_credit = current_remaining_messages_credit - 1
    assert_nn(next_remaining_messages_credit)
    remaining_messages_credit.write(next_remaining_messages_credit)

    # Sending message to L1
    let (payload) = alloc()
    [payload] = msg
    let (address) = to_address.read()

    # Sending the message to L1
    send_message_to_l1(address, 1, payload)
    return ()
end

######### External functions used when receiving a message from L1
# A L1 handler automatically receives the adress of the L1 sending contract.
@l1_handler
func get_painted{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
        from_address : felt, msg : felt):
    
    # Store the value received in msg in variable msg_received_from_mainnet
    msg_received_from_mainnet.write(msg)
    return ()
end

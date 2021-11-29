%lang starknet
%builtins pedersen range_check

from starkware.starknet.common.messages import send_message_to_l1
from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.alloc import alloc

@storage_var
func msg_received_from_mainnet() -> (msg : felt):
end

@storage_var
func to_address() -> (address : felt):
end

@external
func update_l1_address{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
        address : felt):
    to_address.write(address)
    return ()
end

@view
func message_received{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}() -> (
        msg : felt):
    let (msg) = msg_received_from_mainnet.read()
    return (msg=msg)
end

@constructor
func constructor{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
        l1_contract_address : felt):
    to_address.write(l1_contract_address)
    return ()
end

@external
func paint_graffiti{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(msg : felt):
    let (payload) = alloc()
    [payload] = msg
    let (address) = to_address.read()
    send_message_to_l1(address, 1, payload)
    return ()
end

@l1_handler
func get_painted{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
        from_address : felt, msg : felt):
    msg_received_from_mainnet.write(msg)
    return ()
end

use starknet::ContractAddress;

#[derive(Model, Drop, Serde)]
struct Player {
    #[key]
    player: ContractAddress,
    name: felt252,
    health: usize,
    wins: usize,
    loss: usize,
}

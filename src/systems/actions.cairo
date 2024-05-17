use dojo_custom_events::models::player;

// define the interface
#[dojo::interface]
trait IActions {
    fn spawn();
    fn test_battle_logs();
}

// dojo decorator
#[dojo::contract]
mod actions {
    use super::{IActions};
    use starknet::{ContractAddress, get_caller_address};
    use dojo_custom_events::models::{player::{Player}};


    #[event]
    #[derive(Drop, starknet::Event)]
    enum Event {
        BattleLogs: BattleLogs,
    }


    #[derive(Drop, starknet::Event)]
    struct BattleLogs {
        #[key]
        player: ContractAddress,
        #[key]
        battleLogId: usize,
        battleLogCounter: usize,
        data_one: usize,
        data_two: usize,
        data_three: bool,
        data_four: felt252,
    }


    #[abi(embed_v0)]
    impl ActionsImpl of IActions<ContractState> {
        fn spawn(world: IWorldDispatcher) {
            // Get the address of the current caller, possibly the player's address.
            let player = get_caller_address();

            // Update the world state with the new data.
            set!(world, (Player { player, name: 'Player', health: 100, wins: 0, loss: 0 },));
        }

        fn test_battle_logs(world: IWorldDispatcher) {
            // Get the address of the current caller, possibly the player's address.
            let player = get_caller_address();

            let mut i = 0;
            loop {
                i += 1;

                if i >= 10 {
                    break;
                }

                if i % 2 == 0 {
                    emit!(
                        world,
                        (BattleLogs {
                            player,
                            battleLogId: 1,
                            battleLogCounter: i,
                            data_one: 10,
                            data_two: 12,
                            data_three: true,
                            data_four: 'data_five',
                        })
                    );
                } else {
                    emit!(
                        world,
                        (BattleLogs {
                            player,
                            battleLogId: 1,
                            battleLogCounter: i,
                            data_one: 1,
                            data_two: 2,
                            data_three: false,
                            data_four: 'data_five_5',
                        })
                    );
                }
            }
        }
    }
}


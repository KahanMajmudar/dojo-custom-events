## DOJO CUSTOM EVENTS


1. Build the project (1st terminal)
```bash
sozo build
```

2. Spin up katana (2nd terminal)
```bash
katana --disable-fee
```

3. Migrate your world (1st terminal)
```bash
sozo migrate apply
```

4. Update Scarb.toml with your world address (Line 27)

5. Supply auth (1st terminal)
```bash
./scripts/default_auth.sh
```

6. Spin up torii (3rd terminal)
```bash
torii --world $your_world_address$
```

7. Execute actions (1st terminal). Fetch the actions contract address from the first terminal

```bash
sozo execute $your_actions_contract_address$ spawn
```

```bash
sozo execute $your_actions_contract_address$ test_battle_logs
```


8. Visit your local graphql playground [here](http://localhost:8080/graphql). To query the logs of the battle, enter the following query
(Replace $player_address with the address you want to fetch battle logs for)

```graphql
query BattleLogs{
  events(keys:[$player_address, "0x1"]) {
    edges {
      node {
        id
        keys
        data
        executedAt
        createdAt
        transactionHash
      }
    }
  }
}
```
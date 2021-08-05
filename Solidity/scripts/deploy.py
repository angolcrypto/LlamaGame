from brownie import llama, accounts

def main():
    acct = accounts.load('deployment_account')
    llama.deploy({'from': acct}, publish_source=True)

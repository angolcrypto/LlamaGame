from brownie import llama, accounts

def main():
    acct = accounts.load('deployment')
    llama.deploy({'from': acct})

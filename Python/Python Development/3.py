# Find Balance
# Implemented on 29-09-2023
# Developer: Arnab Deep Nath
# Comments: Difficulty level of 5/10 in DSA


class Solution():
    _bal = {}

    def _checkBal(self , transactions):
        for transactions in transactions:
            sender , buyer , amount_str = transactions.split(":")
            amount = int(amount_str)

            # Update balances for sender and receiver
            if sender in self._bal:
                self._bal[sender] -= amount
            else:
                self._bal[sender] = amount

            if buyer in self._bal:
                self._bal[buyer] -= amount
            else:
                self._bal[buyer] = amount

        # Print the balances
        for person, balance in self._bal.items():
            print(f'{person}: {balance}')

if __name__ == "__main__":
    solution_instance = Solution()
    transactions = [
        'Alice:Bob:10',
        'Bob:Charlie:5',
        'Charlie:Dave:15',
        'Eve:Alice:20'
    ]
    solution_instance._checkBal(transactions)

# Expected Solution

# {
#     'Alice': -10,
#     'Bob': 5,
#     'Charlie': -10,
#     'Dave': 15,
#     'Eve': 10
# }

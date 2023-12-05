class Solution():
    def _SieveOfEratosthenes(self , length):
        is_prime = [True] * (length +1)
        # Makes a list of True elements for the lenght of the given
        for i in range(2,length + 1):
            if is_prime[i]:
                print(i)
            for p in range(i*i , length+1 , i):
                is_prime[p] = False 


if __name__ == "__main__":
    solution_instance = Solution()
    a = int(input("Enter number of prime numbers you want to print ? "))
    solution_instance._SieveOfEratosthenes(a)
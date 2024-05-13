class Solution:
    
    def _findPrime(self ,length):
        newList = []
        for i in range(0, length):
            if(i<2):
                newList.append(1)
            elif(i>=2):
                newList.append(2*i+1)
            print(newList[i])


if __name__ == "__main__":
    solution_instance = Solution()
    a = int(input("Enter how many prime numbers you want to print ?"))
    solution_instance._findPrime(a)
    
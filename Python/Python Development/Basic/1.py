class Solution:
    def __init__(self):
        self.result = 998

    def add(self, x, y):
        _sum = x + y  
        return _sum + self.result

# Create an instance of the Solution class
solution_instance = Solution()

x = int(input("Enter first Number: "))
y = int(input("\nEnter Second Number: "))

result = solution_instance.add(x, y)
print(result)

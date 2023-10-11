class Solution():
    def bestBuy(self , arr):
        arr = sorted(arr)
        max_profit = 0
        buy = arr[0]
        for i in range(0 , len(arr)):
            if buy>arr[i]:
                buy = arr[i]
                print("Price bought at Rs. " + str(arr[i]))
            elif (arr[i]-buy>max_profit):
                max_profit = arr[i] - buy
        print("Max Profit: Rs."+str(max_profit))

    


if __name__ == "__main__":
    arr = [7,6,5,4,3,2,1]
    solution_instance = Solution()
    solution_instance.bestBuy(arr)
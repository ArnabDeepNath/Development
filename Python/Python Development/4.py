# Kande's Algorithm
# Implemented on 29-09-2023
# Developer: Arnab Deep Nath
# Comments: Difficulty level of 9/10 in DSA
class Solution():
    def max_subarray_sum(self ,nums):
        max_sum = current_sum = nums[0]

        for num in nums[1:]:
            current_sum = max(num, current_sum + num)
            max_sum = max(max_sum, current_sum)

        print(max_sum)

if __name__ == "__main__":
    nums = [-2, 1, -3, 4, -1, 2, 1, -5, 4]
    solution_instance = Solution()
    solution_instance.max_subarray_sum(nums)

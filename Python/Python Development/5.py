class Solution():
    _new_dic = {}
    def _sort(self, file):
        sorted_items = sorted(file.items() , key=lambda x:x[1])
        for first , second in sorted_items:
            self._new_dic[first] = second
        print(self._new_dic)

if __name__ == "__main__":
    _mydir = {"A":1 , "B":2 , "C":-1}
    solution_instance = Solution()
    solution_instance._sort(_mydir)
# Expected Output: {"C": -1 , "A":1 , "B":2}

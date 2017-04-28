//: Playground - noun: a place where people can play

import UIKit


func twoSum(_ nums: [Int], _ target: Int) -> [Int]
{
    for i in 0..<(nums.count - 1)
    {
        for j in (i + 1)..<nums.count
        {
            if nums[j] == target - nums[i]
            {
                return [i,j]
            }
        }
    }
    return []
}

twoSum([2,7,11,5], 9)
twoSum([5,6,7,8,9,12], 12)
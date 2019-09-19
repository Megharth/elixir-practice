defmodule Practice.Palindrome do
    
    def palindrome(x) do
        tempString = String.downcase(x)
        newString = String.reverse(tempString)
        if tempString == newString do
            "a palindrome String"
        else
            "not a palindrome String"
        end
    end

end
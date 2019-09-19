defmodule Practice.Factor do
    def get_factors(num, array, accumulator) do
        x = rem(num, accumulator)
        if accumulator < num do
            if x == 0 do
                get_factors(Integer.floor_div(num, accumulator), [accumulator | array], accumulator)
            else
                get_factors(num, array, accumulator+1)
            end
        else
            [accumulator | array]
        end
    end

    def factor(num) do
        {z, _} = Integer.parse(num)
        get_factors(z, [1], 2)
        |> Enum.sort()
        |> tl
        |> Enum.map_join(", ", fn x -> "#{x}" end) 
    end
end
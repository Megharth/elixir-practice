defmodule Practice.Calc do

def getArray(string) do 
        String.trim(string)
        |> String.split(" ")
        |> Enum.reverse()
    end
    
    def get_float(string) do
        {num, _} = Float.parse(string)
        num
    end

    def evaluate(array, n, l_op) do
        if length(array) >= 3 do
            n1 = Keyword.get(array, :num)
            op = Keyword.get(array, :op)

            case op do
                "/" ->  temp_array = array -- [{:num, n1}]
                        n2 = Keyword.get(temp_array, :num)
                        final_array = temp_array -- [{:num, n2}, {:op, op}]
                        if n1 == 0 do
                            "Divide by 0 is not allowed"     
                        else
                            [ {:num, n2 / n1} | final_array] |> evaluate(n, l_op)
                        end 
                "*" ->
                        temp_array = array -- [{:num, n1}]
                        n2 = Keyword.get(temp_array, :num)
                        final_array = temp_array -- [{:num, n2}, {:op, op}]
                        [ {:num, n2 * n1} | final_array ] |> evaluate(n, l_op)
                
                "+" ->
                        case l_op do
                            "+" -> 
                                x = Keyword.get(array, :num) + n 
                                array -- [{:num, n1}, {:op, op}] |> evaluate(x, op)
                            "-" -> 
                                x = Keyword.get(array, :num) - n 
                                array -- [{:num, n1}, {:op, op}] |> evaluate(x, op)
                            0 -> 
                                array -- [{:num, n1}, {:op, op}] |> evaluate(n1, op)
                        end
                "-" ->
                        case l_op do
                            "+" -> 
                                x = Keyword.get(array, :num) + n 
                                array -- [{:num, n1}, {:op, op}] |> evaluate(x, op)
                            "-" -> 
                                x = Keyword.get(array, :num) - n 
                                array -- [{:num, n1}, {:op, op}] |> evaluate(x, op)
                            0 -> 
                                array -- [{:num, n1}, {:op, op}] |> evaluate(n1, op)
                        end
                _ -> 
                        case l_op do
                            "+" -> 
                                x = Keyword.get(array, :num) + n 
                                array -- [{:num, n1}, {:op, op}] |> evaluate(x, op)
                            "-" -> 
                                x = Keyword.get(array, :num) - n 
                                array -- [{:num, n1}, {:op, op}] |> evaluate(x, op)
                            0 -> 
                                array -- [{:num, n1}, {:op, op}] |> evaluate(n1, op)
                        end
            end
        else
            if n != 0 do
                case l_op do
                    "+" -> Keyword.get(array, :num) + n 
                    "-" -> Keyword.get(array, :num) - n
                    0 -> Keyword.get(array, :num)
                end
            else
                Keyword.get(array, :num)
            end
        end 
    end
    

  def calc(expr) do
    getArray(expr)
    |> Enum.map(
        fn (x) -> 
            if x == "+" or x == "-" or x == "/" or x == "*" do
                {:op, x}
            else
                {:num, get_float(x)}
            end
        end
    )
    |> evaluate(0,0)
  end

end
def caesar_cipher(string, shift)
    alphabet = ("a".."z").to_a
    array = string.split("")
    0.upto(array.length - 1) do |num1|
        0.upto(alphabet.length - 1) do |num2|
          ((array[num1] = alphabet[num2 - shift]); break) if array[num1] == alphabet[num2]
        end
    end
    string = array.join("")
    return string
end

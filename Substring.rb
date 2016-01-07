dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]

def substrings(string, dictionary)
    array = string.downcase.split("")
    hash = {}
    dictionary.each do |word|
        track = 0
        times = 0

        array.each do
           break if (array.length - track) < word.length
           track2 = 0

           if array[track] == word[track2]
               match_word = ""
               copy_word = ""

               word.length.times do
                  match_word += array[track + track2]
                  copy_word += word[track2]
                  break if match_word != copy_word
                  track2 += 1
               end

               if match_word == word
                  times += 1
                  hash[word] = times
               end
           end
           track += 1
        end
    end
    return hash
end
substrings("Howdy partner, sit down! How's it going?", dictionary)

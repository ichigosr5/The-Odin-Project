def stock_picker(stocks)
   track1 = 0
   profit = 0
   show = 0
   stocks.each do |stock|
      buy = stock
      track2 = 0
      stocks.each do
        if track2 > track1
            sell = stocks[track2]
            net = sell - buy
            if net > profit
               profit = net
               show = [track1, track2]
            end
        end
        track2 += 1
      end
      track1 += 1
   end
   return show
end
stock_picker([17,3,6,9,15,8,6,1,10])

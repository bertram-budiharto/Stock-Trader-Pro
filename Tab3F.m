function Tab3F(app)
%% Tab3
% This code will work on the third tab of the app.

%% load dataset
stockdata = readmatrix('MyMarketData.xlsx');

%% set parameters
% pulls in the date and adjusts it with the days on the market data. set
% columns of different stock prices.
date = app.DatePicker_4.Value;
date_adjusted = datenum(date) - 693960;
[nRows, ~] = size(stockdata);
col_DowPrice = 9;
col_NASDAQPrice = 10;
col_SnPPrice = 11;
col_R3000Price = 12;
col_R2000Price = 13;
col_goldPrice = 14;
ticker = app.TickerDropDown.Value;

%% switch ticker
% switch statements for the ticker value. index through the market data and
% search for the price of a specific ticker at a specific date.
switch ticker
    case 'DOW'
        for iRow = 1:1:nRows
            if stockdata(iRow,1) == date_adjusted
                format long
                price = stockdata(iRow,col_DowPrice);
                app.PriceEditField.Value = price;
            end
        end
    case 'NASDAQ'
        for iRow = 1:1:nRows
            if stockdata(iRow,1) == date_adjusted
                format long
                price = stockdata(iRow,col_NASDAQPrice);
                app.PriceEditField.Value = price;
            end
        end
    case 'S&P 500'
        for iRow = 1:1:nRows
            if stockdata(iRow,1) == date_adjusted
                format long
                price = stockdata(iRow,col_SnPPrice);
                app.PriceEditField.Value = price;
            end
        end
    case 'Russell 3000'
       for iRow = 1:1:nRows
            if stockdata(iRow,1) == date_adjusted
                format long
                price = stockdata(iRow,col_R3000Price);
                app.PriceEditField.Value = price;
            end
        end
    case 'Russell 2000'
        for iRow = 1:1:nRows
            if stockdata(iRow,1) == date_adjusted
                format long
                price = stockdata(iRow,col_R2000Price);
                app.PriceEditField.Value = price;
            end
        end
    case 'Gold'
       for iRow = 1:1:nRows
            if stockdata(iRow,1) == date_adjusted
                format long
                price = stockdata(iRow,col_goldPrice);
                app.PriceEditField.Value = price;
            end
       end
end

end



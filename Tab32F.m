function Tab32F(app)
%% Tab3
% This code will work on the third tab of the app.

%% load dataset
stockdata = readmatrix('MyMarketData.xlsx');

%% set parameters
% pulls in the date and adjusts it with the days on the market data. set
% columns of different stock prices.
[nRows, ~] = size(stockdata);
days = linspace(1,nRows,nRows);
col_DowPrice = 9;
col_NASDAQPrice = 10;
col_SnPPrice = 11;
col_R3000Price = 12;
col_R2000Price = 13;
col_goldPrice = 14;
plotChoice = app.HistoryPriceIndexDropDown.Value;
doGrid = app.GridCheckBox.Value;

%% switch plot price index
% switch statements for the plotChoice value. plots the stock price of a specific
% ticker for the whole time.
if doGrid  
    grid (app.plotAxes, "on")
else
    grid (app.plotAxes, "off")
end

cla(app.plotAxes)
switch plotChoice
    case 'DOW'
        plot(app.plotAxes, days, stockdata(:,col_DowPrice))
        xlabel(app.plotAxes, {'Stock Trading Days';'';'Day 0 = September 10, 1987';'Day 8932 = February 17, 2023'}) 
        ylabel(app.plotAxes,'Price ($)')
        title(app.plotAxes,'DOW History Price Index')
        legend(app.plotAxes,'DOW')
        axis(app.plotAxes,[1,8932,1000,40000])
    case 'NASDAQ' 
        plot(app.plotAxes, days, stockdata(:,col_NASDAQPrice))
        xlabel(app.plotAxes, {'Stock Trading Days';'';'Day 0 = September 10, 1987';'Day 8932 = February 17, 2023'}) 
        ylabel(app.plotAxes,'Price ($)')
        title(app.plotAxes, 'NASDAQ History Price Index')
        legend(app.plotAxes,'NASDAQ')
        axis(app.plotAxes,[1,8932,50,17000])
    case 'S&P 500'
        plot(app.plotAxes, days, stockdata(:,col_SnPPrice))
        xlabel(app.plotAxes, {'Stock Trading Days';'';'Day 0 = September 10, 1987';'Day 8932 = February 17, 2023'}) 
        ylabel(app.plotAxes,'Price ($)')
        title(app.plotAxes, 'S&P 500 History Price Index')
        legend(app.plotAxes,'S&P 500')
        axis(app.plotAxes,[1,8932,100,5000])
    case 'Russell 3000'
        plot(app.plotAxes, days, stockdata(:,col_R3000Price))
        xlabel(app.plotAxes, {'Stock Trading Days';'';'Day 0 = September 10, 1987';'Day 8932 = February 17, 2023'}) 
        ylabel(app.plotAxes,'Price ($)')
        title(app.plotAxes, 'Russell 3000 History Price Index')
        legend(app.plotAxes,'Russell 3000')
        axis(app.plotAxes,[1,8932,50,3000])
    case 'Russell 2000'
        plot(app.plotAxes, days, stockdata(:,col_R2000Price))
        xlabel(app.plotAxes, {'Stock Trading Days';'';'Day 0 = September 10, 1987';'Day 8932 = February 17, 2023'}) 
        ylabel(app.plotAxes,'Price ($)')
        title(app.plotAxes, 'Russell 2000 History Price Index')
        legend(app.plotAxes,'Russell 2000')
        axis(app.plotAxes,[1,8932,50,3000])
    case 'Gold'
        plot(app.plotAxes, days, stockdata(:,col_goldPrice))
        xlabel(app.plotAxes, {'Stock Trading Days';'';'Day 0 = September 10, 1987';'Day 8932 = February 17, 2023'}) 
        ylabel(app.plotAxes,'Price ($)')
        title(app.plotAxes, 'Gold History Price Index')
        legend(app.plotAxes,'Gold')
        axis(app.plotAxes,[1,8932,100,2500]) 
    case 'All'
        plot(app.plotAxes,days,stockdata(:,col_DowPrice),'b-');
        hold(app.plotAxes, 'on')
        plot(app.plotAxes,days,stockdata(:,col_NASDAQPrice),'r-')
        hold(app.plotAxes, 'on')
        plot(app.plotAxes,days,stockdata(:,col_SnPPrice),'g-')
        hold(app.plotAxes, 'on')
        plot(app.plotAxes,days,stockdata(:,col_R3000Price),'k-')
        hold(app.plotAxes, 'on')
        plot(app.plotAxes,days, stockdata(:,col_R2000Price),'y-')
        hold(app.plotAxes, 'on')
        plot(app.plotAxes,days,stockdata(:,col_goldPrice),'k-')
        xlabel(app.plotAxes, {'Stock Trading Days';'';'Day 0 = September 10, 1987';'Day 8932 = February 17, 2023'}) 
        ylabel(app.plotAxes,'Price ($)')
        title(app.plotAxes,'All History Price Index')
        legend(app.plotAxes,'DOW', 'NASDAQ','S&P 500','Russell 3000','Russell 2000','Gold',location = 'best')
        axis(app.plotAxes,[1,8932,50,40000])
        
end


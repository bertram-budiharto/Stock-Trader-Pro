function Tab4F(app)
%% Tab4
% This code will work on the fourth tab of the app.

%% load dataset
stockdata = readmatrix('MyMarketData.xlsx');

%% set parameters
% pulls in the date and adjusts it with the days on the market data. set
% columns of different stock prices.
start_date = app.DatePicker_3.Value;
end_date = app.rDatePicker_3.Value;
start_date_adjusted = datenum(start_date) - 693960;
end_date_adjusted = datenum(end_date) - 693960;
[nRows, ~] = size(stockdata);
col_DowPrice = 2;
col_NASDAQPrice = 3;
col_SnPPrice = 4;
col_R3000Price = 5;
col_R2000Price = 6;
col_goldPrice = 7;
doGrid1 = app.GridCheckBox_2.Value;

%% row identification
% since the date has been adjusted for the market data, in order to
% identify the row of the start and end date, a for loop is used.
% pulls the row for the start and end date and save it to a variable.
nRow_start = 1;
for iRows = 1:1:nRows
    if stockdata(iRows,1) == start_date_adjusted
        nRow_start = iRows;
    end
end
nRow_end = 1;
for iRows = 1:1:nRows
    if stockdata(iRows,1) == end_date_adjusted
        nRow_end = iRows;
    end
end

%% days marching
% creates an x-axis of the range of days chosen.
numDays = (nRow_end - nRow_start) + 1;
nRow_start_loop = nRow_start;
xaxis = zeros(1,numDays);
for iRows = 1:1:numDays
    xaxis(1,iRows) = stockdata(nRow_start_loop,1); 
    nRow_start_loop = nRow_start_loop + 1;
end 

%% plot range of price
% plots all the stock prices from the range of days chosen.
cla(app.UIAxes3)
plot(app.UIAxes3,xaxis,stockdata(nRow_start:nRow_end,col_DowPrice),'b-');
hold(app.UIAxes3, 'on')
plot(app.UIAxes3,xaxis,stockdata(nRow_start:nRow_end,col_NASDAQPrice),'r-')
hold(app.UIAxes3, 'on')
plot(app.UIAxes3,xaxis,stockdata(nRow_start:nRow_end,col_SnPPrice),'g-')
hold(app.UIAxes3, 'on')
plot(app.UIAxes3,xaxis,stockdata(nRow_start:nRow_end,col_R3000Price),'k-')
hold(app.UIAxes3, 'on')
plot(app.UIAxes3,xaxis,stockdata(nRow_start:nRow_end,col_R2000Price),'y-')
hold(app.UIAxes3, 'on')
plot(app.UIAxes3,xaxis,stockdata(nRow_start:nRow_end,col_goldPrice),'k-')
xlabel(app.UIAxes3, {'Stock Trading Days'}) 
ylabel(app.UIAxes3,'Price Relative to Origin')
title(app.UIAxes3,'All History Price Index')
legend(app.UIAxes3,'DOW', 'NASDAQ','S&P 500','Russell 3000','Russell 2000','Gold',location = 'best')

if doGrid1  
    grid(app.UIAxes3, "on")
else
    grid(app.UIAxes3, "off")
end

%% percentage increase analysis
% analyse the percentage increase of the price of all the stocks from the
% range of days chosen. to make the calculations and coding simpler, we are
% just going to take the start date and end date as two unique values and
% calculate the aggregate percentage increase or decrease in price.
dow_percent_increase = ((stockdata(nRow_end,col_DowPrice)-stockdata(nRow_start,col_DowPrice))/stockdata(nRow_start,col_DowPrice))*100;
nasdaq_percent_increase = ((stockdata(nRow_end,col_NASDAQPrice)-stockdata(nRow_start,col_NASDAQPrice))/stockdata(nRow_start,col_NASDAQPrice))*100;
snp_percent_increase = ((stockdata(nRow_end,col_SnPPrice)-stockdata(nRow_start,col_SnPPrice))/stockdata(nRow_start,col_SnPPrice))*100;
r3000_percent_increase = ((stockdata(nRow_end,col_R3000Price)-stockdata(nRow_start,col_R3000Price))/stockdata(nRow_start,col_R3000Price))*100;
r2000_percent_increase = ((stockdata(nRow_end,col_R2000Price)-stockdata(nRow_start,col_R2000Price))/stockdata(nRow_start,col_R2000Price))*100;
gold_percent_increase = ((stockdata(nRow_end,col_goldPrice)-stockdata(nRow_start,col_goldPrice))/stockdata(nRow_start,col_goldPrice))*100;

%% integrating finding to app
% integrate the finding from the previous part to the app.
app.DOWPercentIncreaseEditField.Value = dow_percent_increase;
app.NASDAQPercentIncreaseEditField.Value = nasdaq_percent_increase;
app.SP500PercentIncreaseEditField.Value = snp_percent_increase;
app.Russell3000PercentIncreaseEditField.Value = r3000_percent_increase;
app.Russell2000PercentIncreaseEditField.Value = r2000_percent_increase;
app.GoldPercentIncreaseEditField.Value = gold_percent_increase;

%% conclusion statement
% if statements to display a conclusion statement that advises the user to
% invest in a specific stock based on the highest percentage increase found
% above.
if (dow_percent_increase > nasdaq_percent_increase) && (dow_percent_increase > snp_percent_increase) && (dow_percent_increase > r3000_percent_increase) && (dow_percent_increase > r2000_percent_increase) && (dow_percent_increase > gold_percent_increase)
    app.ConclusionEditField_2.Value = "You should have invested in DOW!";
elseif (nasdaq_percent_increase > dow_percent_increase) && (nasdaq_percent_increase > snp_percent_increase) && (nasdaq_percent_increase > r3000_percent_increase) && (nasdaq_percent_increase > r2000_percent_increase) && (nasdaq_percent_increase > gold_percent_increase)
    app.ConclusionEditField_2.Value = "You should have invested in NASDAQ!";
elseif (snp_percent_increase > dow_percent_increase) && (snp_percent_increase > nasdaq_percent_increase) && (snp_percent_increase > r3000_percent_increase) && (snp_percent_increase > r2000_percent_increase) && (snp_percent_increase > gold_percent_increase)
    app.ConclusionEditField_2.Value = "You should have invested in S&P 500!";
elseif (r3000_percent_increase > dow_percent_increase) && (r3000_percent_increase > nasdaq_percent_increase) && (r3000_percent_increase > snp_percent_increase) && (r3000_percent_increase > r2000_percent_increase) && (r3000_percent_increase > gold_percent_increase)
    app.ConclusionEditField_2.Value = "You should have invested in Russell 3000!";
elseif (r2000_percent_increase > dow_percent_increase) && (r2000_percent_increase > nasdaq_percent_increase) && (r2000_percent_increase > snp_percent_increase) && (r2000_percent_increase > r3000_percent_increase) && (r2000_percent_increase > gold_percent_increase)
    app.ConclusionEditField_2.Value = "You should have invested in Russell 2000!";
elseif (gold_percent_increase > dow_percent_increase) && (gold_percent_increase > nasdaq_percent_increase) && (gold_percent_increase > snp_percent_increase) && (gold_percent_increase > r3000_percent_increase) && (gold_percent_increase > r2000_percent_increase)
    app.ConclusionEditField_2.Value = "You should have invested in Gold!";
elseif dow_percent_increase == nasdaq_percent_increase == snp_percent_increase == r3000_percent_increase == r2000_percent_increase == gold_percent_increase
    app.ConclusionEditField_2.Value = "All composite index gives the same return for the time period! Invest in any stocks you like!";
else
    app.ConclusionEditField_2.Value = 'You should have invested in nothing!';
end 

end
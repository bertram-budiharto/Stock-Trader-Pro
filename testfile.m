%% test file
clear 
clc

%% load dataset
stockdata = readmatrix('MyMarketData.xlsx');

%% set parameters
start_date = 725990;
end_date = 726010;
start_date_adjusted = datenum(start_date) - 693960;
end_date_adjusted = datenum(end_date) - 693960;
[nRows, ~] = size(stockdata);
col_DowPrice = 2;
col_NASDAQPrice = 3;
col_SnPPrice = 4;
col_R3000Price = 5;
col_R2000Price = 6;
col_goldPrice = 7;

%% row identification
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

numDays = (nRow_end - nRow_start) + 1;
nRow_start_loop = nRow_start;
x = zeros(1,numDays);
for iRows = 1:1:numDays
    x(1,iRows) = stockdata(nRow_start_loop,1); 
    nRow_start_loop = nRow_start_loop + 1;
end 

%% plot increase
plot(x,stockdata(nRow_start:nRow_end,col_DowPrice))
nexttile
plot(x,stockdata(nRow_start:nRow_end,col_NASDAQPrice))
hold on
plot(x,stockdata(nRow_start:nRow_end,col_SnPPrice))
hold on
plot(x,stockdata(nRow_start:nRow_end,col_R3000Price))
hold on
plot(x,stockdata(nRow_start:nRow_end,col_R2000Price))
hold on
plot(x,stockdata(nRow_start:nRow_end,col_goldPrice))
hold off
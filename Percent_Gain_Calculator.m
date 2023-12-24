

function Percent_Gain_Calculator(app) % Identifies the file as a user-defined function for the app to run

A = readmatrix('MyMarketData.xlsx'); %Uploads data
rr = 1;% creates a counter


% % This while loop continously searches for the date of purchase, and does
% not continue if the user does not define one
while rr == 1
        % creates a variable 'REALDOP" to collect the date of purchase
    REALDOP = app.Percent_Gain_Calculator_DOP.Value;  


REALDOPDAY = datenum(REALDOP); % converts the date of purchase to a usable number in days

% if statement to ensure that a day of purchase has been identified, and
% then alters the counter to end the loop once this has been accomplished

if REALDOPDAY >= 3
    rr = 23;
end
pause (0.2) % This pause is added for functionality
end

%creates a counter that will later be used to keep track of which column
%should be searched based on the ticker
columnboi = 0;



%adjusts the date in days from how matlab defines it, starting at 1 AD, to
%how excel defines the date in days, which starts at 1900 AD


REALDOPDAYadjusted = REALDOPDAY - 693960;


nfn = 3; 

while nfn == 3

        %creates a variable that holds the date of sale value

REALDOS = app.Percent_Gain_Calculator_DOS.Value;
REALDOSDAY = datenum(REALDOS); % converts that date of sale into a usable integer

if REALDOSDAY >=3
    nfn = 38; %% This if statement changes the counter variable in order to end the while loop once a date of sale has been established
end
pause(0.2) % creates a pause so the while loop doesn't go too fast and crash computer
end


%adjusts the date in days from how matlab defines it, starting at 1 AD, to
%how excel defines the date in days, which starts at 1900 AD


 REALDOSDAYadjusted = REALDOSDAY - 693960;

%creates a tracker varaible to run loop until a ticker is selected
tt = 0;

while tt == 0


% creates a variable that stores the ticker
TICKER = app.TICKER.Value;

% sets the column based on the ticker 
switch TICKER

    case 'DOW'
columnboi = 2;

    case 'NASDAQ'
columnboi = 3;
    case 'S&P 500'
columnboi = 4;
    case 'SPX'
columnboi = 4;
    case 'Russell 3000'
       columnboi = 5;
    case 'RUA'
columnboi = 5;
    case 'Russell 2000'
columnboi = 6;
    case 'RUT'
columnboi = 6;
    case 'GOLD'
columnboi = 7;
    otherwise
        % just in case there is some error it will display this in the
        % display
        % boxes
        app.PercentIncreaseEditField.Value = 'Error-bad ticker';
        app.TotalProfitEditField.Value = 'Error-bad ticker';
end

if columnboi ~=0  % Makes sure that a column was chosen by ticker, or else it loops again
    tt = 1;
end
pause(0.2); % creates a pause so while loop doesn't crash computer by going too fast
end

%creates an indicator variable 
DOProw = -8;
   
%Determines the correct row of the date of purchase
for xxx = 1:1:8932
    if A(xxx,1) == REALDOPDAYadjusted
        DOProw = xxx;
        

    end
end

%creates an indicator variable 
DOSrow = -9;

%Determines the correct row of the date of sale
for yyy = 1:1:8932
    if A(yyy,1) == REALDOSDAYadjusted
        DOSrow = yyy;
     
    
    end
end




% Identifies if the date is from before the time period of the app
% (shouldn't happen since these dates have been grayed out, but just in
% case something crazy happens it will let the user know.  Also, if the
% user doesn't specify a date to end the period after switching through
% tabs this will also remind them to select an end date

if DOProw <= -1
        app.PercentIncreaseEditField.Value = 'Error-non-trading-day';
        app.TotalProfitEditField.Value = 'Error-non-trading-day';
end


% Finds the relative value of the stock at the day of purchase
DOPrelative = A(DOProw,columnboi);


% Finds the relative value of the stock at the day of sale
DOSrelative = A(DOSrow,columnboi);

% Calculates the percent of profit based on the values at the point of sale
% and purchase which were just previously found
profitPercent = ((DOSrelative / DOPrelative)-1)*100;


 app.PercentIncreaseEditField.Value = num2str(profitPercent);

 % sets two variables equal to each other to serve as a flag
amongus = 70;
sus = amongus;

% This while loop runs until a principal value is inserted that is value
while sus == amongus
% sets 'myPrinciple' equal to the user entered orinciple value
myPrinciple = app.EnterprincipalinvestmentEditField.Value;

if myPrinciple >= 0.0000000000000000001
    sus = 0; % This changes the flag variable so that as long as a positive (valid) principle is inserted the while loop will end
end
pause (0.2) %pause so computer doesn't cycle too much and crash itself
end

% calculates to profit based on the profit percent and the principle
Profitt = myPrinciple * profitPercent*0.01;

%displays the total profit
app.TotalProfitEditField.Value = num2str(Profitt);





% creates the y-values (relative percents) for the sake of graphing
for qwl = DOProw:1:DOSrow
    myYvalues(qwl) = (((A(qwl,columnboi))/(A(DOProw,columnboi)))-1)*100;
end

%creates the values of x, which are the dates in days, for the sake of
%graphing
for nene = DOProw:1:DOSrow
    myXvalues(nene) = A(nene,1);
end

%turns grid on if user in app clicks a checkbox and makes it true
doGrid2 = app.GridCheckBox_4.Value;
if doGrid2  
    grid (app.UIAxes2, "on")
else
    grid (app.UIAxes2, "off")
end
plot(app.UIAxes2, myXvalues(DOProw:end),myYvalues(DOProw:end)); %plots the graph of x and y for the stock index

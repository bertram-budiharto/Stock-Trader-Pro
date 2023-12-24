

function How_Well_Did_Economy_Do(app) % Identifies the file as a user-defined function for the app to run

A = readmatrix('MyMarketData.xlsx'); % loads the data
rr = 1; % creates a counter

doGrid = app.GridCheckBox_3.Value;

if doGrid  
    grid (app.UIAxes2_2, "on")
else
    grid (app.UIAxes2_2, "off")
end




cla(app.UIAxes2_2) % makes sure that the plot is clear for when plotting begins later

% This while loop continously searches for the date of purchase, and does
% not continue if the user does not define one
while rr == 1
    
    % creates a variable 'REALDOP" to collect the date of purchase
    REALDOP = app.DOPLARGE.Value;
REALDOPDAY = datenum(REALDOP); % converts the date of purchase to a usable number in days

    
% if statement to ensure that a day of purchase has been identified, and
% then alters the counter to end the loop once this has been accomplished
if REALDOPDAY >= 3
    rr = 23;
end
pause (0.2)
end




%adjusts the date in days from how matlab defines it, starting at 1 AD, to
%how excel defines the date in days, which starts at 1900 AD

REALDOPDAYadjusted = REALDOPDAY - 693960;


% creates a counter
nfn = 3;


% This while loop continously searches for the date of sale, and does
% not continue if the user does not define one

while nfn == 3

    %creates a variable that holds the date of sale value
REALDOS = app.DOSLARGE.Value;
REALDOSDAY = datenum(REALDOS)+1; % converts that date of sale into a usable integer

if REALDOSDAY >=3
    nfn = 38; %% This if statement changes the counter variable in order to end the while loop once a date of sale has been established
end
pause(0.2)
end

%disp (REALDOS)

%adjusts the date in days from how matlab defines it, starting at 1 AD, to
%how excel defines the date in days, which starts at 1900 AD


 REALDOSDAYadjusted = REALDOSDAY - 693960;


% searches through the dataset's first column, which holds all dates in
% days, in order to find the row that corresponds to the user defined
% date of sale

 for longhaul = 1:1:8932
     if A(longhaul,1) == REALDOSDAYadjusted


 SuperRealDOSDayrow = longhaul; % sets a variable equal to the row that has the correct date of sale
     end
 end



% searches through the dataset's first column, which holds all dates in
% days, in order to find the row that corresponds to the user defined
% date of purchase

  for loonghaul = 1:1:8932
     if A(loonghaul,1) == REALDOPDAYadjusted


 SuperRealDOPDayrow = loonghaul;
 % sets a variable equal to the row that has the correct date of purchase

     end
 end


 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

 % For loop that creates new matrixes containing all of the data for the
 % days inbetween the date of purchase and the date of sale.  For the
 % middle company and large company set it also averages the relative value
 % of the indexes since these categories each contain two indexes, the DOW
 % and S&P for large companies and the NASDAQ and Russell 3000 for medium
 % companies.   This also allows for the time period to start from the user
 % defined date of purchase (or start date for analysis purposes), which allows for this
 %type of economic analysis to be easier to view.  
for dwee = SuperRealDOPDayrow:1:SuperRealDOSDayrow
% creates new matrix for medium sized companies containing the average
% values relative to the initial value of both the NASDAQ and the Russell
% 3000 on the user defined start day all the way to the user defined end
% day
middleCompany(1+dwee-SuperRealDOPDayrow) = (((A(dwee,3))/A(SuperRealDOPDayrow,3)) + ((A(dwee,5))/A(SuperRealDOPDayrow,5)))/2;

% creates new matrix for large sized companies containing the average
% values relative to the initial value of both the DOW and the S&P 500 on the
% user defined start day all the way to the user defined end day
largeCompany(1+dwee-SuperRealDOPDayrow) = (((A(dwee,2))/A(SuperRealDOPDayrow,2)) + ((A(dwee,4))/A(SuperRealDOPDayrow,4)))/2;

% creates new matrix for small sized companies containing just the values
% of the Russell
% 2000 on the user defined start day all the way to the user defined end
% day

littleunCompany(1+dwee-SuperRealDOPDayrow) = ((A(dwee,6))/A(SuperRealDOPDayrow,6)) ;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% finds the user defined start day's row
for xxx = 1:1:8932
    if A(xxx,1) == REALDOPDAYadjusted
        DOProw = xxx;  %sets the 'DOProw' as the row of the date
        else 
        app.PercentIncreaseEditField.Value = 'Error-non-trading-day'; % displays in the visual text boxes that there is an error if something goes wrong
        app.TotalProfitEditField.Value = 'Error-non-trading-day';

    end
end


DOSrow = -9;

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
if DOSrow <= -1
        app.ConclusionEditFieldValueChanging.Value = 'Error-non-trading-day';
end

% Identifies if the date is from before the time period of the app
% (shouldn't happen since these dates have been grayed out, but just in
% case something crazy happens it will let the user know.  Also, if the
% user doesn't specify a date to end the period after switching through
% tabs this will also remind them to select a start date

if DOProw <= -1
        app.ConclusionEditFieldValueChanging.Value = 'Error-non-trading-day';

end



% Defines the average relative price of each grouping of indexes on the
% date the analysis period starts

DOPrelativelittle = littleunCompany(1);
DOPrelativemedium = middleCompany(1);
DOPrelativelarge = largeCompany(1);


% Defines the average relative price of each grouping of indexes on the
% date the analysis period ends


DOSrelativelittle = littleunCompany(SuperRealDOSDayrow-SuperRealDOPDayrow);
DOSrelativemedium = middleCompany(SuperRealDOSDayrow-SuperRealDOPDayrow);
DOSrelativelarge = largeCompany(SuperRealDOSDayrow-SuperRealDOPDayrow);



% Calculates the percent profit (or percent increase) between the user
% defined start and end dates
littleunprofitPercent = (DOSrelativelittle - DOPrelativelittle)*100;
middleunprofitPercent = (DOSrelativemedium - DOPrelativemedium)*100;
bigunprofitPercent = (DOSrelativelarge - DOPrelativelarge)*100;



% displays on the app the percent increase for each group of indexes, or
% 'segments' of the economy
 app.SmallCompanyPercentIncreaseEditField.Value = num2str(littleunprofitPercent);
 app.LargeCompanyPercentIncreaseEditField.Value = num2str(bigunprofitPercent);
 app.MediumCompanyPercentIncreaseEditField.Value = num2str(middleunprofitPercent);


%If statements to perform analysis and determine group of indexes/ segment
%of the economy had the greatest percent increase
if littleunprofitPercent >= middleunprofitPercent
    if littleunprofitPercent >= bigunprofitPercent
        StrattonOakmont = ['Small Companies did the best.'];
    elseif bigunprofitPercent >= littleunprofitPercent
        StrattonOakmont = ['Big Companies did the best.'];
    else
        StrattonOakmont = ['error'];
    end
end

%If statements to perform analysis and determine group of indexes/ segment
%of the economy had the greatest percent increase.  It sets
%'StrattonOakmont' equal to a string that reflects which segment of the
%economy did the best
if middleunprofitPercent >= littleunprofitPercent
    if bigunprofitPercent >= middleunprofitPercent
        StrattonOakmont = ['Big Companies did the best.'];
    elseif middleunprofitPercent >= bigunprofitPercent
    StrattonOakmont = ['Medium Companies did the best.'];
    else
        StrattonOakmont = ['error'];
    end
end

% Determines if all segements of the economy were negative and sets
% 'StrattonOakmont' to a string that reflects this

if middleunprofitPercent<=0 && bigunprofitPercent<=0 && littleunprofitPercent <= 0
    StrattonOakmont = ['The whole economy dumped.'];
end

%Displays the string 'StrattonOakmont' as the conclusion to the analysis
app.Theanswertocompanysizewellquestion.Value = StrattonOakmont;




%Creates all the y values, which are the percent changes, of the small
%companies segment of the economy

for qwl = 1:1:DOSrow-DOProw
    myYvalues4littluns(qwl) = (littleunCompany(qwl)-1)*100;
end

%Creates all the y values, which are the percent changes, of medium sized 
%companies segment of the economy
for saka = 1:1:DOSrow-DOProw
    myYvalues4middleuns(saka) = (middleCompany(saka)-1)*100;
end

%Creates all the y values, which are the percent changes, of the large
%companies segment of the economy
for buns = 1:1:DOSrow-DOProw
    myYvalues4bigguns(buns) = (largeCompany(buns)-1)*100;
end





% I changed this to be days since purchase rather than days since 0 or 1900
% This creates the number of days per each y value, which will serve as the
% x axis
for nene = 1:1:DOSrow-DOProw
    myXvalues(nene) = nene + DOProw;
end


plot(app.UIAxes2_2, myXvalues(1:end),myYvalues4littluns(1:end),"-g")% Plots the percent change relative to the first day of the user defined period for analysis of the little companies segment of the economy



hold(app.UIAxes2_2, 'on') % holds the plot on so that the other segments of the economy can have their percent change be graphed as well


plot(app.UIAxes2_2, myXvalues(1:end),myYvalues4middleuns(1:end),"-r")% Plots the percent change relative to the first day of the user defined period for analysis of the middle companies segment of the economy

plot(app.UIAxes2_2, myXvalues(1:end),myYvalues4bigguns(1:end),"-k")% Plots the percent change relative to the first day of the user defined period for analysis of the large companies segment of the economy


legend(app.UIAxes2_2, 'Small Companies','Medium Companies','Large Companies'); % Creates a legend to tell the user what segment of the economy is being graphed in which color




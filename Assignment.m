%Data on the evolution of Australian student debt burdens 
sdebt_data = readtable("HELP_2023_2024.xlsx");

sdebt_data_t1 = readtable('HELP_2023_2024.xlsx', 'Sheet', 2, 'Range', 'A4:I23');
%Clean the column names 
sdebt_data_t1.Properties.VariableNames = {'Year', 'TotalIncurredDebt', 'Indexation', 'CompulsoryRepayments', 'OSLevyCompulsoryRepayments', 'VoluntaryRepaymentsMade', 'VoluntaryRepayments', 'BonusOnVoluntaryRepayments', 'ValueOfDebtsWritenOff'};


%Plot the trend of total student debt from 2013 to 2024
x = extractBefore(sdebt_data_t1.Year, ' ');
x = str2double(x);
y = sdebt_data_t1.TotalIncurredDebt;

figure;
plot(x, y)
xlabel('Year')
ylabel('Total Incurred Debt')
title('Total Student Debt Trend From 2005 to 2023')
grid on

%Plot the trend of outstanding debt per person from 2014 to 2023
sdebt_data_t9 = readtable("HELP_2023_2024.xlsx", 'Sheet', 10, 'Range', 'A1:B11');

% Extract the base value from 2014
base_value = sdebt_data_t9.OutstandingDebtPerPerson(sdebt_data_t9.Year == 2014);

% Compute log-percentage change relative to 2014 (base = 0)
sdebt_data_t9.LogPctChange = log(sdebt_data_t9.OutstandingDebtPerPerson / base_value) * 100;

figure;
plot(sdebt_data_t9.Year, sdebt_data_t9.LogPctChange, '-o', 'Color', 'r', 'LineWidth', 2)
xlabel('Year')
ylabel('% Change for Student Debt Per Person')
title('Trend of % Change of Student Debt Per Person (2014-2023)')
grid on

%Data on the education wage premium in Australia from 2019 to 2024
wage_edu_data = readtable("Median_weekly_earnings_by_educational_ qualification.xlsx");

wage_edu_data.Properties.VariableNames = {'_', 'Aug_2019', 'Aug_2024'};

wage_edu_data = rmmissing(wage_edu_data); %Clean off missing value rows

selected = wage_edu_data(:, {'Aug_2019', 'Aug_2024'});
figure;
bar(table2array(selected), 'grouped')
legend({'Aug 2019', 'Aug 2024'})
xticklabels({'Postgraduate', 'Graduate Diploma', 'Bachelor', 'Diploma', 'Certificate III/IV', 'Certificate I/II And Other', 'No Qualifications'})
xtickangle(45)
xlabel('Qualification')
ylabel('Median weekly wage')
title('Median weekly wage by educational attainment from 2019 to 2024')
grid on

%Data on skill wage premium in Aussie from 2019 to 2024 
wage_skill_data = readtable("Median_hourly_earnings_by_occupation_and skill_level.xlsx");

wage_skill_data = rmmissing(wage_skill_data); %Clean off missing value rows

wage_skill_data.Properties.VariableNames = {'_', 'Aug_2019', 'Aug_2024'};

selected = wage_skill_data(:, {'Aug_2019', 'Aug_2024'});
figure;
b = bar(table2array(selected), 'grouped');
b(1).FaceColor = [0.1 0.6 0.3];  
b(2).FaceColor = [0.1 0.2 0.2];  
legend({'Aug 2019', 'Aug 2024'})
xticklabels({'Managers', 'Professionals', 'Clerks and Admins', 'Technicians and Trader Workers', ...
    'Machinery Operators', 'Community and Social Workers', 'Sales', 'Laborers', ...
    'Highest Skill', 'Moderately High Skill', 'Moderate Skill', 'Moderately Low Skill', 'Low Skill'})
xtickangle(30)
xlabel('Occupation and Skill Level')
ylabel('Median hourly wage')
title('Median hourly wage by occupation and skill level from 2019 to 2024')
grid on

